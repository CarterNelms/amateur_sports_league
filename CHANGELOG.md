# Changelog

# Aug 13, commit 7

  * Polished before presentation

## Aug 12, commit 6
  
  * Created players table and model
  * Repaired schema for sports, teams, and players
  * Created memberships to link players and teams

## Aug 12, commit 5

  * Debugged existing base controller functionality
  * Allowed user to select existing database entries by name or by index (previously allowed index only)
  * Created teams table and model
  * Added references to teams and sports tables

## Aug 11, commit 4

  * Fleshed out and cleaned up the base controller class
  * Added minimum and maximum team sizes and minimum and maximum number of teams to sports

## Aug 10, commit 3

  * Created a base controller for all model controlelrs to inherit from
  * Moved most functionality of existing sports controller to the base controller

## Aug 8, commit 2

  * Integrated Activerecord
  * Created integration and model tests for adding sports to the database
  * Wrote functionality to pass tests

## Aug 5, commit 1

  * Copied in Rakefile from the cal project
  * Copied in (and adapted) Gemfile from the cal project
  * Ran bundle, which generated our Gemfile.lock
  * Ran `rspec --init` to generate `.rspec` and `spec/spec_helper.rb`
  * Wrote a basic README
  * Started a CHANGELOG
  * Ran `git init .` to initialize git repo
  * `touch amateur_sports_league`
  * `chmod +x amateur_sports_league`
