# get Makefile directory name: http://stackoverflow.com/a/5982798/376773
THIS_MAKEFILE_PATH:=$(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
THIS_DIR:=$(shell cd $(dir $(THIS_MAKEFILE_PATH));pwd)

BIN_DIR := $(HOME)/bin

symlinks:
	ln -sf $(THIS_DIR)/git-purge/git-purge.sh $(BIN_DIR)/git-purge
