class DeviseMailer < ApplicationMailer
	def verification_email
		mail 	:subject 	=> "Verify your email address",
				:to			=> "recipient@example.com", # Replace this with a variable with actual user email.
				:from		=> "account@mybandsource.com"
	end
end
