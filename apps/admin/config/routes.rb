# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
root to: 'forms#upload'
get '/forms/upload', to: 'forms#upload', as: 'upload'
post '/forms/upload', to: 'forms#upload'
get '/login', to: 'authentication#login', as: 'auth'
post '/login', to: 'authentication#login'
