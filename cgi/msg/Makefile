all: perltidy

NCPU=`../../world/bin/ncpu`
ALL=??

perltidy:
	echo ${ALL} | xargs -n1 -P${NCPU} -E " " perl -I. -T -cw 
	echo ${ALL} | xargs -n2 -P${NCPU} -E " " perltidy -b -l=400

distclean: clean

clean:
	rm -f *.bak

help:
	@echo "make [ perltidy | clean ]"
