function Set-FileMarks
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
      [Parameter(ValueFromPipeline)][String]$InputLine,
      $Type
    )
    begin
    {

    }
    process
    {
      $x = ($InputLine | Select-String -Pattern "('.*?')" -AllMatches).Matches.Value -replace "'"
      if ( Test-Path $x ) {
        $y = Get-Content -Path $x -Raw

        if ($Type -eq 'Command') {
          $InputLine -replace "\(([a-zA-Z]+-[a-zA-Z]+)(([ ])|( (-[Pp]ath) ))['`"]$($x -replace '\\','\\')['`"]\)\.ScriptBlock","{`n$y`n}"
        }
      } else {
        $InputLine
      }
      
    }
    end
    {

    }
}
