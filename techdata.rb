initdata do |tech|
  tech.set_name :celeremoal_burial
  tech.set_name_j "埋葬"
  tech.set_cost 1
  tech.card do |c|
    c.set_name :culture
    c.set_name_j "文化"
    c.set_doc ":cul:3,remove 1"
    c.action do
      c.add_culture 3
      c.remove 1
    end
  end
end

initdata do |tech|
  tech.set_name :writing
  tech.set_name_j "筆記"
  tech.set_cost 2
  tech.card do |c|
    c.set_name :research
    c.set_name_j "研究"
    c.set_research 1
    c.die 0
    c.die 1
  end
  tech.card do |c|
    c.set_name :research
    c.set_name_j "研究"
    c.set_research 1
    c.die 2
    c.die 3
  end
  tech.card do |c|
    c.set_name :research
    c.set_name_j "研究"
    c.set_research 1
    c.die 4
    c.die 5
  end
end

initdata do |tech|
  tech.set_name :bronze_working
  tech.set_name_j "青銅器"
  tech.set_cost 3
  tech.card do |c|
    c.set_name :military
    c.set_name_j "斧兵"
    c.set_power 2
  end
  tech.card do |c|
    c.set_name :military
    c.set_name_j "斧兵"
    c.set_power 2
  end
  tech.card do |c|
    c.set_name :military
    c.set_name_j "斧兵"
    c.set_power 2
  end
  tech.card do |c|
    c.set_name :war
    c.set_name_j "戦争"
    c.set_doc "戦勝点3"
    c.action do 
      c.war 3
    end
  end
end

initdata do |tech|
  tech.set_name :agriculture
  tech.set_name_j "農業"
  tech.set_cost 3
  tech.card do |c|
    c.set_name :growing
    c.set_name_j "成長"
    c.set_doc "draw 2"
    c.action do 
      c.draw 2
    end
  end
  tech.card do |c|
    c.set_name :growing
    c.set_name_j "成長"
    c.set_doc "draw 2"
    c.action do 
      c.draw 2
    end
  end
end

initdata do |tech|
  tech.set_name :mythology
  tech.set_name_j "神話"
  tech.set_cost 5
  tech.card do |c|
    c.set_name :culture
    c.set_name_j "文化"
    c.set_culture 2
  end
  tech.card do |c|
    c.set_name :culture
    c.set_name_j "文化"
    c.set_culture 2
  end
end


initdata do |tech|
  tech.set_name :currency
  tech.set_name_j "通貨"
  tech.set_cost 7
  tech.card do |c|
    c.set_name :trading
    c.set_name_j "交易"
    c.set_doc ":res:2,:cul:1,action 1"
    c.action do 
      c.add_action 1
      c.add_research 2
      c.add_culture 1
    end
  end
end



initdata do |tech|
  tech.set_name :masonry
  tech.set_name_j "石工術"
  tech.set_cost 7
  tech.set_effect "防御ボーナス+3"
end

initdata do |tech|
  tech.set_name :iron_working
  tech.set_name_j "鉄器"
  tech.set_cost 10
  tech.card do |c|
    c.set_name :training
    c.set_name_j "訓練"
    c.set_doc "remove 1,【剣士】:pow:2,攻撃ボーナス1"
    c.action do 
      c.remove 1
      c.make_card do |mc|
        mc.set_name :military
        mc.set_name_j "剣士"
        mc.set_power 2
        mc.attack 1
      end
    end
  end
  tech.card do |c|
    c.set_name :expand
    c.set_name_j "拡張"
    c.set_doc "都市を追加,remove 2,remove itself"
    c.action do
      c.remove 2
      c.add_city
      c.remove_itself
    end
  end
  tech.card do |c|
    c.set_name :war
    c.set_name_j "戦争"
    c.set_doc "戦勝点3"
    c.action do 
      c.war 3
    end
  end
end

initdata do |tech|
  tech.set_name :monarchy
  tech.set_name_j "君主制"
  tech.set_cost 3
  tech.card do |c|
    c.set_name :crown
    c.set_name_j "権威"
    c.set_doc "action 2"
    c.action do 
      c.add_action 2
    end
  end
end

initdata do |tech|
  tech.set_name :mathematics
  tech.set_name_j "数学"
  tech.set_cost 3
  tech.card do |c|
    c.set_name :research
    c.set_name_j "研究"
    c.set_doc ":res:4,remove 1,action 1"
    c.action do 
      c.add_research 4
      c.remove 1
      c.add_action 1
    end
  end
