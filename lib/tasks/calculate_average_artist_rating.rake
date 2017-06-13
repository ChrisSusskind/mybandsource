desc "Rake task to calculate average artist rating based on reviews"
task :calculate_average_rating => :environment do
  artists = User.artists.all
  artists.each do |artist|
    sum = 0.0
    count = 0.0
    artist.received_reviews.each do |review|
      sum += review.rating
      count += 1
    end
    artist.average_rating = sum / count
    puts artist.average_rating
    puts artist.save
  end
end

desc "Rake task to test use of whenever for cron job management"
task :hello_world do
  puts "Hello World"
end