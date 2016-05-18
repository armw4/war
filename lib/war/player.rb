module War
  class Player
    attr_reader :opponent

    def initialize(deck = nil)
      @deck = deck
      @cards_won = []
      @cards_accepted = []
    end

    def play_card
      @cards_accepted.pop
    end

    def opponent=(player)
      raise "cannot play self" if self.equal? player

      @opponent = player
    end

    def deal
      raise "opponent required to deal" unless @opponent
      raise "deck required to deal"     unless @deck

      players = { 0 => @opponent, 1 => self }
      current_player_id = 0

      while card = @deck.next
        player = players[current_player_id]

        puts "dealing card #{card} to #{current_player_id == 1 ? "self" : "opponent"}"

        player.accept_card card

        current_player_id ^= 1
      end
    end

    def accept_card(card)
      @cards_accepted << card
    end

    def take_cards_won(cards)
      @cards_won.concat cards
    end

    def won?
      score == 52
    end

    def score
      @cards_won.length
    end

    def restart
      @cards_won.clear
      @cards_accepted.clear
      @deck = Deck.new if @deck
    end
  end
end
