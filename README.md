# Setup

* Use Ruby 1.9.3
* Install imagemagick for carrierwave mini_magick
* bundle install
* Create a database.yml file using database.yml.example
* Set ENV variables for:
    * ENV['S3_KEY'] # used in carrierwave.rb
    * ENV['S3_SECRET'] # used in carrierwave.rb
    * ENV['RAILS_SECRET_TOKEN'] # used in session_store.rb
    * ENV["RECAPTCHA_PRIVATE_KEY"] # Production
    * ENV["RECAPTCHA_PUBLIC_KEY"] # Production
    * Heroku uses all of the above plus the following
        * heroku config:add RACK_ENV=demo --remote demo # for Heroku staging, demo, etc.
        * heroku config:add RAILS_ENV=demo --remote demo # for Heroku staging, demo, etc.
* In your S3 account, add a bucket named 'inthisapp' 
* share.yml file in ./config should look like the following:

<pre>
    development:
      endpoint: http://192.168.1.7:8081/api/v1
      api_key: 879b1f71a1f61abc97e64e93cc68e7543ef4e85c
</pre>

* bundle exec rake setup


# Deployment (Demo)

    git push demo master
    heroku pg:reset SHARED_DATABASE --remote demo
    heroku run rake setup_heroku --app inthisappdemo --confirm inthisappdemo
    heroku restart --app inthisappdemo