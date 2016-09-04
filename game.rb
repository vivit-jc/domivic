class Game

require './player'
require './card'
require './tech'
require 'yaml'

attr_accessor :status
attr_reader :game_status, :game_status_memo, :player, :countries, :tech_data, :page

  def initialize
    @status = :title
    @game_status = :view_tech_list
    @game_status_memo = nil
    @countries = [Player.new("ドイツ"), Player.new("アメリカ"), Player.new("日本"), Player.new("エジプト")]
    @player = @countries[0]
    @ranking = load_ranking
    @tech_data = YAML.load(File.open('./tech.yml'))
    @tech_data.each{|t|t.init}
    @page = 0
  end

  def start
    @status = :game
  end

  def click(n)
    case @game_status
    when :select_hand
      calc_sci_and_cul
    when :select_tech
    when :view_tech_list

    end
  end

  def click_scroll(d)
    @page -= 1 if d == 0
    @page += 1 if d == 1
  end

  def calc_sci_and_cul
    sci = 0
    cul = 0
    @player.hand.each do |card|
      case card.name
      when :science
        sci += card.val
        all_cities.each do |city|
          sci += 1 if city == card.dice
        end
      when :cul
      end
    end
    p sci,cul
  end

  def all_cities
    return @countries.map{|c|c.cities}.flatten
  end

  def go_title
    @status = :title
  end

  def rank_start
    @status = :ranking
  end

  def load_ranking
    File.open("rank.dat","w"){} unless(File.exist?("rank.dat"))
    array = []
    open("rank.dat") do |f|
      while l = f.gets
        array.push l.to_f
      end
    end
    array
  end

  def save_ranking
    File.open("rank.dat","w") do |f|
      @ranking.each{|r| f.write(r.to_s+"\n")}
    end
  end

  def ending
    score = @pizza.score[3]
    @ranking.push score
    del = @ranking.sort.reverse.pop if(@ranking.size > 5)
    @new_rank = true if(del != score)
    @score = @pizza.score
    @ranking = @ranking.sort!.reverse![0..4]
    save_ranking
  end

end