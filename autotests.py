from glob import glob
import subprocess
import filecmp
import os.path


prog = "./a.out"
files = glob("tests/*.lua")



processes = []

for file in files:
	args = ["python3", "worker.py", file]
	proc = subprocess.Popen(args)
	processes.append(proc)

for proc in processes:
	proc.wait()



if os.path.exists("errors.log"):
	print("There is errors: ")
	with open("errors.log", "r") as err:
		for line in err:
			print(line, end='')