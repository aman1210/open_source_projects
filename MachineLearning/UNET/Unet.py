import torch
import torch.nn as nn


def double_conv(in_ch, out_ch):
    d_conv = nn.Sequential(
        nn.Conv2d(in_ch, out_ch, kernel_size=3),
        nn.ReLU(inplace=True),
        nn.Conv2d(out_ch, out_ch, kernel_size=3),
        nn.ReLU(inplace=True)
    )
    return d_conv


def up_conv(in_ch, out_ch):
    return nn.ConvTranspose2d(in_ch, out_ch, kernel_size=2, stride=2)


def crop_tesnor(inp_tensor, tag_tensor):
    inp_tensor_size = inp_tensor.shape[2]
    tag_tensor_size = tag_tensor.shape[2]

    diff = inp_tensor_size - tag_tensor_size
    # as cropping is done from all the sides
    diff //= 2
    return inp_tensor[:, :, diff: inp_tensor_size - diff, diff: inp_tensor_size - diff]


class UNet(nn.Module):
    def __init__(self, in_ch=1):
        super(UNet, self).__init__()

        self.max_pool_2 = nn.MaxPool2d(kernel_size=2, stride=2)
        self.down_conv_1 = double_conv(in_ch, 64)
        self.down_conv_2 = double_conv(64, 128)
        self.down_conv_3 = double_conv(128, 256)
        self.down_conv_4 = double_conv(256, 512)
        self.down_conv_5 = double_conv(512, 1024)

        self.up_conv_1 = up_conv(1024, 512)
        self.up_dconv_1 = double_conv(1024, 512)
        self.up_conv_2 = up_conv(512, 256)
        self.up_dconv_2 = double_conv(512, 256)
        self.up_conv_3 = up_conv(256, 128)
        self.up_dconv_3 = double_conv(256, 128)
        self.up_conv_4 = up_conv(128, 64)
        self.up_dconv_4 = double_conv(128, 64)

        self.out = nn.Conv2d(64, 2, kernel_size=1)

    def forward(self, image):
        # image: bs, c, h, w
        # Encoder
        x1 = self.down_conv_1(image)  # .
        x2 = self.max_pool_2(x1)
        x3 = self.down_conv_2(x2)  # .
        x4 = self.max_pool_2(x3)
        x5 = self.down_conv_3(x4)  # .
        x6 = self.max_pool_2(x5)
        x7 = self.down_conv_4(x6)  # .
        x8 = self.max_pool_2(x7)
        x9 = self.down_conv_5(x8)

        # Decoder
        x = self.up_conv_1(x9)
        y = crop_tesnor(x7, x)
        x = self.up_dconv_1(torch.cat([x, y], dim=1))
        x = self.up_conv_2(x)
        y = crop_tesnor(x5, x)
        x = self.up_dconv_2(torch.cat([x, y], dim=1))
        x = self.up_conv_3(x)
        y = crop_tesnor(x3, x)
        x = self.up_dconv_3(torch.cat([x, y], dim=1))
        x = self.up_conv_4(x)
        y = crop_tesnor(x1, x)
        x = self.up_dconv_4(torch.cat([x, y], dim=1))

        # output
        x = self.out(x)
        print(x.shape)


if __name__ == "__main__":
    image = torch.randn((1, 1, 572, 572))
    model = UNet()
    print(model(image))