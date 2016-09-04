class View

  def initialize(game,controller)
    @game = game
    @controller = controller
    @title = Image.load("chichen-itza.jpg")
    @science = Image.load("chemistry.png")
    @culture = Image.load("music.png")
    @miritary = Image.load("shield.png")
    @growing = Image.load("growing.png")
    @war = Image.load("war.png")
    @training = Image.load("training.png")
    @trading = Image.load("trading.png")
    @expand = Image.load("expand.png")
    @effect = Image.load("effect.png")
    @dice = [Image.load("dice_1.png"),Image.load("dice_2.png"),Image.load("dice_3.png"),
      Image.load("dice_4.png"),Image.load("dice_5.png"),Image.load("dice_6.png")]
    @player = game.player
    @countries = game.countries
  end

  def draw
    draw_xy
    case @game.status
    when :title
      draw_title
    when :game
      draw_game
    when :ranking
      draw_ranking
    end
  end

  def draw_title
    Window.draw(0,0,@title)
    Window.drawFont(70, 10, "DOMIVIC", Font120, {color: YELLOW})
    
    MENU_TEXT.each_with_index do |menu,i|
      fonthash = {color: YELLOW}
      fonthash = {color: GREEN} if(@controller.pos_menu == i)
      Window.drawFont(MENU_X,MENU_Y[i],menu,Font32,fonthash)
    end
  end

  def draw_game
    case @game.game_status
    when :select_hand
      draw_countries
      draw_hand
    when :select_tech
    when :view_tech_list
      draw_tech_list
    end

  end

  def draw_hand
    @player.hand.each_with_index do |card,i|
      p = calc_pos_hand(i)
      Window.drawBox(p[0],p[1],p[2],p[3],WHITE)
      Window.drawFont(p[0]+3,p[1]+3,card.name_j,Font16)
      Window.draw(p[0]+2,p[1]+23,eval("@"+card.icon.to_s))
      Window.draw(p[0]+2,p[1]+43,@dice[card.dice]) if card.dice
    end
    Window.drawBox(HAND_X,HAND_Y-30,HAND_X+CARD_W,HAND_Y-4,WHITE)
    Window.drawFont(HAND_X+10,HAND_Y-26,"パス",Font16)
  end

  def draw_countries
    4.times do |i|
      c = COUNTRIES[i]
      Window.drawBox(c[0], c[1], c[2], c[3], WHITE)
      Window.drawFont(c[0]+2, c[1]+2, @countries[i].name, Font16)
      @countries[i].cities.each do |city|
        Window.draw(c[0]+3, c[1]+22, @dice[city])
      end
    end
  end

  def draw_tech_list
    5.times do |i|
      break if @game.tech_data.size <= i+@game.page*10
      draw_tech(i+@game.page*10, TECH_X+(i*TECH_W+6), TECH_Y)
    end
    5.times do |i|
      break if @game.tech_data.size <= 5+i+@game.page*10

      draw_tech(5+i+@game.page*10, TECH_X+(i*TECH_W+6), TECH_Y+TECH_H+5)
    end
    
    fonthash = {}
    fonthash = {color: YELLOW} if(@controller.pos_tech_scroll == 0)
    Window.drawFont(35, 240, "←", Font16,fonthash) if @game.page > 0
    fonthash = {}
    fonthash = {color: YELLOW} if(@controller.pos_tech_scroll == 1)
    Window.drawFont(605, 240, "→", Font16,fonthash) if @game.page < @game.tech_data.size/10
  end

  def draw_tech(n,x,y)
    tech = @game.tech_data[n]
    Window.drawBox(x, y, x+TECH_W-6, y+TECH_H, WHITE)
    Window.drawFont(x+3, y+3, tech.name_j, Font16)
    Window.drawFont(x+76, y+3, tech.cost.to_s, Font16)
    Window.draw(x+61, y+3, @science)
    tech.cards.each_with_index do |card, i|
      Window.draw(x+i*17+3, y+22, eval("@"+card.icon.to_s))
    end
    tech.effects.size.times do |i|
      Window.draw(x+(i+tech.cards.size)*17+3, y+22, @effect)
    end
    draw_tech_info(@controller.pos_tech) if @controller.pos_tech != -1
  end

  def draw_tech_info(n)
    font16 = Font.new(16)
    return false if @game.tech_data.size <= n+@game.page*10
    tech = @game.tech_data[n+@game.page*10]
    Window.drawFont(20, 250, tech.name_j, font16)
    tech.cards.each_with_index do |card,i|
      Window.drawBox(20+i*(CARD_W+8), 280, 20+i*(CARD_W+8)+CARD_W, 280+CARD_H, WHITE)
      Window.drawFont(23+i*(CARD_W+8), 283, card.name_j, font16)
      Window.draw(23+i*(CARD_W+8), 300, eval("@#{card.icon.to_s}")) unless card.effect
      Window.drawFont(23+i*(CARD_W+8), 300, card.effect, font16) if card.effect
    end
    Window.drawFont(20, 400, tech.doc, font16) if tech.doc
  end

  def draw_ranking
    Window.drawFont(200,40,"RANKING",Font60)
    @game.ranking.each_with_index do |r,i|
      Window.drawFont(250,120+40*i,(i+1).to_s+". "+r.to_s,Font32)
    end
    fonthash = {}
    fonthash = {color: YELLOW} if(@controller.pos_return)
    Window.drawFont(250,400,"戻る",Font20,fonthash)
  end

  def draw_xy
    Window.drawFont(0,0,Input.mousePosX.to_s+" "+Input.mousePosY.to_s,Font16)
  end

  def calc_pos_hand(n)
    return [20+n*64,390,80+n*64,470]
  end

end