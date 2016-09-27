class Computer < Player

  def initialize(name)
    super(name)
    @ai_type = [:war, :science, :culture].sample
  end

  def thinking(tech_data, cities)
    log = []
    @action = 1
    while(@action > 0)
      select_hand
    end
    add_research(cities)
    select_tech(tech_data)
  end

  def select_hand
    p "COM select hand"
    @action -= 1
  end

  def select_tech(tech_data)
    techarray = tech_data.select{|t|t.cost <= @research}.map do |tech|
      if tech.typearray[0] == @ai_type
        {tech.name => tech.cost * 2}
      else
        {tech.name => tech.cost }
      end
    end
    techarray.sort! {|(k1, v1), (k2, v2)| v2 <=> v1 }
    p techarray[-1][0],techarray[-2][0]
    #if techarray[-1][1] techarray[-2][1]
  end

end