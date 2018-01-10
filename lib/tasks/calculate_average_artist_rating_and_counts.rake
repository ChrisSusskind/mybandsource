desc "Rake task to calculate average artist rating based on reviews and calculate review/response count for an artist"
task :calculate_average_rating_and_counts => :environment do
  artists = User.artists.all
  artists.each do |artist|
    sum = 0.0
    review_count = 0.0
    response_count = 0
    artist.received_reviews.each do |review|
      sum += review.rating
      review_count += 1
      response_count += review.responses.count
    end
    artist.average_rating = sum / review_count
    artist.review_count = review_count
    artist.response_count = response_count
    puts artist.response_count
    artist.save
  end
end

desc "Rake task to test use of whenever for cron job management"
task :hello_world do
  puts "Hello World"
end

task :update_users do
  User.find_each(&:save)
  User.all.each do |user|
    unless user.email.include?('@')
        user.email = "#{user.id}@mybandsource.com"
        user.save
    end  
  end
end