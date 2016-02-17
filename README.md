[![Stories in Ready](https://badge.waffle.io/npauzenga/meet_meeples-server.png?label=ready&title=Ready)](https://waffle.io/npauzenga/meet_meeples-server)
[![Build Status](https://travis-ci.org/npauzenga/meet_meeples-server.svg?branch=master)](https://travis-ci.org/npauzenga/meet_meeples-server)
[![Coverage Status](https://coveralls.io/repos/npauzenga/meet_meeples-server/badge.svg?branch=master&service=github)](https://coveralls.io/github/npauzenga/meet_meeples-server?branch=master)
[![Code Climate](https://codeclimate.com/github/npauzenga/meet_meeples-server/badges/gpa.svg)](https://codeclimate.com/github/npauzenga/meet_meeples-server)
## Meet Meeples
A social network for board game geeks. The goal of the site is to connect users to a focused community of local gamers. Users can create a profile,
join and create groups, and schedule Game Nights within their groups.

## The API
This repo represents the Rails back-end to the upcoming Ember front-end. It lives at `api.meetmeeples.com`

## Installation and setup
1) Fork and clone the repo

2) Run `$bundle install` to install our minimal set of dependencies

3) Setup the Postgres database (TODO needs description)

4) Run `$rails s` to start the server

## Documentation and Endpoints
- See the [docs](http://api.meetmeeples.com/docs) for details including example requests and JSON responses
- See the [schema](https://github.com/npauzenga/meet_meeples-server/blob/master/config/schema/api.md) for the in-progress JSON-API-compliant schema used for request and response validations
