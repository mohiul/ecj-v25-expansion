#!/bin/bash
#PBS -l walltime=20:00:00
#PBS -l nodes=1:ppn=8

cd ecj-keijzer6-addInd-Fv/src/
/home/mohiul/jdk1.8/bin/java ec.Evolve -file ec/app/regression/benchmark.params -Xmx10240m
