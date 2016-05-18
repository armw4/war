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
    end

    def restart
      @cards.clear

      player1.restart
      player2.restart

      start
    end
  end
end
