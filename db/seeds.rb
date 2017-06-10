# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

genre_list = [
	"Pop",
  "Rock",
  "Alternative",
  "Hip Hop",
  "R&B",
  "Electronic",
  "Country",
  "Indie"
]

User.create(email: "eric@turtle.com", bio: "", name: "Eric", location: "Cornholeville", password: "turtle", picture: Faker::LoremPixel.image("150x150", true, 'people'), confirmed_at: Time.now, is_artist: false)

genre_index = 0
Genre.populate genre_list.length do |genre|
  genre.name 				= genre_list[genre_index]
	genre.description 		= Faker::Lorem.sentence
  if genre_list[genre_index] == "Hip Hop"
    genre.picture = "static/" + "HipHop" + "_card"
  elsif genre_list[genre_index] == "R&B"
		genre.picture = "static/" + "RnB" + "_card"
	else
    genre.picture = "static/" +  genre_list[genre_index] + "_card"
	end
	genre_index += 1
end

# Artist users
User.populate 50 do |artist|
	artist.email = Faker::Internet.unique.safe_email
	artist.encrypted_password	= Faker::Crypto.sha1
	artist.name				= Faker::RockBand.name
	artist.real_name		= Faker::Name.name
	artist.bio			= Faker::Lorem.paragraph
	artist.data_quality		= Faker::Music.instrument
	artist.location			= Faker::Address.city
	artist.facebook_url		= Faker::Internet.url('facebook.com')
	artist.soundcloud_url	= Faker::Internet.url('soundcloud.com')
	artist.spotify_url		= Faker::Internet.url('spotify.com')
	artist.itunes_url		= Faker::Internet.url('itunes.com')
	artist.twitter_url		= Faker::Internet.url('twitter.com')
	artist.created_at		= Faker::Time.between(DateTime.now-1, DateTime.now)
	artist.updated_at		= DateTime.now
	artist.genre_id			= Genre.first.id
	artist.sign_in_count		= 0
  	artist.is_artist = true
end

# Regular users
User.populate 50 do |user|
	user.email				= Faker::Internet.unique.safe_email
	user.name 				= Faker::Name.name
	user.location 			= Faker::Address.city
	user.encrypted_password	= Faker::Crypto.sha1
	user.sign_in_count		= 0
	user.is_artist = false

	Review.populate Faker::Number.between(1, 20) do |review|
		review.receiving_user_id = Faker::Number.between(2, 51)
		review.leaving_user_id = user.id
		review.comment = Faker::Hipster.sentence
		review.rating = Faker::Number.between(1, 5)
		review.upvotes = Faker::Number.number(3)
		review.upvotes_userlist = []

		Response.populate 1 do |response|
			response.review_id = review.id
			response.comment = Faker::Hipster.sentence
			response.user_id = user.id
			response.upvotes = Faker::Number.number(2)
			response.upvotes_userlist = []
		end
	end
end
Faker::UniqueGenerator.clear

UserRelationship.populate 50 do |user_relationship|
  user_relationship.follower_id = Faker::Number.unique.between(1, 100)
  user_relationship.followed_id = Faker::Number.unique.between(1, 100)
end