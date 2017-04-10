class AccountMailer < Devise::Mailer

	def confirmation_instructions(record, token, opts={})
		# Code later
	end

	def reset_password_instructions(record, token, opts={})
		options = {
			:subject => "Password Reset",
			:email => record.email,
			:global_merge_vars => [
				{
					name: "password_reset_link",
					content: new_user_password + "?reset_password_token=#{token}"
				}
			],
			:template => "Forgot Password"
		}
		mandrill_send options
	end

	def unlock_instructions(record, token, opts={})
	end

	def mandrill_send(opts={})
		message = {
			:subject => "#{opts[:subject]}",
			:from_name => "MyBandSource",
			:from_email => "accounts@mybandsource.com",
			:to => [{
					"name" => "Some User",
					"email" => "#{opts[:email]}",
					"type" => "to"
			}],
			:global_merge_vars => opts[:global_merge_vars]
		}
		sending = MANDRILL.messages.send_template opts[:template], [], message
	rescue Mandrill::Error => e 
		Rails.logger.debug("#{e.class}: #{e.message}")
		raise
	end

end
