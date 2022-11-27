#!/bin/sh

xvlog -sv *.sv
xelab testbench -timescale 1ns/1ps -debug all
xsim testbench -g
