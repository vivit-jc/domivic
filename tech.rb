class Tech
attr_reader :cards, :effect, :name, :name_j, :cost
  def initialize(block)
    @cards = []
    block.call(self)
  end

  def set_name(s)
    @name = s
  end
  
  def set_name_j(str)
    @name_j = str
  end

  def set_cost(n)
    @cost = n
  end

  def card(&block)
    @cards.push Card.new(block)
  end

  def set_effect(str)
    @effect = str
  end

  def get # 値を返却するためのメソッド
    p self
  end
end