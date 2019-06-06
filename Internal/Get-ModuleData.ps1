function Get-ModuleData
{
  <#
    .Synopsis
      Get info regarding what data and functions are stored in the module.
  #>
    [CmdletBinding()]
    Param
    (
      [String]$Path
    )
    process
    {
      (Get-ChildItem -Path $Path -Recurse).FullName | Where-Object {$_ -like '*.ps1'} | ForEach-Object {
        $fFile = (Get-Content $_).Trim() | Where-Object {-not [String]::IsNullOrWhiteSpace($_)}
        if ( $fFile[0] -like '*function*' -or $fFile[0] -like '*class*') {
          $fFile
        }
      }
    }
}
