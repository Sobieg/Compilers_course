import sys
import subprocess


prog = "./a.out"
#prog = "ping"
file = open(sys.argv[1])


proc = subprocess.Popen(prog, stdout=subprocess.PIPE, stdin=subprocess.PIPE)
lines = ""
for line in file:
	lines = lines + line
data = proc.communicate(input=str.encode(lines))

outfile = "results/"
outfile = outfile + sys.argv[1][len("tests/"):] + ".result"
output = open(outfile, "w+")
for line in data:
	if line:
		output.write(line.decode('utf'))


