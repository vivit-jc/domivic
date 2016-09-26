class Computer < Player

  def initialize(name)
    super(name)
    @ai_type = [:war, :science, :culture].sample
  end

  def thinking(tech_data)
    log = []
    @action = 1
    while(@action > 0)
      select_hand
    end
    select_tech(tech_data)
  end

  def select_hand
    p "COM select hand"
    @action -= 1
  end

  def select_tech(tech_data)
    
  end

end