# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Uhack::Application.config.secret_key_base = ENV['SECRET_TOKEN'] || '261b42c301f668ae1616f75e1c2e27f7c7c102d3a5f5967a3c272a5e533784e22f24259215cb78746ad02b43d9d00a175810e62815574fde18e9c3032a5876a2'
