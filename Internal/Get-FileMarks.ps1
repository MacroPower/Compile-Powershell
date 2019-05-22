function Get-FileMarks
{
  <#
    .Synopsis
      Get instances where the file to be built is sourcing info in the module.
  #>
    [CmdletBinding()]
    Param
    (
      [Parameter(ValueFromPipeline)][String]$InputLine
    )
    begin
    {
      $numberOfMatches = 0
    }
    process
    {
      switch -Regex ($InputLine) {
        '.*Get-Command.*' { 
          $out = $InputLine | Set-FileMarks -Type Command
          $numberOfMatches++
          ; Break
        }
        '.*Get-Content.*' {
          $out = $InputLine | Set-FileMarks -Type Text
          $numberOfMatches++
          ; Break
        }
        '.*Import-Module.*' {
          $out = $InputLine | Set-FileMarks -Type Module
          $numberOfMatches++
          ; Break
        }
        default {$out = $InputLine}
      }
    }
    end
    {
      return [PSCustomObject]@{
        Matches  = $numberOfMatches
        Output   = $out
      }
    }
}
