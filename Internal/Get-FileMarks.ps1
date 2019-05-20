function Get-FileMarks
{
  <#
    .Synopsis
      Get instances where the file to be built is sourcing info in the module.
  #>
    [CmdletBinding()]
    Param
    (
      [String]$Path
    )
    begin
    {
      Get-ModuleData ($Path.Parent)
    }
    process
    {

    }
    end
    {

    }
}
