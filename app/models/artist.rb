class Artist < ApplicationRecord
	#For artist to user associations
	has_many :subscriptions
	has_many :users, through: :subscriptions
	
	#For artist to genre associations
	belongs_to :genre

	#For artist to review associations
	has_many :reviews, dependent: :destroy

	#For artist to notification associations
	has_many :notifications, foreign_key: "receiving_artist_id", dependent: :destroy

	validates :name, :data_quality, presence: true 
end
