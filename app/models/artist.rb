class Artist < ApplicationRecord
	#For artist to user associations
	has_many :subscriptions
	has_many :users, through: :subscriptions
	
	#For artist to genre associations
	belongs_to :genre

	#For artist to review associations
	has_many :reviews, dependent: :destroy

	validates :name, :data_quality, presence: true 
end
