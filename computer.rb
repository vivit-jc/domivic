class Computer < Player

  def initialize(name)
    super(name)
    @ai_type = [:war, :science, :culture].sample
  end

  def thinking
    log = []
    @action = 1
    while(@action > 0)
      select_hand
    end
    select_tech
  end

  def select_hand
  end

  def select_tech
  end

end