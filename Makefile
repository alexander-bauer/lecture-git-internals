.PHONY: all clean

git.html: git.md slides.css
	pandoc --standalone --to dzslides $^ --output $@

all: git.html

clean:
	rm -rf *.html
