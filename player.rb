class Player

attr_accessor :action, :research, :culture
attr_reader :hand, :trash, :deck, :name, :cities, :techs

  def initialize(name)
    @name = name
    @deck = []
    @trash = []
    @research = 0
    6.times do |i|
      @deck.push Card.new lambda { |c|
        c.set_name :research
        c.set_name_j "研究"
        c.set_research 1
        c.die i
      }
    end
#    6.times do 
#      @deck.push Card.new lambda { |c|
#        c.set_name :growing
#        c.set_name_j "成長"
#        c.action do
#          c.draw 2
#        end
#      }
#    end
    3.times do 
      @deck.push Card.new lambda { |c|
        c.set_name :military
        c.set_name_j "戦士"
        c.set_power 1
      }
    end
    @deck.push Card.new lambda{ |c|
      c.set_name :culture
      c.set_name_j "文化"
      c.set_culture 1
    }

    @deck.each{|c|c.player = self}
    @deck.shuffle!
    @hand = []
    draw(5)
    @cities = [rand(6)]
    @techs = []
    @action = 1
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
    cards.each do |c|
      c.player = self
    end
    @trash += cards
  end

  def has_tech?(no)
    @techs.include? no
  end

  def get_tech(no, tech_data)
    @techs.push no
    add_cards_to_trash(tech_data.cards)
    @research -= tech_data.cost
  end

  def end_turn
    @trash += @hand
    @hand = []
    draw(5)
    @action = 1
  end

  def now_research(game)
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

  def add_research(game)
    @research += now_research(game)
  end

  def add_culture(game)
    10
  end

  def power(game)
    2
  end

end