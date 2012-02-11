# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
Share::Application.config.secret_token = ENV['RAILS_SECRET_TOKEN'] #'05899b232ecd0a6b255ae81010edef388a3f39b259e10ea4553371e65eacef8d2a5403a7805ffb820cde357d16b582b65956abda82e5d97c2220a9f8bba3550c'
