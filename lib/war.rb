$:.unshift File.dirname(__FILE__)

require "war/card"
require "war/deck"
require "war/player"
require "war/game"

deck     = War::Deck.new
dealer   = War::Player.new("dealer", deck)
opponent = War::Player.new("opponent")
game     = War::Game.new(dealer, opponent)

game.start
