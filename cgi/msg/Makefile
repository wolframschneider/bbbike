all: perltidy

perltidy:
	for i in ??; do perl -cw $$i; done
	perltidy -b -l=400 ??

clean:
	rm -f *.bak

