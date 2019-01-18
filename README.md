# Associative linguistic experiment
This experiment is briefly described on the
[wiki](https://en.wikipedia.org/wiki/Pair_by_association). But in contrary to
psychology this experiment focuses mainly on language and words which is
closer to
[psycholinguistics](https://en.wikipedia.org/wiki/Psycholinguistics).

## Brief history
Usually this experiment is conducted in the way that respondents are given
questionnaire sheets where they fill in their age, sex, native language and
nationality leaving name and surname, hence the experiment is conducted
anonymously. Next they see a list of words (usually around 100) and an empty
field to fill next to these words. The respondents write their association to
the word next to it in the field and repeat until all the 100 fields are done.

## Purpose
The main purpose of this software is to automate acquisition of the
respondents' reactions and provide convenient tools to view and administer
this process and the results including research specific statistics and
metrics.

## Prerequisites
You will need `ruby 2.3+` with `bundle` and `MySQL` or `MariaDB`
to run this application in production.

You will need to edit config/variables and config/unicorn.rb to your needs for
production usage.

If you want to run tests, you will need additionally to install backend for
[capybara-webkit](https://github.com/thoughtbot/capybara-webkit) and possibly
change database to sqlite in .env.development and .env.test.


## Usage
```
$ git clone https://github.com/greenfork/associative-experiment.git
$ cd associative-experiment

# for production
$ bundle install --deployment
$ bundle exec hanami assets precompile
$ source config/variables
$ bundle exec unicorn -c config/unicorn.rb -E production -D

# for development
$ bundle install
$ bundle exec hanami db prepare
$ HANAMI_ENV=test bundle exec hanami db prepare
$ bundle exec rake # run tests
$ bundle exec rake s # run server, visit it at localhost:7000
```

Unicorn server works well with nginx in production.

## Also
Take a look at `tools/EDI` if you need to import data into the system.

Take a look at `tools/export_to_excel` if you need to export data to Excel
or CSV files.

## License
Everything is licensed under GNU General Public License v3.0. See the LICENSE
file.
