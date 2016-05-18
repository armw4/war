
module War
  SUITS = %W(diamond heart club spade).freeze
  CARDS = %W(deuce three four five six seven eight nine ten jack queen king ace).freeze
  ALL_CARDS = SUITS.map { |suit|
    CARDS.map.with_index { |card, index| Card.new(index + 1, suit, card) }
  }.flatten

  class Deck
    def initialize
      @cards = ALL_CARDS.clone.shuffle
    end

    def next
      @cards.shift
    end
  end
end
