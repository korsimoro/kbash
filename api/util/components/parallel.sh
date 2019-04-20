#!/bin/bash
# Try to run stuff in parallel

run_one() (
	#echo "RUN ONE" $@
	cd $1
	local LOG=$2
	shift 2
	#echo "RUNNING $@ in $1"
	$@  > $SHELL_PREFIX_LOGS/$LOGFILENAME 2>&1
)
run_batch_packages_job() (
	local CMD="$1"
	local SCOPE="$2"
	local ELT_LIST="$3"
	local BASE="$4"

	local MAX=$SHELL_PREFIX_MAX_PARALLEL
	if [ $MAX = 1 ]; then
		for x in $ELT_LIST; do
			echo "$SCOPE:$x -> $CMD"
			cd $BASE/$x && $CMD > $SHELL_PREFIX_LOGS/$SCOPE-$x.log 2>&1
		done
	else
		local pids=[]
		local COUNT=0
		local FAIL=0
		echo "$SCOPE:run_batch_packages_job $CMD, parallel running of :"
		for x in $ELT_LIST; do
			local LOGFILENAME="$(slugify $SCOPE $x $CMD).log"
			echo "   $x -> $CMD , logs $SHELL_PREFIX_LOGS/$LOGFILENAME"
			#cd $BASE/$x && $CMD > $SHELL_PREFIX_LOGS/$LOGFILENAME 2>&1 &
			run_one "$BASE/$x" "$SHELL_PREFIX_LOGS/$LOGFILENAME" $CMD &
			pids[${i}]=$!
			COUNT=$(expr $COUNT + 1 )
			if [ $(expr $COUNT % $MAX ) == 0 ]; then
				echo
				# wait for all pids
				for pid in ${pids[*]}; do
				    wait $pid || let "FAIL+=1"
				done
				pids=[]
				if [ "0" = "$FAIL" ]; then
					echo "Continuing run_batch_packages_job $CMD for $SCOPE : "
				else
					echo "Failed"
					exit -1
				fi
			fi
		done
		echo
		for pid in ${pids[*]}; do
				wait $pid || let "FAIL+=1"
		done
		if [ "0" = "$FAIL" ]; then
			exit 0
		else
			echo "Failed"
			exit -1
		fi

	fi
)
