#!/bin/bash
#PBS -l walltime=25:00:00
#PBS -l nodes=1:ppn=8

cd git/ecj-mcts/src/
/home/mohiul/jdk1.8/bin/java ec.Evolve -file ec/app/regression/pagie1-ex20xo80dist8sim8.params -Xmx10240m
