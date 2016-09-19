class Game

require './player'
require './card'
require './tech'
require './techreader'

attr_accessor :status
attr_reader :game_status, :game_status_memo, :player, :countries, :tech_data, :page

  def initialize
    @status = :title
    @game_status = :select_hand
    @game_status_memo = nil
    @menu_status = :view_main
    @countries = [Player.new("ドイツ"), Player.new("アメリカ"), Player.new("日本"), Player.new("エジプト")]
    set_opponents
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
    # 手札（アクション）を選ぶ
    when :select_hand
      select_hand(n)
    # 技術を選ぶ
    when :select_tech
      select_tech(n)
    when :select_remove_hand
      select_remove_hand(n)
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
  end

  def click_scroll(d)
    @page -= 1 if d == 0
    @page += 1 if d == 1
  end

  def call_action(n)
    @player.hand[n].get_action.call
    if @player.remove_count > 0
      @game_status = :select_remove_hand
    end
    @player.action -= 1
    @player.discard(n)
  end

  def select_tech(n)
    if @player.has_tech?(n)
      p "already had"
      return false
    elsif n == 100
      p "pass"
    elsif @tech_data.size <= n
      p "not found"
      return
    elsif @player.research < @tech_data[n].cost
      p "research point isn't enough"
      return false
    else
      @player.get_tech(n, @tech_data[n])
    end
    @game_status = :select_hand
    @player.end_turn
  end

  def select_hand(n)
    if n == 20
      p "pass"
      @player.action = 0
      @game_status = :select_tech
      @player.add_research(self.all_cities)
      @player.add_culture(self.all_cities)
    elsif n >= @player.hand.size
      p "non hand"
      return
    elsif !@player.hand[n].get_action
      p "non action"
      return
    elsif @player.action <= 0
      p "full action"
    else
      call_action(n)
    end
  end

  def select_remove_hand(n)
    @player.remove_count -= 1
    @player.remove(n)
    @game_status = :select_hand if @player.remove_count == 0
  end

  def all_cities
    return @countries.map{|c|c.cities}.flatten
  end

  def set_opponents
    @countries.each do |c|
      c.opponents = @countries - [c]
    end
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