class AverageRatingCalculationJob < ApplicationJob
  queue_as :low_priority

  def perform
    @artists = User.artists.all
    @artists.each do |artist|
      sum = 0
      count = 0
      artist.received_reviews.each do |review|
        sum += review.rating
        count += 1
      end
      artist.average_rating = sum / count
      artist.save
    end
  end
end
