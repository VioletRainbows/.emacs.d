CURRENT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

compile:
	emacs -Q --batch --eval '(byte-recompile-directory "$(CURRENT_DIR)" 0)'

clean:
	find . -name "*.elc" -type f -delete

.PHONY: compile clean
