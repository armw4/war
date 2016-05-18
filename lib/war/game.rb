module War
  class Game
    def initialize(dealer, opponent)
      @dealer = dealer
      @opponent = opponent
      @cards = []
      @game_count = 0

      @dealer.opponent = @opponent
      @opponent.opponent = @dealer
    end

    def start
      puts "starting game #{@game_count += 1}"
      @dealer.deal
      play

      puts "game over, final score - dealer #{@dealer.score} opponent #{@opponent.score}"
      puts "dealer wins"   if @dealer.won?   and return
      puts "opponent wins" if @opponent.won? and return

      if @game_count == 5038
        puts "maximum number of games played (5038), terminating"
      else
        restart
      end
    end

    private

    def play
      round = 0

      while(dealer_card = @dealer.play_card and opponent_card = @opponent.play_card)
        winner = nil

        puts "round #{round += 1} of game #{@game_count}\n"
        puts "dealer w/ #{dealer_card} [vs] opponent w/ #{opponent_card}"
        puts "dealer beat opponent with #{dealer_card}"   if dealer_card   > opponent_card and winner = @dealer
        puts "opponent beat dealer with #{opponent_card}" if opponent_card > dealer_card   and winner = @opponent
        puts "draw"                                       if dealer_card == opponent_card

        @cards << dealer_card
        @cards << opponent_card

        if winner
          puts "crediting winner with #{@cards.length} cards"

          winner.take_cards_won(@cards)
          @cards.clear
        end
      end
    end

    def restart
      @cards.clear

      @dealer.restart
      @opponent.restart

      start
    end
  end
end
