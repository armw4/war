module War
  class Player
    attr_reader :opponent

    def initialize(name, deck = nil)
      @deck = deck
      @base_cards = []
      @cards_won = []
      @name = name
    end

    def play_card
      card = @base_cards.pop

      if card
        return card
      else
        shuffle_base_cards!
        return @base_cards.pop
      end
    end

    def shuffle_base_cards!
      puts "#{@name} exhausted all cards"

      begin
        puts "shuffling #{@cards_won.length} cards from winnings and preparing them as new base"

        @base_cards.concat(@cards_won)
        @cards_won.clear
        @base_cards.shuffle!
      end unless @cards_won.empty?
    end

    def opponent=(player)
      raise "cannot play self" if self.equal?(player)

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
      @base_cards << card
    end

    def take_cards_won(cards)
      @cards_won.concat(cards)
    end

    def won?
      score == 52 or opponent_exhausted_winnings_and_base_cards?
    end

    def score
      @cards_won.length + @base_cards.length
    end

    def no_base_cards_remaining?
      @base_cards.empty?
    end

    private

    # the one case for this appears to be when an opponent exhausts their
    # cards during a WAR. we have no choice but to terminate the game with
    # cards left on the table (i.e.)
    #
    # current score - dealer 51 opponent 1 (0 cards on table)
    # round [552]
    # dealer w/ deuce of diamond - rank (1) [vs] opponent w/ deuce of spade - rank (1)
    # WAR!!!
    # current score - dealer 50 opponent 0 (2 cards on table)
    # opponent exhausted all cards
    def opponent_exhausted_winnings_and_base_cards?
      @opponent.no_base_cards_remaining?
    end
  end
end
