# Associative Linguistic Experiment
This is a program that helps scientists to conduct an Associative Linguistic Experiment.

The experiment is briefly described on the [wiki][1]. But contrary to the
psychology this experiment focuses mainly on the language and words which is
closer to [psycholinguistics][2].

[1]: https://en.wikipedia.org/wiki/Pair_by_association
[2]: https://en.wikipedia.org/wiki/Psycholinguistics

## Structure
There are 2 main blocks:

- `apps/web` is a web questionnaire that asks a respondent to fill in his/her
  reaction to the provided word.
  
- `apps/research` is a web interface to the database which helps querying
  and acquiring knowledge gathered from the collected data.
  
And there are 2 supplementary parts:

- `tools/EDI` is for Electronic Data Interchange which is not exactly what it
  really means, but it is designed to transfer data from paper into the
  Database.
  
- `tools/export_to_excel` is a couple of helpful SQL scripts to export data to
  CSV which can be freely converted to Excel files.

## Prerequisites
`ruby 2.3.6` with `bundle`, `MySQL`/`MariaDB` for production.

`ruby 2.3.6` with `bundle`, `sqlite3` or `MySQL`/`MariaDB`, [capybara-webkit][3]
for development and testing.

Additionally set up the user in database to be used during development and
grant it superuser access.

For MariaDB:

```shell
$ mysql -u root # add -P <password> if password is used
MariaDB [(none)]> CREATE USER 'grfork'@'localhost';
MariaDB [(none)]> GRANT ALL ON *.* TO 'grfork'@'localhost';
MariaDB [(none)]> quit
```

[3]: https://github.com/thoughtbot/capybara-webkit

## Deployment
Edit `config/variables` and `config/unicorn.rb` for your needs.

```
$ git clone https://github.com/greenfork/associative-experiment.git
$ cd associative-experiment
$ bundle install --deployment
$ bundle exec hanami assets precompile
$ source config/variables
$ bundle exec unicorn -c config/unicorn.rb -E production -D
```

This application uses Unicorn as a server, consider using a web-server
such as Nginx to serve static files and cache requests.

## Development
Change a database to the desired one in `.env.development` and `.env.test`.

```
$ git clone https://github.com/greenfork/associative-experiment.git
$ cd associative-experiment
$ bundle install
$ bundle exec hanami db prepare
$ HANAMI_ENV=test bundle exec hanami db prepare
$ bundle exec rake # run tests
$ bundle exec rake s # run server, visit it at localhost:7000
```

## License
Everything is licensed under GNU General Public License v3.0. See the LICENSE
file.
