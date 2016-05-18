module War
  class Game
    def initialize(dealer, opponent)
      @dealer = dealer
      @opponent = opponent
      @cards = []

      @dealer.opponent = @opponent
      @opponent.opponent = @dealer
    end

    def start
      @dealer.deal

      while(dealer_card = @dealer.play_card and opponent_card = @opponent.play_card)
        puts
        puts "dealer w/ #{dealer_card} [vs] opponent w/ #{opponent_card}"
        puts "dealer beat opponent with #{dealer_card}"   if dealer_card   > opponent_card and winner = @dealer
        puts "opponent beat dealer with #{opponent_card}" if opponent_card > dealer_card   and winner = @opponent
        puts "draw"                                       if dealer_card == opponent_card

        @cards << dealer_card
        @cards << opponent_card
      end
    end

    def restart
      @cards.clear

      player1.restart
      player2.restart

      start
    end
  end
end
