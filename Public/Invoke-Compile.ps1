function Invoke-Compile
{
  <#
    .Synopsis
      Gathers together all files for conversion into a deployable script.
    .DESCRIPTION
      Finds all references to external files, and places them into one output. This can be directed into a program such as PS2EXE.
    .EXAMPLE
      Invoke-Compile -Path 'C:\Scripts\run.ps1' | Out-File 'OneSingleScript.ps1'
  #>
    [CmdletBinding()]
    Param
    (
      [String]$Path
    )

    Set-Location -Path ($Path -replace '\\[a-zA-Z0-9]*\.ps1$')
    $launchFile = [pscustomobject]@{ Output = Get-Content $Path }

    do {
      $launchFile = $launchFile.Output | Set-FileMarks
    } while ($launchFile.Matches -gt 0)

    $launchFile.Output
}
