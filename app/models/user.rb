class User < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
		 :recoverable, :rememberable, :trackable, :validatable

	#For user to artist associations
	has_many :subscriptions
	has_many :artists, through: :subscriptions

	#For user to review associations
	has_many :reviews, dependent: :destroy

	validates :name, presence: true
end