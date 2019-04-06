from glob import glob
import subprocess


prog = "./a.out"
files = glob("tests/*.lua")

for arg in files:
	args = ["./a.out"]
	popen = subprocess.Popen(args, stdout=subprocess.PIPE, stdin=subprocess.PIPE)
	testfile = open(arg, "r")
	lines = testfile.readlines()
	for x in lines:
		popen.stdin.write(bytes(x, 'utf-8'))
	popen.wait()
	output = popen.stdout.read();
	print(output)
