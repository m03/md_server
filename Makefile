# Set variables

SHELL := /bin/bash

PACKAGE_VERSION := $(shell cat VERSION)

## Source files

MAIN_SRC_DIR = .

MAIN_PYC_FILES := $(shell find $(MAIN_SRC_DIR) -name "*.pyc")

# General targets
#

.DEFAULT_GOAL := all

.PHONY: all clean clean_dist clean_logs clean_pyc rpm sdist wheel

all: clean test rpm wheel

clean: clean_dist clean_logs clean_pyc

clean_dist:
	-rm -r .Python env/ build/ develop-eggs/ dist/ eggs/ .eggs/ lib/ lib64/ parts/ sdist/ var/ *.egg-info/ .installed.cfg *.egg .eggs wheelhouse/*.whl

clean_logs:
	-rm $(shell find . -name '*.log')

clean_pyc:
	-rm -r $(MAIN_PYC_FILES)

rpm:
	python setup.py bdist_rpm
	rpm -ivh dist/mdserver-$(PACKAGE_VERSION).noarch.rpm

sdist:
	python setup.py sdist

wheel: clean_dist sdist
	python setup.py bdist_wheel
