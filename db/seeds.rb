# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

genre_list = [
	"Blues",
	"Comedy",
	"Children's Music",
	"Classical",
	"Country",
	"Electronic",
	"Holiday",
	"Opera",
	"Singer Songwriter",
	"Jazz",
	"Latino",
	"New Age",
	"Pop",
	"R&B/Soul",
	"Soundtrack",
	"Dance",
	"Hip-Hop & Rap",
	"World",
	"Alternative",
	"Rock",
	"Christian & Gospel",
	"Vocal",
	"Reggae",
	"Easy Listening",
	"J-Pop",
	"Enka",
	"Anime",
	"Kayokyoko",
	"Fitness & Workout",
	"K-Pop",
	"Karaoke",
	"Instrumental",
	"Brazilian",
	"Spoken Word",
	"Disney",
	"French Pop",
	"German Pop",
	"German Folk"
]

[User, Artist, Genre].each(&:delete_all)

User.create(email: "eric@turtle.com", bio: "", name: "Eric", location: "Cornholeville", password: "turtle", picture: Faker::LoremPixel.image("150x150", true, 'people'), confirmed_at: Time.now)


genre_index = 0
Genre.populate genre_list.length do |genre|
	genre.name 				= genre_list[genre_index]
	genre_index += 1
	genre.description 		= Faker::Lorem.sentence
end

artist_count = 100
Artist.populate artist_count do |artist|
	artist.name				= Faker::RockBand.name
	artist.real_name		= Faker::Name.name
	artist.profile			= Faker::Lorem.paragraph
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
	artist.picture			= Faker::LoremPixel.image("150x150", true, 'people')
end


User.populate 50 do |user|
	user.email				= Faker::Internet.unique.safe_email
	user.name 				= Faker::Name.name
	user.location 			= Faker::Address.city
	user.encrypted_password	= Faker::Crypto.sha1
	user.sign_in_count		= 0
	user.picture			= Faker::LoremPixel.image("150x150", true, 'people')

	# Populate fake subscriptions
	sub_count = 10 # Number of subscriptions to be seeded
	artist_list = Artist.limit(sub_count).order("RANDOM()")
	counter = 0	
	Subscription.populate sub_count do |subscription|
		subscription.user_id 		= user.id	
		subscription.artist_id 		= artist_list[counter].id
		counter += 1
	end

	Review.populate Faker::Number.between(1, 20) do |review|
		review.artist_id = Faker::Number.unique.between(1, 100)
		review.user_id = user.id
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
	Faker::UniqueGenerator.clear
end