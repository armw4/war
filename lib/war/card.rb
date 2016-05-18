module War
  class Card
    include Comparable

    attr_reader :weight, :suit, :name

    def initialize(weight, suit, name)
      @weight = weight
      @suit = suit
      @name = name
    end

    def <=> (card)
      self.weight <=> card.weight
    end
  end
end
