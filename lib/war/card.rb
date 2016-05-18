module War
  class Card
    include Comparable

    attr_reader :weight, :suit, :name

    def initialize(rank, suit, name)
      @rank = rank
      @suit = suit
      @name = name
    end

    def <=> (card)
      self.rank <=> card.rank
    end

    def to_s
      "#{@name} of #{@suit} - rank (#{@rank})"
    end
  end
end
