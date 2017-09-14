# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
get '/:id/person', to: 'quiz#person', as: :person
post '/thank-you', to: 'quiz#thanks', as: :thanks
get '/quiz', to: 'quiz#main', as: :quiz
post '/test-quiz', to: 'quiz#test', as: :test
root to: 'home#index'