end

initdata do |tech|
  tech.set_name :laws
  tech.set_name_j "法律"
  tech.set_cost 7
  tech.card do |c|
    c.set_name :crown
    c.set_name_j "権威"
    c.set_doc "action 2"
    c.action do 
      c.add_action 2
    end
  end
  tech.card do |c|
    c.set_name :growing
    c.set_name_j "成長"
    c.set_doc "draw 1,山札を全て捨てる"
    c.action do 
      c.draw 1
      c.reset_deck
    end
  end
end

initdata do |tech|
  tech.set_name :chivalry
  tech.set_name_j "騎士道"
  tech.set_cost 3
  tech.card do |c|
    c.set_name :training
    c.set_name_j "訓練"
    c.set_doc "remove 1,【騎士】:pow:3,攻撃ボーナス2"
    c.action do 
      c.remove 1
      c.make_card do |mc|
        mc.set_name :military
        mc.set_name_j "騎士"
        mc.set_power 3
        mc.attack 2
      end
    end
  end
  tech.card do |c|
    c.set_name :war
    c.set_name_j "戦争"
    c.set_doc "戦勝点6"
    c.action do 
      c.war 6
    end
  end
end

initdata do |tech|
  tech.set_name :irrigation
  tech.set_name_j "灌漑"
  tech.set_cost 3
  tech.card do |c|
    c.set_name :growing
    c.set_name_j "成長"
    c.set_doc "draw 3"
    c.action do 
      c.draw 3
    end
  end
  tech.card do |c|
    c.set_name :growing
    c.set_name_j "成長"
    c.set_doc "draw 3"
    c.action do 
      c.draw 3
    end
  end
end

initdata do |tech|
  tech.set_name :engineering
  tech.set_name_j "工学"
  tech.set_cost 3
  tech.card do |c|
    c.set_name :expand
    c.set_name_j "拡張"
    c.set_doc "都市を追加,remove 3,remove itself"
    c.action do 
      c.add_city
      c.remove 3
      c.remove_itself
    end
  end
  tech.card do |c|
    c.set_name :training
    c.set_name_j "訓練"
    c.set_doc "【カタパルト】:pow:2,攻撃ボーナス5"
    c.action do 
      c.make_card do |mc|
        mc.set_name :military
        mc.set_name_j "カタパルト"
        mc.set_power 2
        mc.attack 5
      end
    end
  end
end

initdata do |tech|
  tech.set_name :philosophy
  tech.set_name_j "哲学"
  tech.set_cost 3
  tech.card do |c|
    c.set_name :culture
    c.set_name_j "文化"
    c.set_doc "偉人を1人得る"
    c.action do 
      c.make_great_person
      c.remove_itself
    end
  end
end

initdata do |tech|
  tech.set_name :navigation
  tech.set_name_j "航海術"
  tech.set_cost 3
  tech.card do |c|
    c.set_name :trading
    c.set_name_j "交易"
    c.set_doc ":cul:3,action 1"
    c.action do 
      c.add_culture 3
      c.add_action 1
    end
  end
end

initdata do |tech|
  tech.set_name :diplomacy
  tech.set_name_j "外交"
  tech.set_cost 3
  tech.card do |c|
    c.set_name :diplomacy
    c.set_name_j "外交"
    c.set_doc ":dip:1"
    c.action do 
      c.change_city
    end
  end
end

initdata do |tech|
  tech.set_name :democracy
  tech.set_name_j "民主主義"
  tech.set_cost 3
  tech.card do |c|
    c.set_name :crown
    c.set_name_j "権威"
    c.set_doc "action 2"
    c.action do 
      c.add_action 2
    end
  end
end

initdata do |tech|
  tech.set_name :bureaucracy
  tech.set_name_j "官僚制"
  tech.set_cost 3
  tech.card do |c|
    c.set_name :expand
    c.set_name_j "拡張"
    c.set_doc "都市を追加,remove 2,remove itself"
    c.action do 
      c.add_city
      c.remove 2
      c.remove_itself
    end
  end
  tech.card do |c|
    c.set_name :growing
    c.set_name_j "成長"
    c.set_doc "draw 3,remove 1"
    c.action do
      c.draw 3
      c.remove 1
    end
  end
end
