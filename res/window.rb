class Window < Gosu::Window
  attr_accessor :map, :chara, :soldiers, :message
  def initialize
    super(640, 480, false)
    self.caption = "PacRuby 3d"
    @map = Map.new(self, "res/map.txt")
    @chara = Sprite3D.new(self, "media/troll.png", [0, 0, 15])
    @enemy = Array.new
    #@enemy << Enemy.new(self, [0, 0, 0] )
    #@enemy << Enemy.new(self, [0, 0, 17] )
    @e = Enemy.new(self, [0,0,13])
    @e.player = @chara
    @font = Gosu::Font.new(self, Gosu::default_font_name, 32)
    @message = "x: ,y:"
  end
  
  def button_down(id)
    exit if id == Gosu::KbEscape
  end
  
  def draw
    gl do
      glEnable(GL_TEXTURE_2D)
      glEnable(GL_DEPTH_TEST)
      glClearColor(0.1, 0.1, 0.1, 0.0)
      glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
      glMatrixMode(GL_PROJECTION)
      glPushMatrix
      glLoadIdentity
      gluPerspective(45, self.width.to_f / self.height.to_f, 0.1, 1000.0)
      
      glMatrixMode(GL_MODELVIEW)
      glPushMatrix
      glLoadIdentity
      gluLookAt(@chara.x + 0.5, 3.0, @chara.z + 6.0, @chara.x + 0.5, 1.0, @chara.z - 0.5, 0, 1, 0)
      @map.draw3D
      @enemy.each do |enemy| 
      enemy.draw
      end
      @chara.draw
      @e.draw
      glMatrixMode(GL_PROJECTION)
      glPopMatrix
      glMatrixMode(GL_MODELVIEW)
      glPopMatrix
    end
    
  
    @font.draw(@message, 0, 0, 0)
  end
  
  def update

    if button_down?(Gosu::KbRight)
      @chara.move(:right)
    elsif button_down?(Gosu::KbLeft)
      @chara.move(:left)
    elsif button_down?(Gosu::KbDown)
      @chara.move(:down)  
    elsif button_down?(Gosu::KbUp)
      @chara.move(:up)    
    end

    @chara.update
    @e.think(@chara)
    @enemy.each do |enemy|
      enemy.update 
    end  

  end
end