<#
.Synopsis
   MaaS plugin to monitor Services
.DESCRIPTION
   This script will monitor a list of services and return a failure state if the service is stopped. 
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>

Param(
    # Param1 help description
    [Parameter(Mandatory=$true,
            ValueFromPipelineByPropertyName=$true,
    Position=0)]
    [string]$ServiceFilter
)


Write-Output 'status string OK'
$list_services = Get-WmiObject -Class Win32_Service |
Select-Object Name,ProcessId,State,StartMode,Status |
Where-Object {$_.name -match $ServiceFilter}

foreach ($Service in $list_services){
    Write-Output $Services
    $Svc_Name     = ($Service.Name).Replace('$','_')
    $Svc_State     = $Service.State
    $Svc_Status    = $Service.Status
    $Svc_StartMode = $Service.StartMode
    if($Service.State -match 'Running'){$Svc_StateBit = 1}else{$Svc_StateBit = 0}

    Write-Output "metric $($Svc_Name)_service_name         string    $($Svc_Name)"
    Write-Output "metric $($Svc_Name)_service_state        string    $($Svc_State)"
    Write-Output "metric $($Svc_Name)_service_status       string    $($Svc_Status)"
    Write-Output "metric $($Svc_Name)_service_state_bit    int32     $($Svc_StateBit)"
    Write-Output "metric $($Svc_Name)_service_startup_mode string    $($Svc_StartMode)"                     
}       


