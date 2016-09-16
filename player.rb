class Player

attr_accessor :action, :research, :culture, :remove_count
attr_reader :hand, :trash, :deck, :removed, :name, :cities, :techs

  def initialize(name)
    @name = name
    @deck = []
    @trash = []
    @removed = []
    @research = 0
    @culture = 0
    @remove_count = 0

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

  def discard(n)
    card = @hand.delete_at n
    @trash.push card
  end

  def remove(n)
    card = @hand.delete_at n
    @removed.push card
  end

  def now_research(cities)
    research = 0
    @hand.each do |card|
      case card.name
      when :research
        research += card.research
        cities.each do |city|
          card.dice.each do |d|
            research += 1 if city == d
          end
        end
      end
    end
    return research
  end

  def add_research(cities)
    @research += now_research(cities)
  end

  def now_culture(cities)
    culture = 0
    @hand.each do |card|
      case card.name
      when :culture
        culture += card.culture
        cities.each do |city|
          card.dice.each do |d|
            culture += 1 if city == d
          end
        end
      end
    end
    return culture
  end

  def add_culture(cities)
    @culture += now_culture(cities)
  end

  def power(game)
    2
  end

end