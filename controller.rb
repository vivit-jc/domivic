class Controller
  attr_reader :x,:y,:mx,:my

  def initialize(game)
    @game = game
  end

  def input
    @mx = Input.mousePosX
    @my = Input.mousePosY
    if Input.mouse_push?( M_LBUTTON )
      case @game.status
      when :title
        @game.start if(pos_menu == 0)
        @game.rank_start if(pos_menu == 1)
        exit if(pos_menu == 2)
      when :game
        click_on_game
      when :ranking
        @game.go_title if(pos_return)
      when :end
        @game.next if(pos_return)
      end
    end
    if(Input.key_push?(K_SPACE))
      case @game.status
      when :game
        @game.toggle_pause
      end
    end
    if(Input.key_push?(K_ESCAPE))
      exit
    end
  end

  def click_on_game
    case @game.game_status
    when :select_hand
      return false if pos_hand < 0
      @game.click(pos_hand)
    when :select_tech
      click_on_select_tech
    when :select_remove_hand
      return false if pos_hand < 0 || pos_hand_pass?
      @game.click(pos_hand)
    when :view_tech_list
      @game.click_scroll(pos_tech_scroll) if pos_tech_scroll != -1
    end
  end

  def click_on_select_tech
    if pos_tech_scroll != -1
      @game.click_scroll(pos_tech_scroll)
    elsif pos_tech_pass?
      @game.click(100)
    elsif pos_tech < 0
    else
      @game.click(pos_tech)
    end
  end

  def pos_menu
    3.times do |i|
      return i if(mcheck(MENU_X, MENU_Y[i], MENU_X+Font32.get_width(MENU_TEXT[i]), MENU_Y[i]+32))
    end
    return -1
  end

  def pos_hand
    @game.player.hand.size.times do |i|
      return i if(mcheck(HAND_X+(CARD_W+4)*i,HAND_Y,HAND_X+CARD_W+(CARD_W+4)*i,HAND_Y+CARD_H))
    end
    return 20 if pos_hand_pass?
    return -1
  end

  def pos_hand_pass?
    return mcheck(HAND_X,HAND_Y-44,HAND_X+CARD_W,HAND_Y-4)
  end

  def pos_tech
    5.times do |i|
      return i if mcheck(TECH_X+i*(TECH_W+6), TECH_Y, TECH_X+TECH_W+i*(TECH_W+6), TECH_Y+TECH_H)
    end
    5.times do |i|
      return i+5 if mcheck(TECH_X+i*(TECH_W+6), TECH_Y+TECH_H+5, TECH_X+TECH_W+i*(TECH_W+6), TECH_Y+TECH_H*2+5)
    end
    return -1
  end

  def pos_tech_scroll
    return 0 if mcheck(35,240,51,256)
    return 1 if mcheck(605,240,621,256)
    return -1
  end

  def pos_tech_pass?
    mcheck(TECH_X+(TECH_W+3)*2,TECH_Y+(TECH_H+6)*2,TECH_X+(TECH_W)*3+6,TECH_Y+(TECH_H+6)*2+30)
  end

  def pos_return
    mcheck(250,400,250+Font20.get_width("戻る"),420)
  end

  def mcheck(x1,y1,x2,y2)
    x1 < @mx && x2 > @mx && y1 < @my && y2 > @my
  end
end