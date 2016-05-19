require "set"

module War
  class Game
    def initialize(dealer, opponent)
      @dealer = dealer
      @opponent = opponent

      @dealer.opponent = @opponent
      @opponent.opponent = @dealer

      @cards_in_play = []
    end

    def start
      @dealer.deal
      play

      puts "game over, final score - dealer #{@dealer.score} opponent #{@opponent.score}"
      puts "player died prematurely during WAR (#{@cards_in_play.length} cards left on table)" if @cards_in_play.any?
    end

    private

    def track_cards_in_play(dealer_card, opponent_card)
      @cards_in_play << dealer_card
      @cards_in_play << opponent_card
    end

    def clear_cards_in_play
      @cards_in_play.clear
    end

    def shuffle_base_cards!
      @dealer.shuffle_base_cards!   if @dealer.no_base_cards_remaining?
      @opponent.shuffle_base_cards! if @opponent.no_base_cards_remaining?
    end

    def determine_winner_and_score(dealer_card, opponent_card)
      winner = nil

      puts "dealer w/ #{dealer_card} [vs] opponent w/ #{opponent_card}"
      puts "dealer beat opponent with #{dealer_card}"   if dealer_card   > opponent_card and winner = @dealer
      puts "opponent beat dealer with #{opponent_card}" if opponent_card > dealer_card   and winner = @opponent
      puts "WAR!!!"                                     if dealer_card == opponent_card

      if winner
        puts "crediting winner with #{@cards_in_play.length} cards"

        winner.take_cards_won(@cards_in_play)
        clear_cards_in_play
      end

      puts "current score - dealer #{@dealer.score} opponent #{@opponent.score} (#{@cards_in_play.length} cards on table)"
    end

    def play
      round = 0

      while(!@dealer.won? and !@opponent.won?) do
        puts "round [#{round += 1}]"

        dealer_card = @dealer.play_card
        opponent_card = @opponent.play_card

        track_cards_in_play(dealer_card, opponent_card)
        determine_winner_and_score(dealer_card, opponent_card)
        shuffle_base_cards!
      end
    end
  end
end
