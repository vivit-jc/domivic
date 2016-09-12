class Player

attr_reader :hand, :trash, :deck, :name, :cities, :techs

  def initialize(name)
    @name = name
    @deck = []
    @trash = []
    6.times do |i|
      @deck.push Card.new Proc.new { |c|
        c.set_name :research
        c.set_name_j "研究"
        c.set_research 1
        c.die i
      }
    end
    3.times do 
      @deck.push Card.new Proc.new { |c|
        c.set_name :military
        c.set_name_j "戦士"
        c.power 1
      }
    end
    @deck.push Card.new Proc.new { |c|
      c.set_name :culture
      c.set_name_j "文化"
      c.set_culture 1
    }
    @deck.shuffle!
    @hand = []
    draw(5)
    @cities = [rand(6)]
    @techs = []
  end

  def draw(n)
    n.times do
      if @deck.size == 0
        @deck = @trash.shuffle
        @trash = []
      end
      @hand.push @deck.pop
    end
  end

  def add_cards_to_trash(cards)
    @trash += cards
  end

  def has_tech?(no)
    @techs.include? no
  end

  def get_tech(no, tech_data)
    @techs.push no
    add_cards_to_trash(tech_data.cards)
  end

  def end_turn
    @trash += @hand
    @hand = []
    draw(5)
  end

  def research(game)
    research = 0
    @hand.each do |card|
      case card.name
      when :research
        research += card.research
        game.all_cities.each do |city|
          card.dice.each do |d|
            research += 1 if city == d
          end
        end
      end
    end
    return research
  end

end