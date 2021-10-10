import os
import glob
import torch
import numpy as np

from sklearn import preprocessing, model_selection, metrics
from pprint import pprint
import config
import dataset
from model import CaptchaModel
import engine


def naive_decode(preds, encoder):
    preds = preds.permute(1, 0, 2)
    preds = torch.softmax(preds, 2)
    preds = torch.argmax(preds, 2)
    preds = preds.detach().cpu().numpy()
    cap_preds = []
    for i in range(preds.shape[0]):
        temp = []
        for k in preds[i, :]:
            k -= 1
            if k == -1:
                temp.append('~')
            else:
                temp.append(encoder.inverse_transform([k])[0])
        tp = "".join(x for x in temp if x != "~")
        cap_preds.append(tp)

    return cap_preds


def run_training():

    image_files = glob.glob(os.path.join(config.DATA_DIR, "*.png"))
    targets_orig = [x.split('/')[-1][:-4] for x in image_files]
    targets = [[c for c in x] for x in targets_orig]
    # Flattens the target
    targets_flat = [c for clist in targets for c in clist]

    lbl_enc = preprocessing.LabelEncoder()
    lbl_enc.fit(targets_flat)

    targets_enc = [lbl_enc.transform(x) for x in targets]
    targets_enc = np.array(targets_enc) + 1

    train_imgs, test_imgs, train_targets, test_targets, _, test_orig_targets = model_selection.train_test_split(
        image_files, targets_enc, targets_orig, test_size=0.1, random_state=17)

    train_dataset = dataset.ClassficationDataset(
        image_paths=train_imgs, targets=train_targets, resize=(config.IMAGE_HEIGHT, config.IMAGE_WIDTH))

    train_loader = torch.utils.data.DataLoader(
        train_dataset, batch_size=config.BATCH_SIZE, num_workers=config.NUM_WORKERS, shuffle=True)

    test_dataset = dataset.ClassficationDataset(
        image_paths=test_imgs, targets=test_targets, resize=(config.IMAGE_HEIGHT, config.IMAGE_WIDTH))

    test_loader = torch.utils.data.DataLoader(
        test_dataset, batch_size=config.BATCH_SIZE, num_workers=config.NUM_WORKERS, shuffle=False)

    model = CaptchaModel(num_chars=len(lbl_enc.classes_))
    model.to(config.DEVICE)

    optimizer = torch.optim.Adam(model.parameters(), lr=3e-4)
    scheduler = torch.optim.lr_scheduler.ReduceLROnPlateau(
        optimizer, factor=.8, patience=5, verbose=True)

    for epoch in range(config.EPOCHS):
        print(f"Epoch: {epoch}")
        train_loss = engine.train(model, train_loader, optimizer)

        scheduler.step(train_loss)

        val_preds, val_loss = engine.eval(model, test_loader)
        print(f"Train Loss: {train_loss} , Validation Loss: {val_loss}")
        val_cap_pred = []

        for vp in val_preds:
            current_preds = naive_decode(vp, lbl_enc)
            val_cap_pred.extend(current_preds)
        pprint(list(zip(test_orig_targets, val_cap_pred))[5:11])


if __name__ == "__main__":
    run_training()
