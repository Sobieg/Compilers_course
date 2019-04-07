from glob import glob
import subprocess


prog = "./a.out"
files = glob("tests/*.lua")


args = ["ping", "-t", "4", "google.com"]
proc = subprocess.Popen(args, stdout=subprocess.PIPE)

data = proc.communicate()
for line in data:
	if (line):
		print(line.decode("utf-8"))