# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

[User, Artist, Genre].each(&:delete_all)

User.create(name: 'eric', email: "e@turtle.com", password: "turtle", location: "Chicago, IL")

Genre.populate 20 do |genre|
	genre.name 				= Faker::Lorem.unique.word
	genre.description 		= Faker::Lorem.sentence
end

Artist.populate 100 do |artist|
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
end


User.populate 50 do |user|
	user.email				= Faker::Internet.unique.safe_email
	user.name 				= Faker::Name.name
	user.location 			= Faker::Address.city
	user.encrypted_password	= Faker::Crypto.sha1
	user.sign_in_count		= 0
end