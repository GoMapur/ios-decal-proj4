# App Name: 
Guess Correlation Plus

## Authors: 
• Mingjian Lu

## Purpose:
This is a little game to entertain data scientists LOL. Might train your intuition to data relationships. It will be a clone (maybe also extends) this
website: http://guessthecorrelation.com/

## Features:
- Cute game interface
- Might implement online fighting system
- This is game is still under development, thus plz wait for more things to come!

## Control Flow:
- User at an starting UI
- USer chooses new game
- User showed a graph
- User entered a number
- User loses, losing 1 point life
- User showed the correct correlation
- User showed a new graph
- User repeats
- Game ends
- User returned to the main menu
- Or can choose online game
- Match with another player
- Basically doing the same thing, except that user can see other's progress and the game could be timed

## Implementation:
The Implementation is intuitive thus I want to add some new data games in this app.

## Model:
- DataKit

## View:
- MainMenuStartButton
- MainMenuBackgroundView
- GridView
- ScatterPlotView
- LineAnimationView

## Controller:
- MainMenuViewController
- LinearGUessCorrelationGameViewController

## Credits:
- σ (sigma) - statistics library written in Swift for calculation of stats data
- ZFRippleButton for great looking button effect
- SCLAlertView for nice pop up window
- ASValueTrackingSlider for nice looking slider
