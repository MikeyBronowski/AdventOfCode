Invoke-DbaQuery -SqlInstance $s1 -Database Mikey -Query 'drop table AoC01'
$col = @{
Name      = 'value'
Type      = 'int'
}
New-DbaDbTable -SqlInstance $s1 -Database Mikey -Name AoC01 -ColumnMap $col
Import-DbaCsv -Path 'input.txt' -SqlInstance $s1 -Database Mikey -SingleColumn -Table AoC01  -AutoCreateTable -Verbose -NoHeaderRow
