# Export to Excel
In order to export to excel, there are scripts to be run from the SQL
database console:

`export_people.sql` and `export_reactions.sql`.

Currently scripts' output is adapted to be in Russian.

An example session for sqlite3 database:

```
$ cd path/to/project/root
$ sqlite3 db/assoc_development.sqlite
sqlite> .mode quote
sqlite> .once export_people.csv
sqlite> .read tools/export_to_excel/export_people.sql
sqlite> .once export_reactions.csv
sqlite> .read tools/export_to_excel/export_reactions.sql
sqlite> .quit
```

CSV files can be exported to Excel format by opening them in Excel choosing 
the delimiter as a comma and the string delimiter as a single quote `'`.
