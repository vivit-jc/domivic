class Player

attr_reader :hand, :deck, :name, :cities

  def initialize(name)
    @name = name
    @deck = [Card.new({name: :science, dice: 0, val: 1}),
        Card.new({name: :science, dice: 1, val: 1}),
        Card.new({name: :science, dice: 2, val: 1}),
        Card.new({name: :science, dice: 3, val: 1}),
        Card.new({name: :science, dice: 4, val: 1}),
        Card.new({name: :science, dice: 5, val: 1}),
        Card.new({name: :miritary, val: 1}),
        Card.new({name: :miritary, val: 1}),
        Card.new({name: :miritary, val: 1}),
        Card.new({name: :culture, val: 1})].shuffle
    @hand = []
    draw(5)
    @cities = [rand(6)]
  end

  def draw(n)
    n.times do
      @hand.push @deck.pop
    end
  end

end