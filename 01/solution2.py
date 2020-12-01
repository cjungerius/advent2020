import numpy as np
import time

t = time.time()
input = np.loadtxt("./input.txt", dtype=np.int64)

length = np.size(input)

M = np.zeros((length, length, length))
for i in range(length):
    for j in range(length):
        for k in range(length):
            M[i,j,k] = input[i] + input[j] + input[k]

idx = np.where(M==2020)
solution = input[idx[0][0]] * input[idx[1][0]] * input[idx[2][0]]
elapsed = time.time() - t
print(solution)
print("elapsed time: ", elapsed)