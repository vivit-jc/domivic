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
    if n.class == Symbol
      click_menu(n)
      return
    end
    case @game_status
    when :select_hand
      @research = calc_research
      @game_status = :select_tech if n == 20
    when :select_tech
      get_tech(n)
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

  def calc_research
    research = 0
    @player.hand.each do |card|
      case card.name
      when :research
        research += card.research
        all_cities.each do |city|
          card.dice.each do |d|
            research += 1 if city == d
          end
        end
      end
    end
    return research
  end

  def get_tech(n)
    return if @tech_data.size <= n
    @player.add_cards_to_trash(@tech_data[n].cards)
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