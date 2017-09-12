# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
get '/person/:id', to: 'quiz#person', as: :person
post '/thank-you', to: 'quiz#thanks', as: :thanks
get '/quiz/:id', to: 'quiz#main', as: :quiz
post '/test-quiz', to: 'quiz#test', as: :test
get '/personaldata/:id', id: /\d/, to: 'quiz#personalData', as: :personal_data
root to: 'home#index'
