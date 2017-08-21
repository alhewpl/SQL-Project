# copy/pasted from the sqlite readme
require 'sqlite3'


# Open a database
db = SQLite3::Database.new 'db/Project2-backup'

# Create a table
db.execute <<-SQL
  create table activity_duration(
    activity varchar(30),
    num_hours int
  );
SQL

# Execute a few inserts
{
  'Work'     => 0,
  'Eat'      => 80,
  'Commute'  => 100,
  'Watch TV' => 100,
  'Sleep'    => 0
}.each do |pair|
  db.execute('insert into activity_duration values ( ?, ? )', pair)
end
