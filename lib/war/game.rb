module War
  class Game
    def initialize(dealer, opponent)
      @dealer = dealer
      @opponent = opponent

      @dealer.opponent = @opponent
      @opponent.opponent = @dealer
    end

    def start
      @dealer.deal
      play

      puts "game over, final score - dealer #{@dealer.score} opponent #{@opponent.score}"
    end

    private

    def play
      round = 0
      cards = []

      while(!@dealer.won? and !@opponent.won?)
        winner = nil
        dealer_card = @dealer.play_card and opponent_card = @opponent.play_card

        cards << dealer_card
        cards << opponent_card

        puts "round #{round += 1}"
        puts "dealer w/ #{dealer_card} [vs] opponent w/ #{opponent_card}"
        puts "dealer beat opponent with #{dealer_card}"   if dealer_card   > opponent_card and winner = @dealer
        puts "opponent beat dealer with #{opponent_card}" if opponent_card > dealer_card   and winner = @opponent
        puts "draw"                                       if dealer_card == opponent_card

        if winner
          puts "crediting winner with #{cards.length} cards"

          winner.take_cards_won(cards)
          cards.clear

          @dealer.shuffle_cards
          @opponent.shuffle_cards
        end
      end
    end
  end
end
