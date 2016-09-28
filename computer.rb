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
        [tech, tech.cost * 2]
      else
        [tech, tech.cost]
      end
    end
    p @techs
    @techs.map{|t|tech_data[t].name}.each do |tname|
      techarray.reject!{|tech|tech[0].name == tname}
    end
    techarray.sort_by! {|t|t[1]}
    if techarray.size == 0
      tech = nil
    elsif techarray.size >= 2 && techarray[-1][1] == techarray[-2][1]
      tech = [techarray[-1], techarray[-2]].sample
    else
      tech = techarray[-1]
    end
    return unless tech
    tech_no = @techlist[tech[0].name]
    get_tech(tech_no, tech_data[tech_no])
  end

end