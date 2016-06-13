from subprocess import Popen, PIPE
from sys import stdout, stderr, argv, exit
import sys

TEST_FILE_NAME = "1element.txt"

with open(TEST_FILE_NAME, "w") as F:
    F.write("1")

for method in ('c', 'd'):
    for seed in range(1, 101):
        p = Popen(["bash", "./runcollide.sh", method, str(seed)],
                  stdout=PIPE, stderr=None)
        cnt = 0
        lines = p.stdout.read()
        lines = lines.decode("cp437").splitlines()
        for line in lines:
            if "Looking for:" in line:
                cnt += 1
                s = line.split("starting in ")[1]
                s = s.split()[0]
                s = s[:-1]
                if s != '0':
                    print("ERROR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!", line)
                    print(s)
                    exit(1)
        if cnt == 0:
            print("CNT == 0 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
            exit(1)
        print("Passed!", method, "seed:", seed)
