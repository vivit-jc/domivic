class Player

attr_accessor :action, :research, :culture, :remove_count, :cities, :techlist
attr_reader :hand, :trash, :deck, :removed, :name, :techs, :war, :power
attr_writer :opponents

  def initialize(name)
    @name = name
    @deck = []
    @trash = []
    @removed = []
    @opponents = []
    @research = 0
    @culture = 0
    @war = 0
    @remove_count = 0
    @techlist = []

    6.times do |i|
      @deck.push Card.new lambda { |c|
        c.set_name :research
        c.set_name_j "研究"
        c.set_doc ""
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

  # 手札から引数と一致するカードを除外する(remove_itselfで使う)
  def remove_target(card)
    rm = @hand.delete card
    @removed.push rm
  end

  def reset_deck
    @trash += @deck
    @deck = []
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

  def attack
    power = 0
    @hand.each do |c|
      next unless c.name == :military
      power += c.power + c.attack
    end
    return power
  end

  def defense
    power = 0
    @hand.each do |c|
      next unless c.name == :military
      power += c.power + c.defense
    end
    return power
  end

  def war(n)
    @opponents.each do |o|
      if attack > o.defense
        o.calc_war(-n)
        calc_war(n)
      else
        o.calc_war(n)
        calc_war(-n)
      end
    end
  end

  def calc_war(n)
    @war += n
  end

  def score
    res = @techs.size * 2
    res += @techs.size if @techs.include?(@techlist[:mathematics])
    cul = @culture
    war = @war
    return [res+cul+war,res,cul,war]
  end

end