# switch off extra output when in production
if ENV['HANAMI_ENV'] == 'production'
  R.quit
  R = RinRuby.new(false)
end

R.eval <<CONFIG
library(tidyverse)
CONFIG
