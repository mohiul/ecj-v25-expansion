#!/bin/bash

for number in {1..50}
do
	for d in 3 5 8 10
	do
		for s in 1 3 5 8 10
		do
			qsub ecj-pagie1-ex5xo95dist"$d"sim"$s".sh
			qsub ecj-pagie1-ex10xo90dist"$d"sim"$s".sh
			qsub ecj-pagie1-ex15xo85dist"$d"sim"$s".sh
			qsub ecj-pagie1-ex20xo80dist"$d"sim"$s".sh
			qsub ecj-pagie1-ex25xo75dist"$d"sim"$s".sh
		done	
	done
done