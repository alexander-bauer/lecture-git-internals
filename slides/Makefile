.PHONY: all clean

%.html: %.md
	pandoc --standalone --to dzslides $^ --output $@

all: git.html

clean:
	rm -rf *.html
