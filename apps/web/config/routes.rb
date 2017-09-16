# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
get '/:quiz_id/person', to: 'quiz#person', as: :person
post '/thank-you', to: 'quiz#thanks', as: :thanks
get '/quiz', to: 'quiz#main', as: :quiz
post '/:quiz_id/test-quiz', to: 'quiz#test', as: :test
get '/:quiz_id/test-quiz', to: 'quiz#test'
root to: 'home#index'
