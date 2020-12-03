Set-Location '$ENV:Temp\AdventOfCode\2020\01\'
$database = 'Mikey'
$table = 'input'
Invoke-DbaQuery -SqlInstance $s1 -Database $database -Query "DROP TABLE $table"
$col = @{
    Name      = 'value'
    Type      = 'int'
}
$table = 'input'
New-DbaDbTable -SqlInstance $s1 -Database $database -Name $table -ColumnMap $col
Import-DbaCsv -Path 'input.txt' -SqlInstance $s1 -Database $database -SingleColumn -Table $table -AutoCreateTable  -NoHeaderRow