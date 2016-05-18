module War
  class Card
    include Comparable

    attr_reader :rank, :suit, :name

    def initialize(rank, suit, name)
      @rank = rank
      @suit = suit
      @name = name
    end

    def <=> (card)
      @rank <=> card.rank
    end

    def to_s
      "#{@name} of #{@suit} - rank (#{@rank})"
    end
  end
end
