## Sports
Add a new sport from the home menu

## Teams
Add a new team to a sport (1 sport per team)

## Players
Add a new player to the league
Player can join a team (1 team per sport)

# User Types

* Admins: A league administrator. He decides which sports are included, how many teams are allowed, etc.
* Team Captains: The manager for an individual team.
* Players: The athletes stored in the database as Players, who actually play the sports.
* User: Anyone who uses this program for any reason.

# Stories

## User creates account

As a user
In order to begin using this program
I want to be able to create an account

Acceptance Criteria
* User runs the program
* User enters his username when prompted
* Program does not recognize the user, asks him if he wants to create a new account
* User accepts
* User provides additional required details to the program
* User's account is stored to the database

## User signs in

As a user
In order to use this program
I want to be able to sign in with my username

Acceptance Criteria
* User runs the program
* User enters his username when prompted

## User edits account

As a user
In order to update my information
I want to be able to edit my account data

Acceptance Criteria
* User chooses to edit his own information from a PlayersController
* User follows the command prompts to provide new information about his profile

## User views all sports, teams, players

As a user
In order to know who and what is a part of the league
I want to be able to view all sports, teams, and players in the league

Acceptance Criteria
* User enters the command to view all instances of sports, teams, or players
* All public data regrading the user's selection is displayed to him

## Admin adds sports in his league

As an admin
In order to offer sports to players
I want to be able to add them to my league

Acceptance Criteria:
* Admin chooses to add a sport from the main menu
* Admin is prompted for the name of the sport, how many teams are allowed, and how big each team can be

## Admin manages sports in his league

As an admin
In order to manage existing sports
I want to be able to edit them or remove them from my league

Acceptance Criteria:
* Admin chooses a sport from the main menu
* Admin can delete the sport
* Admin can change the sport's name, change the size of teams, or change the number of teams

## Team captain creates a team

As a team captain
In order to start a team
I want to be able to create a team for a specific sport

Acceptance Criteria:
* Captain chooses a sport from the main menu
* A new team can be created if there is a vacancy in the sport

## Team captain removes his players

As a team captain
In order to manage my team
I want to be able to remove players

Acceptance Criteria:
* Captain chooses his teams from the main menu
* Captain chooses the team he wants to manage
* Players can be individually removed from his team

## Team captain drafts his players

As a team captain
In order to manage my team
I want to be able to draft players

Acceptance Criteria:
* Captain chooses to view players from the main menu
* Captain chooses to invite a player from the list

## Player joins a team

As a player
In order to play a sport
I want to be able to join a team

Acceptance Criteria:
* Player chooses a sport from the main menu
* Player chooses a team from the list of teams with vacancies
* Player requests to join team

## Player leaves a team

As a player
In order to quit a sport
I want to be able to leave a team

Acceptance Criteria:
* Player chooses to view his teams from the main menu
* Player chooses the team he wishes to leave
* Player chooses to leave the team
