require "csv"


ProductionCompany.delete_all
Page.delete_all
MovieGenre.delete_all
Genre.delete_all
Movie.delete_all


filename = Rails.root.join("db/top_movies.csv")

puts "Loading Movies from the CSV file: #{filename}"

csv_data = File.read(filename)
movies = CSV.parse(csv_data, headers: true, encoding: "utf-8")

movies.each do |m|
  production_company = ProductionCompany.find_or_create_by(name: m["production_company"])
  if production_company && production_company.valid?

    #create a movie
    movie= production_company.movies.create(
      title: m["original_title"],
      year: m["year"],
      duration: m["duration"],
      description: m["description"],
      average_vote: m["avg_vote"]
    )
    puts "INVALID movie #{m['original_title']}" unless movie&.valid?
    genres = m["genre"].split(",").map(&:strip)

    genres.each do |genre_name|
      genre = Genre.find_or_create_by(name: genre_name)

      MovieGenre.create(movie: movie, genre:genre)
    end

  else
    puts "invalid prouduction company #{m["production_company"]} for movie #{m['origianl_title']}"

  end
  puts m["original_title"]
end
puts "Created #{ProductionCompany.count} Production Companies"
puts "Created #{Movie.count} movies."
puts "Created #{Genre.count} Genres"
puts "Created #{MovieGenre.count} Movies Genres "


Page.create(
  title: 'About the Data',
  content: ' The data powering this very cool website provided by IDMD Kaggle ds',
  permalink: 'about_the_data'
)

Page.create(
  title: 'Contact Us',
  content: 'If you like this site and want to chat about the project or the data, email me at: obviously_fake@email.com',
  permalink: 'contact'
)
