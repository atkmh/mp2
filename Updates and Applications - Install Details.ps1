# Application Installs
$array = @()
$computername=$env:COMPUTERNAME
$UninstallKey=”SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Uninstall” 
$reg=[microsoft.win32.registrykey]::OpenRemoteBaseKey(‘LocalMachine’,$computername) 
$regkey=$reg.OpenSubKey($UninstallKey) 
$subkeys=$regkey.GetSubKeyNames() 
foreach($key in $subkeys){
    $thisKey=$UninstallKey+”\\”+$key 
    $thisSubKey=$reg.OpenSubKey($thisKey) 
    $obj = New-Object PSObject
    $obj | Add-Member -MemberType NoteProperty -Name “InstallDate” -Value $($thisSubKey.GetValue(“InstallDate”))
    $obj | Add-Member -MemberType NoteProperty -Name “DisplayName” -Value $($thisSubKey.GetValue(“DisplayName”))
    $obj | Add-Member -MemberType NoteProperty -Name “DisplayVersion” -Value $($thisSubKey.GetValue(“DisplayVersion”))
    $obj | Add-Member -MemberType NoteProperty -Name “InstallLocation” -Value $($thisSubKey.GetValue(“InstallLocation”))
    $obj | Add-Member -MemberType NoteProperty -Name “Publisher” -Value $($thisSubKey.GetValue(“Publisher”))
    $array += $obj
}
$array | Where-Object { $_.DisplayName } | select InstallDate, DisplayName, DisplayVersion, Publisher | sort InstallDate -Descending | ft -auto
$array | sort InstallDate -Descending | Export-CSV "$env:COMPUTERNAME - Installed Applications.csv"

# Update Installs
$Session = New-Object -ComObject "Microsoft.Update.Session"
$Searcher = $Session.CreateUpdateSearcher()
$historyCount = $Searcher.GetTotalHistoryCount()
$Searcher.QueryHistory(0, $historyCount) | Select-Object Date, Title, @{name="Operation"; expression={switch($_.operation){1 {"Installation"}; 2 {"Uninstallation"}; 3 {"Other"}}}}, Description | ft -auto
 