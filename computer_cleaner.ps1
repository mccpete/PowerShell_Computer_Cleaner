#elevates user to admin so operations can be complete
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
 if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
  $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
  Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
  Exit
 }
}

Set-ExecutionPolicy RemoteSigned

#makes pshell screen bigger
mode 300

write-host "Welcome to the Computer Cleaner tool"

echo "

  ___ __  __ __ ___ _  _ _____ ___ ___    ____   ___  __  __  _ ___ ___   
 / _//__\|  V  | _,\ || |_   _| __| _ \  / _/ | | __|/  \|  \| | __| _ \  
| \_| \/ | \_/ | v_/ \/ | | | | _|| v / | \_| |_| _|| /\ | | ' | _|| v /  
 \__/\__/|_| |_|_|  \__/  |_| |___|_|_\  \__/___|___|_||_|_|\__|___|_|_\  

"

Start-sleep -s 5

write-host "This tool will speed up your PC by cleaning out some unneeded 
files from your temp, downloads, and even recycle bin folder."
write-host " "
write-host "If you are not sure what these folders mean you can visit this 
website here: https://www.thewindowsclub.com/temporary-files-folder-location-windows"

Start-sleep -s 5
write-host ""
$proceed = read-host "Press y to continue or n to stop the tool"

#yes or no if block to proceed or exit

if($proceed -eq "y"){

	#clears temp folder
	Remove-Item -Path $env:TEMP\* -Recurse -Force -ErrorAction SilentlyContinue
	
	#clears downloads folder
	Get-ChildItem C:\Users\*\Downloads\* | Remove-Item -Recurse -Force
	
	#clears recycle bin
	Clear-RecycleBin -Force
	
	#flushes DNS cache
	ipconfig /flushDNS
	
	#optimizes computer power for performance
	powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e
}

elseif($proceed -eq "n"){
	
	write-host "You have chose to not clean your computer..."
	write-host "Exiting Application!"
	Exit 
}

write-host "To go a step further would like like to restart your pc? It may help speed things up if this has not been done in a while"

Start-sleep -s 3

#if block to restart or not

$restart = read-host "Press y to restart or n to not restart PC."

if($restart -eq "y"){

	Restart-Computer
}

elseif($restart -eq "n"){
	
	write-host "You have chosen to not restart your computer..."
	write-host "Exiting Application!"
	Exit 
}
