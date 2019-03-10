# Deployment to mospolytech servers
https://fit.mospolytech.ru/

Copy `system` to home directory on the dedicated server. On every
system update the file `setup.sh` will be executed to restore
previously installed programs and configs outside of home
directory.

For the first time on a clean server it will be required to fetch
the source code and edit configuration files:

```shell
$ git clone https://github.com/greenfork/associative-experiment.git
$ cd associative-experiment
$ bundle exec hanami assets precompile
$ cp config/variables .
$ cp config/unicorn.rb .
```

Now edit copied `variables` and `unicorn.rb` files for your needs.
In `variables` leave empty variables you don't need, e.g. mail variables.
In `unicorn.rb` you can use either listening on the socket (recommended)
and then nginx will handle all the other stuff. Or you can listen straight
to the specified port; in this case don't forget to disable nginx server
and set environment variable `SERVE_STATIC_ASSETS` to `true`.

Don't forget to setup up the database, edit necessary variables in
`variables` and run database migrations: `bundle exec hanami db migrate`.
