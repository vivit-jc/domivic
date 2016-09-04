class Tech

attr_reader :cards, :name, :name_j, :effects, :cost, :doc

  def init
    if @cards
      @cards = @cards.map do |card|
        Card.new(card)
      end
    else
      @cards = []
    end
    @effects = [] unless @effects
  end


end