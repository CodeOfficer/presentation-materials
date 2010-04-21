# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_rails_2.3.5_app_session',
  :secret      => '677ff47eed4cb0286377fcc7ef46e5ffaafd8e4c0e1e21f1169852dc335eb8a3dbc728f022bd4352477fe666d286d6f4057b78c7a04d90d872f994f520af241f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
