$:.unshift File.dirname(__FILE__)

require "war/card"
require "war/deck"
require "war/player"
require "war/game"

deck = War::Deck.new
dealer = War::Player.new(deck)
opponent = War::Player.new
game = War::Game.new(dealer, opponent)

game.start
