require 'CSV'


all_genres = []
CSV.open("cleanmovies.csv", "wb") do |csv|
  	CSV.foreach("movies.csv") do |row|
  		genre = row[3]
  		id = row[0]
  		row.delete_at(3)
  		csv << row
  		genres = genre.split("|")
  		genre_rows = genres.map { |genre| [id, genre] }
  		all_genres.concat genre_rows
	end
end

CSV.open("cleangenres.csv", "wb") do |csv|
	all_genres.each { |genre| csv << genre}
end