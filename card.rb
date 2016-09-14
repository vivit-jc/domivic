class Card
attr_reader :effect, :power, :culture, :research, :name, :name_j, :icon, :dice
  def initialize(block)
    @data = {}
    @dice = []
    @effects = []
    block.call(self)
    @icon = @name
  end
  
  def set_name(s)
    @name = s
  end

  def set_name_j(str)
    @name_j = str
  end

  def action(&block)
    @action = block
  end

  def get_action
    @action
  end

  def draw(n)
    n.times do
      p "draw"
    end
  end

  def make_card(&block)
  end

  def make_great_person
  end

  def die(n)
    @dice.push n
  end

  def power(n)
  end

  def set_culture(n)
    @culture = n
  end

  def set_research(n)
    @research = n
  end

  def war(n)
  end

  def remove(n)
  end

  def remove_itself(n)
  end

  def add_city
  end

  def add_action(n)
  end

  def attack(n)
  end

  def change_city
  end

  def reset_deck
  end

  def set_effect(str)
    @effect = str
  end

end