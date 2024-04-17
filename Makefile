BUILD_DIR = ./build

PRJ = playground

FIRRTL=${shell pwd}/firtool-1.37.0
PATH:=${PATH}:${FIRRTL}/bin/

firtool:${FIRRTL}
	wget -O - https://github.com/llvm/circt/releases/download/firtool-1.37.0/firrtl-bin-ubuntu-20.04.tar.gz | tar -xzf - -C .

test:
	mill -i $(PRJ).test

verilog:${FIRRTL}
	$(call git_commit, "generate verilog")
	mkdir -p $(BUILD_DIR)
	mill -i $(PRJ).runMain Elaborate --target-dir $(BUILD_DIR)

help:
	mill -i $(PRJ).runMain Elaborate --help

reformat:
	mill -i __.reformat

checkformat:
	mill -i __.checkFormat

clean:
	-rm -rf $(BUILD_DIR)

.PHONY: test verilog help reformat checkformat clean

sim:
	$(call git_commit, "sim RTL") # DO NOT REMOVE THIS LINE!!!
	@echo "Write this Makefile by yourself."

-include ../Makefile
