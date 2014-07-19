# RAE downloader

Scripts to download information from the [online version](http://lema.rae.es/drae/) of the [Dictionary of Spanish Language of the Royal Spanish Academy](https://en.wikipedia.org/wiki/Diccionario_de_la_lengua_espa%C3%B1ola_de_la_Real_Academia_Espa%C3%B1ola).

Please use these scripts responsibly and never cause [DoS attacks](http://en.wikipedia.org/wiki/Denial-of-service_attack) to the rae.es services.

## Installation

You'll need to have Ruby a PostgreSQL and a Redis server.

Setup the project with `bin/install`: this script will install the Ruby dependencies required to run the scripts and create the database where the words and their definitions will be stored. It will also create a `.env` file with some configuration parameters. You may need to adjust your PostgreSQL and Redis connection details here.

## Usage

The database contains a `words` table with the following fields:

- `word`: the string with the word
- `data`: JSON data fetched with the [nebrija](https://github.com/javierhonduco/nebrija) gem
- `defined_at`: timestamp indicating when the word got defined (i.e: when the `data` column got updated)
- `created_at` and `updated_at`: obvious timestamps

To insert words from `data/lemario.txt` into the database, run:

```
bin/seed
```

To list the number of existing words, the number of undefined ones, and the number of workers scheduled, run:

```
bin/stats
```

Run sidekiq to be able to schedule and execute workers with:

```
bin/sidekiq
```

While sidekiq runs in one terminal, open another one and workers for all the undefined words by running:

```
bin/schedule
```

Each worker uses [nebrija](https://github.com/javierhonduco/nebrija) to download the data for the word and store it in its `data` field.

Show the data for a given word with:

```
bin/show palabra
```

## Development

You can load the library in a IRB session for debugging with:

```
bin/console
```

## Data sources

- The `lemario.txt` file comes from the [collection](https://github.com/olea/lemarios/) compiled by Ismael Olea.
