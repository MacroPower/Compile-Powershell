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
      
    }
    process
    {
      switch -Regex ($InputLine) {
        '.*Get-Command.*' { $InputLine | Set-FileMarks -Type Command; Break}
        '.*Get-Content.*' { $InputLine | Set-FileMarks -Type Text; Break}
        default {$InputLine}
      }
    }
    end
    {

    }
}
