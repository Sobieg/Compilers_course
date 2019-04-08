from glob import glob
import subprocess


prog = "./a.out"
files = glob("tests/*.lua")



processes = []

for file in files:
	args = ["python3", "worker.py", file]
	proc = subprocess.Popen(args)
	processes.append(proc)

# for proc in processes:
# 	data = proc.communicate()
# 	for line in data:
# 		if (line):
# 			print(line.decode("utf-8"))