function Invoke-Compile
{
  <#
    .Synopsis
      Short description
    .DESCRIPTION
      Long description
    .EXAMPLE
      Example of how to use this cmdlet
  #>
    [CmdletBinding()]
    Param
    (
      [String]$Path
    )
      Set-Location -Path ($Path -replace '\\[a-zA-Z0-9]*\.ps1$')
      $launchFile = Get-Content $Path
      $launchFile = $launchFile |% { 
        #Write-Verbose "Starting line $_"
        $_ | Get-FileMarks 
      }
      $launchFile
}
