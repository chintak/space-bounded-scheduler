#!/bin/bash

#SBATCH -J Test16
#SBATCH -o test.o%j
#SBATCH -n 1
#SBATCH -p serial
#SBATCH -t 10:00:00
#SBATCH --mail-user=chintak.sheth@stonybrook.edu
#SBATCH --mail-type=begin
#SBATCH --mail-type=end

logname=$WORK/space-bounded-scheduler/logs/$1_output_$2
#echo "  L1_TCM,   L2_TCM,   L3_TCM,   L1_DCM" > $logname
echo "---------------------------------------------" > $logname
PERF='perf stat -e L1-dcache-loads,L1-dcache-load-misses,LLC-loads,LLC-load-misses,ref-cycles --append -r 1'
bin="$PERF -o $logname ./matMul"
# $bin 2 32  &>> $logname
# $bin 2 64  &>> $logname
# $bin 2 128  &>> $logname
# $bin 2 256  &>> $logname
# $bin 2 512  &>> $logname
# $bin 2 1024  &>> $logname
# $bin 2 2048  &>> $logname
$bin 2 4096  &>> $logname
$bin W 4096  &>> $logname
$bin 2 8192  &>> $logname
$bin W 8192  &>> $logname
$bin 2 16384  &>> $logname
$bin W 16384  &>> $logname
$bin 2 65536  &>> $logname
$bin W 65536  &>> $logname

# bin=matMul
# echo "========== $bin ==========" >> $logname
# echo "----------   WS  ----------" >> $logname
# ./$bin W    &>> $logname
# echo "----------  PWS  ----------" >> $logname
# ./$bin P    &>> $logname
# echo "----------  HR2  ----------" >> $logname
# ./$bin 2    &>> $logname
# echo "----------  HR5  ----------" >> $logname
# ./$bin 5    &>> $logname

# bin=RRM
# echo "========== $bin ==========" >> $logname
# echo "----------   WS  ----------" >> $logname
# ./$bin W    &>> $logname
# echo "----------  PWS  ----------" >> $logname
# ./$bin P    &>> $logname
# echo "----------  HR2  ----------" >> $logname
# ./$bin 2    &>> $logname
# echo "----------  HR5  ----------" >> $logname
# ./$bin 5    &>> $logname

# bin=RRG
# echo "========== $bin ==========" >> $logname
# echo "----------   WS  ----------" >> $logname
# ./$bin W    &>> $logname
# echo "----------  PWS  ----------" >> $logname
# ./$bin P    &>> $logname
# echo "----------  HR2  ----------" >> $logname
# ./$bin 2    &>> $logname
# echo "----------  HR5  ----------" >> $logname
# ./$bin 5    &>> $logname

# bin=quadTreeSort
# echo "========== $bin ==========" >> $logname
# echo "----------   WS  ----------" >> $logname
# ./$bin W    &>> $logname
# echo "----------  PWS  ----------" >> $logname
# ./$bin P    &>> $logname
# echo "----------  HR2  ----------" >> $logname
# ./$bin 2    &>> $logname
# echo "----------  HR5  ----------" >> $logname
# ./$bin 5    &>> $logname

# bin=quickSort
# echo "========== $bin ==========" >> $logname
# echo "----------   WS  ----------" >> $logname
# ./$bin W    &>> $logname
# echo "----------  PWS  ----------" >> $logname
# ./$bin P    &>> $logname
# echo "----------  HR2  ----------" >> $logname
# ./$bin 2    &>> $logname
# echo "----------  HR5  ----------" >> $logname
# ./$bin 5    &>> $logname

# bin=awareSampleSort
# echo "========== $bin ==========" >> $logname
# echo "----------   WS  ----------" >> $logname
# ./$bin W    &>> $logname
# echo "----------  PWS  ----------" >> $logname
# ./$bin P    &>> $logname
# echo "----------  HR2  ----------" >> $logname
# ./$bin 2    &>> $logname
# echo "----------  HR5  ----------" >> $logname
# ./$bin 5    &>> $logname

# bin=sampleSort
# echo "========== $bin ==========" >> $logname
# echo "----------   WS  ----------" >> $logname
# ./$bin W    &>> $logname
# echo "----------  PWS  ----------" >> $logname
# ./$bin P    &>> $logname
# echo "----------  HR2  ----------" >> $logname
# ./$bin 2    &>> $logname
# echo "----------  HR5  ----------" >> $logname
# ./$bin 5    &>> $logname

echo "--------- Ended --------" >> $logname
echo `date` >> $logname
