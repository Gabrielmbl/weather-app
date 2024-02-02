# Weather_app

Going to the deployed app with Heroku on [weather_app](https://aqueous-reef-72990-bd95d46ca81d.herokuapp.com/),
you can view the weather forecast for the next 7 days (high and low temperatures)
for previous locations listed with IP addresses and regular addreses. Also, on the bottom of the page
you can select `New location` and type in the information for you to get the weather forecast for a
new location. <br />
When clicking `Show this location`, you can edit it, and even delete it by clicking
`Destroy this location`. <br />
APIs https://ipapi.co/ , https://geocode.xyz/api , and https://open-meteo.com/en/docs were used for this project.


## Prerequisites
- AWS Cloud9:
  - Ubuntu Server
  - Instance Type: I opted for m4.large (8 GIB RAM + 2vCPU) so that I would not run out of space, as it happened before when I was testing other tutorials.
- Gemfile:
  - After cloning project from GitHub, run `bundle instal` to make sure that the dependencies are in your machine.
  - /weather_app/Gemfile:
    ```ruby
    source "https://rubygems.org"
    git_source(:github) { |repo| "https://github.com/#{repo}.git" }

    ruby "3.1.2"

    gem "rails",           "7.0.4"
    gem "sassc-rails",     "2.1.2"
    gem "sprockets-rails", "3.4.2"
    gem "importmap-rails", "1.1.0"
    gem "turbo-rails",     "1.1.1"
    gem "stimulus-rails",  "1.0.4"
    gem "jbuilder",        "2.11.5"
    gem "puma",            "5.6.4"
    gem "bootsnap",        "1.12.0", require: false
    gem "pg", "1.3.5"
    gem 'httparty'
    gem 'assert_json'
    gem 'json_expressions'

    group :development, :test do
      gem "debug",   "1.5.0", platforms: %i[ mri mingw x64_mingw ]
    end

    group :development do
      gem "web-console", "4.2.0"
    end

    group :test do
      gem "capybara",           "3.37.1"
      gem "selenium-webdriver", "4.2.0"
      gem "webdrivers",         "5.0.0"
      gem 'vcr'
      gem 'webmock'
    end

    ```

- Database:
  - I had issues with `sqlite3`, so I ended up using postgresql. You can create a postgresql database
  by typing in `rails db:create` in the terminal, and under /weather_app/config/database.yml,
  make the appropriate changes to your database name and password.

## Installation
```bash
# Clone the repository
git clone https://github.com/Gabrielmbl/weather-app.git

# Go to application's directory
cd weather-app

# Install dependencies
bundle install

# Set up the database
# Install postgresql in case you don't have it
sudo apt install postgresql postgresql-contrib
```
Configure database.yml with your own username and password.

```bash
# Create database
rails db:create

# Migrate
rails db:migrate

# Start the application locally
rails server

```


