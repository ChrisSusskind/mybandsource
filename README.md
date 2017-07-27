# MyBandSource

This is a band social networking website for people to get more out of the listening experience.


##### Build Status:

|  Branch  |   Status   |   
| :------: | :--------: |
|  Master  | [![Build Status][master-build-badge]](build-link) |
|    Dev   | [![Build Status][dev-build-badge]](build-link) |


### External Services

All images are hosted on [Cloudinary](https://cloudinary.com)'s CDN. They are uploaded directly from the browser using 
the `Carrierwave` gem. The URL is saved with the `User` model in the database.

Email functionality uses [Mandrill](https://mandrillapp.com) for transactional email.

### Requirements
It is highly recommended to use RVM to match the production server image's ruby installation.
* PostgreSQL 9.0+
* Ruby version: `2.3.3`
* Redis: any version (I hope)

### Setup
1. Clone me
2. Install the application bundle: `bundle install`
3. Generate/Seed the database: `bundle exec rake db:setup`
4. Run tests to make sure nobody fucked up: `bundle exec rake`
5. Cool

### Deploy
**Please consult with @rikola first before doing this shit**

Currently, this app is deployed with AWS Elastic Beanstalk. Follow these steps to join the easy deploy club:
1. Install the AWS CLI and the Elastic Beanstalk CLI: `brew install awscli aws-elasticbeanstalk`
2. Setup AWS API Keys to enable programmatic access to the environment.
3. Run `aws configure` to load up your access keys. Set the default environment to `us-east-1`.
4. To be continued...


[build-link]: https://travis-ci.com/rikola/mybandsource
[master-build-badge]: https://travis-ci.com/rikola/mybandsource.svg?token=UFA1wpQtMzhtTiyRH67s&branch=master
[dev-build-badge]: https://travis-ci.com/rikola/mybandsource.svg?token=UFA1wpQtMzhtTiyRH67s&branch=dev