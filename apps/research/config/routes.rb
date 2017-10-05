# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }

get '/', to: 'analysis#dictionary', as: :dict

get '/authentication', to: 'authentication#login', as: :auth
post '/authentication', to: 'authentication#login'
