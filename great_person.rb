class GreatPerson < Card

  def initialize(person_type)
    case person_type
    when :artist
      make_artist
    when :scientist
      make_scientist
    when :engineer
      make_engineer
    when :merchant
      make_merchant
    when :general
      make_general
    end
  end

  def make_artist
    set_name :great_artist
    set_name_j "大芸術家"
    set_doc "山札を全て捨て、その枚数に等しい:cul:を得る"
    action do 
      add_city
      remove 2
      remove_itself
    end
  end

  def make_scientist
    set_name :great_scientist
    set_name_j "大科学者"
    set_doc "山札を全て捨て、その枚数に等しい:cul:を得る"
    action do 
      add_city
      remove 2
      remove_itself
    end
  end

  def make_engineer
    set_name :great_engineer
    set_name_j "大技術者"
    set_doc "山札を全て捨て、その枚数に等しい:cul:を得る"
    action do 
      add_city
      remove 2
      remove_itself
    end

  end

  def make_merchant
    set_name :great_merchant
    set_name_j "大商人"
    set_doc "山札を全て捨て、その枚数に等しい:cul:を得る"
    action do 
      add_city
      remove 2
      remove_itself
    end

  end

  def make_general
    set_name :great_general
    set_name_j "大将軍"
    set_doc "山札を全て捨て、その枚数に等しい:cul:を得る"
    action do 
      add_city
      remove 2
      remove_itself
    end
  end

end