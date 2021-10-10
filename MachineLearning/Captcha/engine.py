from tqdm import tqdm
import torch
import config


def train(model, data_loader, optimizer):
    model.train()
    fin_loss = 0
    tk = tqdm(data_loader, total=len(data_loader))

    for data in tk:
        for k, v in data.items():
            data[k] = v.to(config.DEVICE)
        optimizer.zero_grad()
        _, loss = model(**data)
        loss.backward()
        optimizer.step()
        fin_loss += loss
    return fin_loss / len(data_loader)


def eval(model, data_loader):
    model.eval()
    fin_loss = 0
    fin_preds = []
    tk = tqdm(data_loader, total=len(data_loader))

    with torch.no_grad():
        for data in tk:
            for k, v in data.items():
                data[k] = v.to(config.DEVICE)
            batch_preds, loss = model(**data)
            fin_loss += loss
            fin_preds.append(batch_preds.detach().cpu())

    return fin_preds, fin_loss / len(data_loader)
