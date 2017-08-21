Simple SQL
==========

An app to visualize SQL queries built as part of the last cycle of programming classes taken with [FrauenLoop](http://frauenloop.org/)

For my SQL course, I picked 2 datasets from kaggle.com ([IMDB 5000 Movie Dataset](https://www.kaggle.com/gaurav12/imdb-data) & [Pantheon Project: Historical Popularity Index](https://www.kaggle.com/mit/pantheon-project)), built a schema while learning about database analysis and design, then I wrote SQL queries to investigate relationships in the data and finally built the app to visualize those relationships. 

Each chart has the SQL command used to generate it printed below the chart.  
See what it looks like [here](https://frauenloop-sql.herokuapp.com/)

=====

### For SQLite
```bash
$ ./run_with_reload.sh
```

### For Postgres
```bash
$ ./run_with_reload postgres
```


And open [http://localhost:4567](http://localhost:4567)


