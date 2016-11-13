Measure-Command { 
	Measure-Command { make virtualbox/eval-win10x64-enterprise }
	Measure-Command { make virtualbox/eval-win10x86-enterprise }
	Measure-Command { make virtualbox/eval-win2008r2-datacenter }
	Measure-Command { make virtualbox/eval-win2008r2-standard }
	Measure-Command { make virtualbox/eval-win2012-standard }
	Measure-Command { make virtualbox/eval-win2012r2-datacenter }
	Measure-Command { make virtualbox/eval-win2012r2-standard }
	Measure-Command { make virtualbox/eval-win7x64-enterprise }
	Measure-Command { make virtualbox/eval-win7x86-enterprise }
	Measure-Command { make virtualbox/eval-win81x64-enterprise }
	Measure-Command { make virtualbox/eval-win81x86-enterprise }
	Measure-Command { make virtualbox/eval-win8x64-enterprise }
}
