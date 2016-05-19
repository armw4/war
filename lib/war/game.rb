require "set"

module War
  class Game
    def initialize(dealer, opponent)
      @dealer = dealer
      @opponent = opponent

      @dealer.opponent = @opponent
      @opponent.opponent = @dealer

      @cards_in_play = []
      @dealer_cards_in_play = []
      @opponent_cards_in_play = []
    end

    def start
      @dealer.deal
      play

      puts "game over, final score - dealer #{@dealer.score} opponent #{@opponent.score}"
    end

    private

    def track_cards_in_play(dealer_card, opponent_card)
      @dealer_cards_in_play << dealer_card
      @opponent_cards_in_play << opponent_card

      @cards_in_play << dealer_card
      @cards_in_play << opponent_card
    end

    def clear_cards_in_play
      @dealer_cards_in_play.clear
      @opponent_cards_in_play.clear
      @cards_in_play.clear
    end

    def shuffle_player_cards
      @dealer.shuffle_cards
      @opponent.shuffle_cards
    end

    def determine_winner_and_score(dealer_card, opponent_card)
      winner = nil

      puts "dealer w/ #{dealer_card} [vs] opponent w/ #{opponent_card}"
      puts "dealer beat opponent with #{dealer_card}"   if dealer_card   > opponent_card and winner = @dealer
      puts "opponent beat dealer with #{opponent_card}" if opponent_card > dealer_card   and winner = @opponent
      puts "draw"                                       if dealer_card == opponent_card

      if winner
        puts "crediting winner with #{@cards_in_play.length / 2} card(s)"

        winner.take_cards_won(@cards_in_play)
        clear_cards_in_play
        shuffle_player_cards
      end

      puts "current score - dealer #{@dealer.score} opponent #{@opponent.score} (#{@cards_in_play.length} cards on table)"
    end

    def replay_dealer_cards
      return_cards_to_player("dealer", @dealer, @dealer_cards_in_play)
    end

    def replay_opponent_cards
      return_cards_to_player("opponent", @opponent, @opponent_cards_in_play)
    end

    def return_cards_to_player(player_name, player, player_cards_in_play)
      puts "#{player_name} exhausted all cards. returning #{player_cards_in_play.length} cards from table/play to #{player_name}"
      puts "went from #{@cards_in_play.length} on table to #{@cards_in_play.length - player_cards_in_play.length} on table"

      @cards_in_play = @cards_in_play - player_cards_in_play

      player.replay_previous_cards_won(player_cards_in_play)
      player_cards_in_play.clear
    end

    def play
      round = 0

      while(!@dealer.won? and !@opponent.won?) do
        dealer_card = @dealer.play_card
        opponent_card = @opponent.play_card

        begin
          replay_dealer_cards
          dealer_card = @dealer.play_card
        end unless dealer_card

        begin
          replay_opponent_cards
          opponent_card = @opponent.play_card
        end unless opponent_card

        puts "round #{round += 1}"

        track_cards_in_play(dealer_card, opponent_card)
        determine_winner_and_score(dealer_card, opponent_card)
      end
    end
  end
end
