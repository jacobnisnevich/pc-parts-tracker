# Movie Suggestions

## Build Instructions

In order to run Movie Suggestor locally you must have Ruby installed and you must have a themoviedb API key stored in a environment variable name "TMDB". After cloning the repo, you can install all dependencies with ```bundle install```. Then run the app with ```ruby app.rb```. The app should be viewable at ```localhost:4567```.

## About

Movie Suggestor uses a combination of the spotlite gem, the themoviedb gem, and some IMDB advanced search scraping to create a list of similar movies based on a variety of criteria. Internally, Movie Suggestor computes a similarity score for each movie based on genre, director, cast, and year of release.