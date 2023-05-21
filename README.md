# Proxx Game
Proximity game, be careful it pulls in...

This is a port of a https://proxx.app/ game, so it can be played in the terminal window, a.k.a Minesweeper.

## How to play
An unrevealed cell might have a black hole behind it, it might not. The idea is to clear all the cells that don't have black holes behind them.

But, cells are unrevealed, right? So how are you supposed to avoid them?

Here's how: If you avoid revealing a black hole during the move, the number tells you how many of the 8 surrounding cells are a black hole. If it's blank, none of the surrounding cells is a black hole.
Continue moving and revealing cells until only those with a black hole behind it are unrevealed.

## How to run a game
### If you have ruby >= 2.7 installed
1. `git clone git@github.com:John-Li/proxx_game.git`
2. `cd proxx_game`
3. `ruby proxx_game.rb`

### If you have Docker installed
1. `git clone git@github.com:John-Li/proxx_game.git`
2. `cd proxx_game`
3. `docker-compose run game`