source 'https://rubygems.org'

#ruby '~> 2.3'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.1'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 3.0'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use PostgreSQL as the database for Active Record
gem 'pg'

# Login system
gem 'devise'
# OmniAuth providers for Devise
gem 'omniauth-facebook'

# Foundation CSS Framework – https://github.com/zurb/foundation-rails
gem 'bootstrap', '~> 4.0.0.alpha6'

# Use Cloudinary for image hosting CDN
gem 'cloudinary'
gem 'attachinary'

# Use Puma for the webserver
gem 'puma'
gem 'rest-client'

# Use kaminari for pagination
gem 'kaminari'

# Using react for interactive search on homepage
gem 'react-rails'

# Transactional email service through MailChimp
gem 'mandrill-rails'

# Google icons gem
gem 'material_icons'

# Glyphicons gem
gem 'glyphicons-rails'

gem 'font-awesome-rails'

# Tether gem
gem 'tether-rails'

# Whenever gem for scheduling background jobs
gem 'whenever', '~> 0.9.7'

# Admin portal
gem 'activeadmin', '~> 1.0.0'

# Gem for carousel
gem 'jquery-slick-rails'

gem 'secure_headers'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  # For testing and other utilities
  gem 'rake'
  # For DB seeding and fake data generating
  gem 'faker'
  gem 'populator'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'dotenv-rails'
  gem 'listen', '~> 3.0.5'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # For better test reporting! 😇
  gem 'guard-minitest'
  gem 'minitest-reporters'
  gem 'mini_backtrace'
end

