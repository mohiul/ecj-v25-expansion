#!/bin/bash
#PBS -l walltime=8:00:00
#PBS -l nodes=1:ppn=8

cd git/ecj-mcts/src/
/home/mohiul/jdk1.8/bin/java ec.Evolve -file ec/app/regression/pagie1-ex5re15xo80.params -Xmx10240m
