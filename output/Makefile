# 'Makefile'
all: $(patsubst %.md,%.html,$(wildcard *.md)) Makefile

clean:
	rm -f $(patsubst %.md,%.html,$(wildcard *.md))
	rm -f *.bak *~

%.html: %.md
	R --vanilla --slave --args $< $@ < convert.R
