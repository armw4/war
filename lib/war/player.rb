module War
  class Player
    attr_accessor :opponent

    def initialize(deck = nil)
      @deck = deck
      @cards_won = []
      @cards_accepted = []
      @players = { 0 => @opponent, 1 => self }
    end

    def play_card
      @cards_accepted.pop
    end

    def deal
      raise "opponent required to deal" unless @opponent
      raise "deck required to deal"     unless @deck

      current_player_id = 0

      while card = @deck.next
        player = @players[current_player_id]

        puts "dealing card #{card} to #{current_player == 1 ? "self" : "opponent"}"

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
      @cards_won.length == 52
    end

    def restart
      @cards_won.clear
      @cards_accepted.clear
      @deck = Deck.new if @deck
    end
  end
end
