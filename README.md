# Link shortener bot

Host your own link shortener that works with a bot. Just send the link
to a bot and it'll take care of the rest for you. Demo:
[@GiveMeShortLinkBot](http://t.me/GiveMeShortLinkBot)

## Getting Started

1. Install Docker in your local machine or server
1. Create a Telegram bot by talking to [@BotFather](https://telegram.me/BotFather)
1. Set up your own Firebase database
2. Create and fill in the credentials to the `env.yml` file, see `env.yml.example` for the template
1. run `./bin/build` from the project root folder
2. run `./bin/run` from the project root folder
3. Send a link to your bot from Telegram, you should be see reply like (you will need to set up a [backend](https://github.com/tommyku/link-shortener-front-end) too.)

```
YOU: http://example.com
BOT: Wow, try http://randomhost.name/abcdefgh
```

### Prerequisites

1. Following the Docker [installation guide](https://docs.docker.com/engine/installation/).
1. Create a Telegram bot with [@BotFather](https://telegram.me/BotFather)
1. Set up Firebase database from the [official site](https://firebase.google.com/).

### Installing

After cloning the repo, you should create and fill in the credentials to the `env.yml` file, see `env.yml.example` for the template

To run locally using Docker:

``` bash
$ ./bin/build
$ ./bin/run
```

To run without Docker (requires locally installed Ruby 2.3.1+):

``` bash
$ bundle install
$ ruby link-shortener-bot.rb
```

## Deployment

On the deployment machine:

``` bash
$ ./bin/build
$ ./bin/run
```

## Built With

* [Docker](https://www.docker.com/) - For building and deploying the image
* [atipugin/telegram-bot-ruby](https://github.com/atipugin/telegram-bot-ruby) - Telegram API wrapper
* [tommyku/telegram-bot-starter](https://github.com/tommyku/telegram-bot-starter) - A telegram bot Boilerplate


## License

This project is an open-sourced software licensed under the [MIT license](http://opensource.org/licenses/MIT).
