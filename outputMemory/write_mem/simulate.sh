#!/bin/sh

xvlog -sv *.sv
xvlog *.v
xelab testbench -timescale 1ns/1ps -debug all
xsim testbench -g
