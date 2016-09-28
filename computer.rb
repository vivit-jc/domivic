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
        [tech.name => tech.cost * 2}
      else
        {tech.name => tech.cost }
      end
    end
    @techlist.map{|t|tech_data[t].name}.each do |tname|
      techarray.reject!{|tech|tech.to_a[0] == tname}
    end
    techarray.sort! {|(k1, v1), (k2, v2)| v2 <=> v1 }
    if techarray.size == 0
    elsif techarray.size >= 2 && techarray[-1].to_a[1] == techarray[-2].to_a[1]
      tech = [techarray[-1], techarray[-2]].sample
    else
      tech = techarray[-1]
    end
    tech_data.each_with_index do |t,no|
      tech_no = no 
    end
    get_tech()
  end

end