Measure-Command { make virtualbox/eval-win7x64-enterprise | out-default; email --blank-mail --subject "Packer is done with eval-win7x64-enterprise" taylor }
Exit
Measure-Command { make virtualbox/eval-win10x64-enterprise | out-default; email --blank-mail --subject "Packer is done with eval-win10x64-enterprise" taylor }
Measure-Command { make virtualbox/eval-win10x86-enterprise | out-default; email --blank-mail --subject "Packer is done with eval-win10x86-enterprise" taylor }
Measure-Command { make virtualbox/eval-win2008r2-datacenter | out-default; email --blank-mail --subject "Packer is done with eval-win2008r2-datacenter" taylor }
Measure-Command { make virtualbox/eval-win2008r2-standard | out-default; email --blank-mail --subject "Packer is done with eval-win2008r2-standard" taylor }
Measure-Command { make virtualbox/eval-win2012-standard | out-default; email --blank-mail --subject "Packer is done with eval-win2012-standard" taylor }
Measure-Command { make virtualbox/eval-win2012r2-datacenter | out-default; email --blank-mail --subject "Packer is done with eval-win2012r2-datacenter" taylor }
Measure-Command { make virtualbox/eval-win2012r2-standard | out-default; email --blank-mail --subject "Packer is done with eval-win2012r2-standard" taylor }
Measure-Command { make virtualbox/eval-win7x86-enterprise | out-default; email --blank-mail --subject "Packer is done with eval-win7x86-enterprise" taylor }
Measure-Command { make virtualbox/eval-win81x64-enterprise | out-default; email --blank-mail --subject "Packer is done with eval-win81x64-enterprise" taylor }
Measure-Command { make virtualbox/eval-win81x86-enterprise | out-default; email --blank-mail --subject "Packer is done with eval-win81x86-enterprise" taylor }
Measure-Command { make virtualbox/eval-win8x64-enterprise | out-default; email --blank-mail --subject "Packer is done with eval-win8x64-enterprise" taylor }
