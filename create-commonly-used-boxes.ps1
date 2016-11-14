$ErrorActionPreference = 'SilentlyContinue'

function doit($vm)
{
	if(2 -ne $vm.Split("/").Count) # expect format provider/vmname
	{
		continue
	}
	
	$done = "." + $vm.replace("/","-") 
	if(test-path $done) # file .provider-vmname already exists
	{
		continue
	}

	$time = Measure-Command {
		make $vm | out-default
	}
	email --blank-mail --subject "Packer is done with $vm" taylor
	$null >$done
}

# main
$todo_list = "vmlist.txt"

if(!test-patth $todo_list)
{
	Write-Host "Can't find $todo_list, quitting"
	Exit
}

$vms = (Get-Content -Path $todo_list | Where {$_ -notmatch '^#.*'} | foreach{ $_.Trim() })
foreach($vm in $vms)
{
	doit $vm
}
