# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
post '/thank-you', to: 'quiz#thanks', as: :thanks
get '/quiz', to: 'quiz#main', as: :quiz
post '/test-quiz', to: 'quiz#test', as: :test
get '/personal-data', to: 'quiz#personalData', as: :personal_data
root to: 'home#index'
