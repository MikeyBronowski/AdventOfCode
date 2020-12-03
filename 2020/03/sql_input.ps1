Set-Location '$ENV:Temp\AdventOfCode\2020\03\'
$database = 'Mikey'
$table = 'input'
Invoke-DbaQuery -SqlInstance $s1 -Database $database -Query "DROP TABLE $table"
$col = @{
    Name      = 'value'
    Type      = 'varchar'
    MaxLength = 100
}
New-DbaDbTable -SqlInstance $s1 -Database $database -Name $table -ColumnMap $col
Import-DbaCsv -Path 'input.txt' -SqlInstance $s1 -Database $database -SingleColumn -Table $table -AutoCreateTable  -NoHeaderRow