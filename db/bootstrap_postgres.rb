# copy/pasted from the sqlite readme
require 'pg'

# Open a database
db = PG.connect

# # Create a table
# db.exec <<-SQL
#   create table activity_duration(
#     activity varchar(30),
#     num_hours int
#   );
# SQL

# Execute a few inserts
{
  'Work'     => 0,
  'Eat'      => 100,
  'Commute'  => 100,
  'Watch TV' => 100,
  'Sleep'    => 0
}.each do |pair|
  db.exec('insert into activity_duration values ( $1, $2 )', pair)
end
