#!/bin/bash
#PBS -l walltime=4:00:00
#PBS -l nodes=1:ppn=8

cd git/ecj-mcts/src/
/home/mohiul/jdk1.8/bin/java ec.Evolve -file ec/app/regression/pagie1-expMaxDistance40.params -Xmx10240m
