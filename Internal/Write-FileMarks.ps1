function Write-FileMarks
{
  <#
    .Synopsis
      Replace references with the referenced content.
  #>
    [CmdletBinding()]
    Param
    (
      [Parameter(ValueFromPipeline)][String]$InputLine,
      [String]$Type
    )
    process
    {
      $x = ($InputLine | Select-String -Pattern "(['`"].*?['`"])" -AllMatches).Matches.Value -replace "['`"]"
      $x | ForEach-Object {
        if ( Test-Path $_ -PathType Leaf ) {
          Write-Verbose "Found a file here: $_"

          $y = (Get-Content -Path $_ -Raw) 
          $Path = $_
          $rPath = $_ -replace '\\','\\'
          switch ($Type) {
            'Command' {
              Write-Verbose "Replace a command with $Rpath because of $InputLine"
              $r = "([ ]*)\(([ ]*)([ ]*[a-zA-Z]+-[a-zA-Z]+)(([ ]+)|([ ]+(-[Pp]ath)[ ]+))['`"]($rPath)['`"]([ ]*)\)\.ScriptBlock([ ]*)"
              #Something I've done here isn't supported by -replace
              $ss=Select-String -InputObject $InputLine -Pattern $r
              (
                $InputLine.replace($ss.Matches.Value,"{`n$y`n}")
              ) -split "`r`n"
              Break 
            }
            'Text' {
              Write-Verbose "Replace text with $rPath because of $InputLine"
              $r = "([ ]*[a-zA-Z]+-[a-zA-Z]+)(([ ])|( (-[Pp]ath) ))['`"]($rPath)['`"]([ ]*)"
              if ( ($y.length) * 2 -lt 1mb ) {
                (
                  $InputLine -replace $r," @'`n$y`n'@"
                ) -split "`r`n"
              } else { 
                Write-Verbose 'WOW! That is a large file!'
                $InputLine -replace $r," @'`n$('I couldn''t handle this file, sorry :[')`n'@" 
              }
              Break
            }
            'Module' {
              Write-Verbose "Replace module with $Path because of $InputLine"
              (
                Get-ModuleData -Path ($Path -replace '\\(?:.(?!\\))+$')
              ) -split "`r`n"
            }
          }
        } else {
          $InputLine
        }
      }
    }
}
