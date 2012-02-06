# Be sure to restart your server when you modify this file.

# Share::Application.config.session_store :cookie_store, key: '_share_session'

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
Share::Application.config.session_store :active_record_store

Share::Application.config.session = {
  :key          => '_share_session',        # name of cookie that stores the data
  :domain       => '.inthisapp.com',        # you can share between subdomains here: '.inthisapp.com'
  :expire_after => 1.month,                 # expire cookie
  :secure       => false,                   # force https if true
  :httponly     => true,                    # a measure against XSS attacks, prevent client side scripts from accessing the cookie
  
  :secret      => ENV['RAILS_SECRET_TOKEN']
}