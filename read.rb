require_relative 'game'
require 'pp'
require 'readline'

def show_main(game)
  game.countries.each do |e|
    print "#{e.name} #{e.cities[0]}, "
  end
  print "\n"
  game.player.hand.each do |c|
    print "#{c.name_j} #{c.dice} #{c.doc} "
    print "R#{c.research} C#{c.culture} P#{c.power}\n"
  end
  print "\n"
  print "R(#{game.player.research},#{game.player.now_research(game)})"
  print " C " + game.player.culture.to_s
  print " deck " + game.player.deck.size.to_s
  print " trash " + game.player.trash.size.to_s
  print " action " + game.player.action.to_s + "\n"
  print game.player.techs.map{|t|game.tech_data[t].name_j}.to_s + "\n"
  game.click(:view_main)
end

def show_tech_list(game)
  game.tech_data.each_with_index do |t,i|
    print t.name_j+" "+t.cost.to_s+" "
    print "\n" if (i+1)%4 == 0
  end
  print "\n"
  game.click(:view_tech_list)
end

game = Game.new

while(1)
  buf = Readline.readline("> ", true)

  case buf
  when "m"
    show_main(game)
    next
  when "s"
    show_tech_list(game)
    next
  when "e"
    exit
  end

  next unless buf =~ /[0-9]+/
  game.click(buf.to_i)

end
