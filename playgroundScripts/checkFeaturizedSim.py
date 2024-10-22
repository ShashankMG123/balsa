import torch
path = "/users/smgiridh/balsa/wandb/run-20240913_164612-siua0uiz/files/checkpoint.pt"
try:
    with open(path, 'rb') as f:
        ckpt = torch.load(path,
                              map_location=lambda storage, loc: storage)
except Exception as e:
    print("hahahahah")

print("Somehting to check data")