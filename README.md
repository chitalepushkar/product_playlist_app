# product playlist app
An app to create a musicaal playlist based on user's search category.

### Prerequisites
1. Ruby
2. PostgreSQL
3. NPM/Yarn

### Installation
1. Install RVM and ruby: https://rvm.io/rvm/install
2. Install PostgreSQL for Ubuntu using the following [guide](https://www.digitalocean.com/community/tutorials/how-to-use-postgresql-with-your-ruby-on-rails-application-on-ubuntu-18-04).
Refer the following [guide](https://www.postgresql.org/download/macosx/) for installation procedure for Mac.
3. Please refer the following [guide](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm) to install NodeJS and NPM.
You can also install Yarn with the help of this [page](https://classic.yarnpkg.com/en/docs/install/#debian-stable)
4. Clone the repository.

### Setup

1. On terminal, change directory to product_playlist_app and run command `bundle install`. This will install all the gems required to run the application.
2. In the project's `config/database.yml` file, change the username, password, hostname to the PSQL server setup on your local machine.
```
default: &default
  adapter: postgresql
  encoding: unicode
  # For details on connection pooling, see Rails configuration guide
  # https://guides.rubyonrails.org/configuring.html#database-pooling
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  host: <%= ENV["DEV_DB_HOSTNAME"] || 'localhost' %>
  username: <%= ENV["DEV_DB_USERNAME"] || 'product_playlist_admin' %>
  password: <%= ENV["DEV_DB_PASSWORD"] || 'password' %>

development:
  <<: *default
  database: <%= ENV["DEV_DB_NAME"] || 'product_playlist_app_development' %>
```
3. Once done, run the following commands:
a. `rake db:create` to create the development database.<br/>
b. `rake db:migrate` to create the `playlists` and `playlist_tracks` tables.
4. Once all of these steps are performed, start the server using the command: `rails s`
5. Try hitting `http://localhost:3000` from your browser to check if app has started successfully.

### Usage
The app provides 2 APIs to perform the following actions:<br/> 
1. Create playlist based on user's search query.<br/>
2. Return the next relevent song details in the playlist based on the last played song 
Details of each API is given below.

#### Create Playlist API
This endpoint is used to create a playlist based on user's search string.<br/>
Endpoint: POST: `/playlists`<br/>
Required Parameters: category<br/>
Request body:
```
{
    "category": "<search string>"
}
```
A sample request looks something like this:
```
POST http://localhost:3000/playlists

{
    "category": "Pots and Pans"
}
```

A sample JSON response will look something like this: 
```
{
    "id": 41,
    "category": "Pots and Pans",
    "created_at": "2020-10-13T18:42:14.385Z",
    "updated_at": "2020-10-13T18:42:14.385Z",
    "tracks": [
        {
            "id": 90,
            "playlist_id": 41,
            "title": "Pioneers Over C - 2005 Digital Remaster",
            "artist": "Van Der Graaf Generator",
            "lyrics": "We left the earth in 1983\nFingers groping for the galaxies\nReddened eyes stared up into the void\nA thousand stars to be exploited\nSomebody help me, I'm falling\nSomebody help me, I'm falling down\n\nInto sky, into earth\nInto sky, into earth\n\nIt is so dark around, no life, no hope, no sound\nNo chance of seeing home again\n\nThe universe is on fire, exploding without flame\n\nWe are the lost ones; we are the pioneers; we are the lost ones\nWe are the ones they are going to build a statue for\nTen centuries ago or were going to fifteen forward\n\nOne last brief whisper in our loved ones' ears\n...\n\n******* This Lyrics is NOT for Commercial use *******\n(1409619881554)",
            "created_at": "2020-10-13T18:42:15.263Z",
            "updated_at": "2020-10-13T18:42:15.470Z"
        },
        {
            "id": 89,
            "playlist_id": 41,
            "title": "Touched By The Midnight Sun",
            "artist": "The Legendary Pink Dots",
            "lyrics": "Falling stars,\nCrossed fingers,\nAnd a penny in the well...\n\nA solitary man\nLooked in the mirror, whispered:\n\"It is hell...\nTo always be alone...\nTo hide in shadows,\nYet that spiteful sun\nShould turn me yellow...\n...\n\n******* This Lyrics is NOT for Commercial use *******\n(1409619881554)",
            "created_at": "2020-10-13T18:42:14.831Z",
            "updated_at": "2020-10-13T18:42:15.015Z"
        }
    ]
}
```

#### Get next track in playlist API
This API provides us with the functionality to fetch the next song based on the lyrics of the earlier song.<br/>
Endpoint: GET: `/playlists/:playlist_id/next_track/:current_track_id`<br/>
Required Parameters: playlist_id, current_track_id<br/>

A sample request looks something like this:
```
GET http://localhost:3000/playlists/40/next_track/87
```

A sample JSON response will look something like this: 
```
{
    "id": 88,
    "playlist_id": 40,
    "title": "Everybody knows",
    "artist": "Honest Bob and the Factory-to-Dealer Incentives",
    "lyrics": "They look at me\nAnd they don't like what they see\nI can hear them whispering\nI know just what they heard\nThey're repeating every word\nI can see right through their eyes\nI wish that I could take it back\nAnd let the movie fade to black\n\nBut everybody knows\nEverybody knows\nEverybody knows by now\nAnd I won't talk to anyone\nAnd I won't look at anyone\n...\n\n******* This Lyrics is NOT for Commercial use *******\n(1409619881554)",
    "created_at": "2020-10-13T18:29:11.019Z",
    "updated_at": "2020-10-13T18:29:11.252Z"
}
```

### Future enhancements
1. Adding authorization and authentication mechanism.
2. Caching to improve API performance.
3. Adding unit tests.
