class Game

require './player'
require './card'
require './tech'
require './techreader'
require 'yaml'

attr_accessor :status
attr_reader :game_status, :game_status_memo, :player, :countries, :tech_data, :page

  def initialize
    @status = :title
    @game_status = :select_hand
    @game_status_memo = nil
    @menu_status = :view_main
    @countries = [Player.new("ドイツ"), Player.new("アメリカ"), Player.new("日本"), Player.new("エジプト")]
    @player = @countries[0]
    @ranking = load_ranking
    techreader = TechReader.new
    techreader.instance_eval File.read 'techdata.rb'
    @tech_data = techreader.techarray
    @page = 0
  end

  def start
    @status = :game
  end

  def click(n)
    @research = @player.research(self)
    if n.class == Symbol
      click_menu(n)
      return
    end
    case @game_status
    when :select_hand
      @game_status = :select_tech if n == 20
    when :select_tech
      if @player.has_tech?(n) || @tech_data.size <= n
        p "already had"
        return false
      elsif @research < @tech_data[n].cost
        p "research point isn't enough"
        return false
      end
      @player.get_tech(n, @tech_data[n])
      @game_status = :select_hand
      @player.end_turn
    end
    p @game_status
  end

  def click_menu(s)
    case(s)
    when :view_tech_list
      @menu_status = :view_tech_list
    when :view_main
      @menu_status = :view_main
    end
    p @menu_status
  end

  def click_scroll(d)
    @page -= 1 if d == 0
    @page += 1 if d == 1
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