# Be sure to restart your server when you modify this file.

#Share::Application.config.session_store :cookie_store, key: '_share_session'

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
Share::Application.config.session_store :active_record_store, {
  :key          => '_share_session',        # name of cookie that stores the data
  :domain       => '.inthisapp.com',        # you can share between subdomains here: '.inthisapp.com'
  :expire_after => 1.month,                 # expire cookie
  :secure       => false,                   # force https if true
  :httponly     => true                    # a measure against XSS attacks, prevent client side scripts from accessing the cookie
  #secret token is now place under config/initializers/secret_token.rb
  #:secret      => ENV['RAILS_SECRET_TOKEN']# || '6ca0c78065e4350c9d2ea3875a94271d1b22015c129e46c1a8ccacc153a66094384fe6c40d9fb062b8e56d1703556c44f9ca17a2339db4ab3179a4f47e7be2f9'
}