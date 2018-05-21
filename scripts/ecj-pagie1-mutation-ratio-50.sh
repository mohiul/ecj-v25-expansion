#!/bin/bash

for number in {1..50}
do
	qsub ecj-pagie1-mu5xo95.sh
	qsub ecj-pagie1-mu10xo90.sh
	qsub ecj-pagie1-mu15xo85.sh
	qsub ecj-pagie1-mu20xo80.sh
	qsub ecj-pagie1-mu25xo75.sh
done