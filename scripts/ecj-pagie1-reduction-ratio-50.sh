#!/bin/bash

for number in {1..50}
do
	qsub ecj-pagie1-ex14re1xo85.sh
	qsub ecj-pagie1-ex10re5xo85.sh
	qsub ecj-pagie1-ex5re10xo85.sh
	qsub ecj-pagie1-ex5re15xo80.sh
	qsub ecj-pagie1-ex10re10xo80.sh
	qsub ecj-pagie1-ex15re5xo80.sh
	qsub ecj-pagie1-ex19re1xo80.sh
	qsub ecj-pagie1-ex24re1xo75.sh
	qsub ecj-pagie1-ex20re5xo75.sh
	qsub ecj-pagie1-ex15re10xo75.sh
	qsub ecj-pagie1-ex10re15xo75.sh
	qsub ecj-pagie1-ex5re20xo75.sh
done