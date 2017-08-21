#! /usr/bin/env ruby
require "sinatra"
require "pry"
require 'sequel'

set :public_folder, "public"

get "/" do
  @leadActors = tasks("SELECT actor_name, COUNT(movie_title) as num_films FROM casting
JOIN movies ON movies.id = movie_id
WHERE role = 'lead'
GROUP BY actor_name
HAVING COUNT(role) > 15
ORDER BY num_films DESC
LIMIT 10;")
  @countries = tasks("SELECT DISTINCT name, COUNT(movie_title) as num_films FROM Countries
JOIN movies ON country_id = Countries.id
WHERE issue_year BETWEEN 2000 AND 2015
GROUP BY name
ORDER BY num_films DESC
LIMIT 10;").map { |a, b| [a, Math.log(b)] }
  @comedies = tasks("SELECT name, COUNT(genre) as num_comedies FROM movies
JOIN Countries ON country_id = Countries.id
JOIN Movie_genres on Movie_genres.id = movies.id
WHERE genre IN ('Comedy') AND issue_year > 2011
GROUP BY name
ORDER BY num_comedies DESC
LIMIT 5;")
  @flikes = tasks ("SELECT genre, AVG(facebook_likes) FROM movies
JOIN Movie_genres on Movie_genres.id = movies.id
GROUP BY genre
HAVING AVG(facebook_likes) > 0
ORDER BY AVG(facebook_likes) DESC
LIMIT 15;")
  @genres = tasks ("SELECT genre ||'-'|| name AS genre_country, COUNT(movie_title) AS num_movies from movies
JOIN Movie_genres ON movies.id = Movie_genres.id
JOIN Countries ON country_id = Countries.id
GROUP BY genre_country
ORDER BY num_movies DESC
LIMIT 10;")
  @maleFemale = tasks("SELECT occupation, (count(case when sex = 'Male' then 1 end)) as men,
(count(case when sex = 'Female' then 1 end)) AS women
from Historical_figures
GROUP BY occupation
ORDER BY men DESC
LIMIT 10;")
  @countriesHistFigures = tasks ("SELECT name, COUNT(full_name) FROM Countries
JOIN Historical_figures ON country_id = Countries.id
GROUP BY name 
ORDER BY COUNT(full_name)DESC
LIMIT 10;")
  @WikiPageViews = tasks ("SELECT name, MAX(Wiki_page_views) FROM Countries 
JOIN Historical_figures ON country_id = Countries.id
GROUP BY name
ORDER BY MAX(Wiki_page_views) DESC
LIMIT 10;")
  @occupationPerCountry = tasks ("SELECT name ||'-'|| occupation AS occupation_per_country, COUNT(occupation) AS num_occupations FROM Countries
JOIN Historical_figures ON country_id = Countries.id
GROUP BY occupation_per_country
ORDER BY num_occupations DESC
LIMIT 8;")
  @HistoricalFiguresAsActorsPerCountry = tasks ("SELECT name AS country, COUNT(*) AS actors FROM Historical_figures
JOIN Countries ON country_id = Countries.id
WHERE occupation = 'Actor' AND full_name IN
(SELECT full_name FROM Historical_figures 
INTERSECT
SELECT actor_name FROM casting)
GROUP BY name
ORDER BY actors DESC
LIMIT 10;")
  haml :index
end

def sqlite_tasks(query)
  db = SQLite3::Database.new "db/Project2"
  db.execute(query)
end

def postgres_tasks(query)
  @db ||= Sequel.connect ENV["DATABASE_URL"] || 'postgres://localhost/movies'
  @db[query].to_a.map(&:values)
end

if ARGV.first == "sqlite"
  alias tasks sqlite_tasks
  require "sqlite3"
  puts "using sqlite"
else
  alias tasks postgres_tasks
  require "pg"
  puts "using postgres"
end 
