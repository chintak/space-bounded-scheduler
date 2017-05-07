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
bin="$PERF -o $logname"
declare -a sched=("W" "2" "6")

for i in "${sched[@]}"; do
    $bin ./matMul $i 5120 &>> $logname
done

for i in "${sched[@]}"; do
    $bin ./quickSort $i 100000000 &>> $logname
done

for i in "${sched[@]}"; do
    $bin ./sampleSort $i 100000000 &>> $logname
done

for i in "${sched[@]}"; do
    $bin ./awareSampleSort $i 100000000 &>> $logname
done

for i in "${sched[@]}"; do
    $bin ./quadTreeSort $i 100000000 &>> $logname
done

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
