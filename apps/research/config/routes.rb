# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }

root to: 'analysis#dictionary'

get '/analysis/dictionary', to: 'analysis#dictionary', as: :dict
post '/analysis/dictionary', to: 'analysis#dictionary'

get '/authentication', to: 'authentication#login', as: :auth
post '/authentication', to: 'authentication#login'

get '/analysis/comparison', to: 'analysis#comparison', as: :comparison
post '/analysis/comparison', to: 'analysis#comparison'
