class CreateArtists < ActiveRecord::Migration[5.0]
	def change
		create_table :artists do |t|
			
			#Data type changes to be made upon switch to PostgreSQL: location: Point, social media urls: host_name

			t.string :name, null: false, index: true
			t.string :real_name
			t.text :profile
			t.string :data_quality, null: false
			t.string :location, index: true

			# Social Media URLs for API interface
			t.string :facebook_url
			t.string :soundcloud_url
			t.string :spotify_url
			t.string :itunes_url
			t.string :twitter_url

			t.timestamps
		end
	end
end
