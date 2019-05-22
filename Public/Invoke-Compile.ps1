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
    $launchFile = [pscustomobject]@{ Output = Get-Content $Path }

    do {
      $launchFile = $launchFile.Output | ForEach-Object { 
        $_ | Get-FileMarks -Verbose
      } 
      Write-Verbose "$($launchFile.Matches)"
    } while ($launchFile.Matches -gt 0)

    $launchFile.Output
}
