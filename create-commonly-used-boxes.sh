#!/bin/bash

function test_delete_random
{
	ls box/*/*.box | shuf | head -1 | xargs -I% -r mv % %.1
}

function create_todo
{
	find box -iname *.box >donelist.txt
	cut -d/ -f3- donelist.txt | cut -d\- -f1-3 >matchlist.txt
	[ ! -s matchlist.txt ] && date +%s >matchlist.txt
	grep -v -f matchlist.txt vmlist.txt >todolist.txt
}

function clear_old_vms
{
	vm_wo_provider=$1

	handle -nobanner $vm_wo_provider |
		sed -n 's,.* pid: \([0-9]*\).*,\1,p' | xargs -r kill -9
	vboxmanage list vms |
		grep -E "<inaccessible>|$vm_wo_provider" |
		sed -n 's/.*{\(.*\)}/\1/p' |
		while read uuid
		do
			vboxmanage controlvm $uuid poweroff 2>&1 |
				grep -v 'is not currently running'
			vboxmanage unregistervm $uuid --delete
		done
}

function clear_old_settings_file
{
	logfile="$1"

	vbf=".*Machine settings file '\(.*\)' already exists"
	{
		sed -n "s/$vbf/\1/p" $logfile |
			sort -u | sed 's,\\,/,g' |
			while read path
			do
				echo rm $path
			done
	} | bash
}

function main
{
	mkdir -p logs
	create_todo
	for vm in `cat todolist.txt|grep -v ^\#`
	do
		vm_wo_provider="${vm//virtualbox\//}"
		clear_old_vms $vm_wo_provider
		T="$(date +%s)"
		makelog=logs/make.$vm_wo_provider.$(date +%m-%d-%A_%H_%M_%S).log
		make $vm 2>&1 | tee $makelog
		ps=${PIPESTATUS[0]} #http://stackoverflow.com/a/1221870/1495086 
		T="$(($(date +%s)-T))"
		maketime=$(printf "%02dh%02dm\n" "$((T/3600))" "$((T/60%60))")
		if [ $ps -ne 0 ]
		then
			subject="$maketime fail $vm_wo_provider (packer)"
			cat $makelog |
				email --subject "$subject" ${email:-taylor}
			echo [`date`] fail $maketime $vm >>vmlist.log
			git add vmlist.log && git commit -m time
			clear_old_settings_file $makelog
		else
			subject="$maketime pass $vm_wo_provider (packer)"
			email --blank-mail --subject "$subject" ${email:-taylor}
			echo [`date`] pass $maketime $vm >>vmlist.log
		fi
#		test_delete_random
		create_todo
		sleep 10
	done
}


# run from windows task schedular will use cmd.exe find instead of
# cygwin /bin/find otherwise
PATH=/bin:$PATH

# Add lock to ensure only one copy of this scripts runs at a time

LOCKFILE=/tmp/$(basename "$0").lock
if [ -e ${LOCKFILE} ] && kill -0 `cat ${LOCKFILE}`; then
    echo "already running"
    exit
fi

# make sure the lockfile is removed when we exit and then claim it
trap "rm -f ${LOCKFILE}; exit" INT TERM EXIT
echo $$ >${LOCKFILE}

vboxmanage setextradata global GUI/SuppressMessages "all"

main

rm -f make_time.$$.txt
rm -f ${LOCKFILE}
