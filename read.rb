require_relative 'game'
require 'pp'
require 'readline'

def show_main(game)
  game.countries.each do |e|
    print "#{e.name} #{e.cities[0]}, "
  end
  print "\n"
  game.player.hand.each do |e|
    print "#{e.name_j} #{e.dice[0]}, "
  end
  print game.calc_research.to_s+"\n"
  print game.player.trash.size.to_s + "\n"
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
  when "s"
    show_tech_list(game)
  when "e"
    exit
  end

  game.click(buf.to_i)

end
