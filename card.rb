class Card
attr_writer :player
attr_reader :effect, :power, :attack, :defense, :culture, :research, :name, :name_j, :icon, :dice, :doc
  def initialize(block)
    @data = {}
    @dice = []
    @doc = ""
    @effects = []
    @research = 0
    @culture = 0
    @power = 0
    @attack = 0
    @defense = 0
    block.call(self)
    @icon = @name
  end
  
  def set_name(s)
    @name = s
  end

  def set_name_j(str)
    @name_j = str
  end

  def set_doc(str)
    @doc = str
  end

  def action(&block)
    @action = block
  end

  def has_action?
    return @action != nil
  end

  def get_action
    @action
  end

  def draw(n)
    @player.draw(n)
  end

  def make_card(&block)
  end

  def make_great_person
  end

  def die(n)
    @dice.push n
  end

  def set_power(n)
    @power = n
  end

  def set_culture(n)
    @culture = n
  end

  def set_research(n)
    @research = n
  end

  def add_culture(n)
    @player.culture += n
  end

  def add_research(n)
    @player.research += n
  end

  def war(n)
  end

  def remove(n)
    @player.remove_count = n
  end

  def remove_itself
    @player.remove_target(self)
  end

  def add_city
    @player.cities.push rand(6)
  end

  def add_action(n)
    @player.action += n
  end

  def set_attack(n)
    @attack = n
  end

  def change_city
  end

  def discard
  end

  def reset_deck
    @player.reset_deck
  end

  def set_effect(str)
    @effect = str
  end

end