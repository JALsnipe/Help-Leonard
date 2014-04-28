Help Leonard - iPhone
======================

User Stories
============
**As Leonard, I can view headlines from ESPN, so that I can keep up to date on
the latest sports news.**

Yes!  A new call is made to the Headline API every time the app is lauched.
Users can tap an article in the table view to be brought to that article in
Safari.

Plan of attack if I had time:

Add a refresh button.  Pull-to-refresh is very popular and I would have liked
to research outside libraries and animations to acomplish that.

**As Leonard, I can select a favorite team, so that I can just read the
headlines for my favorite team and not get overloaded with information about
other teams.**

Not quite.  I ran out of time here.  I have a text field set up in the Team
Info tab, but unfortinatly it's purely cosmetic.  The logic behind the team
info API calls is hard-coded into the AppDelegate in the getTeamID method.
No team info is hard-coded into the API calls.  I would have like to 

Plan of attack if I had time:

Implemented a data store to save user's team preference.  At the moment my
setup is very hacky.  I would have liked to have researched and implemented 
data spinners wchich would have allowed the user to select a sport, league,
and team without having to physically type in any values.

**As Leonard, I can read additional information about a team, so that I can
learn more about the team and its history.**

Yes!  I have a Team Info tab where the user can see their favorite team and
change it (if the implementation was there), as well as follow a link to team
info on ESPN.com.

Plan of attack if I had time:

Embed more detailed team information into the Team Info tab, possibly using the
Standings API.

**As Leonard, I can post a tweet so that Penny can read my awesome analysis of
sports news.**

Yes!  If the user taps the "Tweet it!" button on the Team Info tab, they are
brought to the twitter app with a draft tweet containing "Hello from Help-
Leonard! I love the [favorite team name]!"  From there, the user can enter
their awesome sports analysis.  The user must have the twitter app installed
on their device for this feature to work.

Plan of attack if I had time:

Attach a URL to a tweet and allow the user to tweet about a specific article.
Allow the user to compose and send a tweet from within the app (without moving
haing to move to the official Twitter app) or using the iOS Twitter API.

**As Leonard, I can find tickets to a game, so that I can plan a date for me
and Penny.**

Not implemented, ran out of time.

Plan of attack if I had time:

Use the Seat Geek API to find future game information on the user's favorite
team.  Possibly even use location-based information to track distance and
directions to the closest stadium or venue.

Additional Notes
================
Lots of the logic is done in the AppDelegate implementation file.  Although I
split some of the calls into separate methods, I did recycle some code between
methods.  It might have been better to create general methods for the API calls
that take a single URL as an argument.  In addition, I would have liked to use
Applico's BorealiOS networking library for the API calls.  As I become more
familiar with using APIs, I hope to use and improve on this in-house library.

Some of the JSON parsing into dictionaries is a little hacky.  This was my
first real experience using JSON in an iOS applicaion, and I hope to improve
upon my logic as I become more familiar with the territory.

I would have liked to include a sport subheading for each article in the main
Headline feed.  I tried doing this, but either something was wrong with my
calls/logic, or I wasn't hitting the right API.  At the moment, the subheading
just says "Sports" as a placeholder.  The articles in the Team Headlines table
say the MLB, the value I assigned to the Favorite Team object.  Ideally, the
user would have full control of this information.

The app is a Portrait-only app.  In the future, I would like to experiment with
multiple orientations and Autolayout.

I don't do a lot of error handling in the app.  If I had time, I would have
liked to implement alert views and popups to alert the user of a failed API
call, network error, or invalid team info/ID.

I wanted to have some fun with the icons.  I found them here:

http://icons8.com/preview/ios-7-icons/

I had a lot of fun making this app, more fun than I thought I would.  I would
like to keep working on this in the future and improving it as time allows.
Hey, it's actually useful to have this information a single tap away!

Thanks for this opertunity.
