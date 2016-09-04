class Card

attr_reader :data, :name, :name_j, :icon, :dice, :val

  def initialize(data)
    @data = data
    @name = data[:name]
    @name_j = name_to_j(@name)
    @dice = data[:dice]
    @val = data[:val]
    @icon = @name
  end

  def effect
    if(@name == :growing)
      return "+"+@val.to_s+"cards"
    end
    return nil
  end

  def name_to_j(s)
    case s
    when :science
      return "研究"
    when :culture
      return "文化"
    when :miritary
      return "軍隊"
    when :training
      return "訓練"
    when :trading
      return "交易"
    when :growing
      return "成長"
    when :expand
      return "拡張"
    when :war
      return "戦争"
    end
  end

end