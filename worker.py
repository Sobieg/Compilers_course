import sys
import subprocess
import filecmp


prog = "./a.out"
#prog = "ping"
file = open(sys.argv[1])


proc = subprocess.Popen(prog, stdout=subprocess.PIPE, stdin=subprocess.PIPE, stderr=subprocess.PIPE)
lines = ""
for line in file:
	lines = lines + line
data = proc.communicate(input=str.encode(lines))

outfile = "results/"
etfile = "etalon/"
name = sys.argv[1][len("tests/"):] + ".result"
outfile = outfile + name
etfile = etfile + name
output = open(outfile, "w+")
for line in data:
	if line:
		newline = line.decode('utf')
		output.write(newline)

output.close()

if not filecmp.cmp(outfile, etfile, False):
	log = open("errors.log", "a+")
	log.write(name + "\n")
	log.close()


