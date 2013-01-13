class Enemy < Sprite3D
attr_accessor  :x, :y, :z, :player
  def initialize(p_window, position = [0, 0, 0])
    super(p_window, "media/enemy.png", position)
    @counter = 0
    @pp = p_window
    @position = position
    @x = position[0]
    @y = position[1]
    @z = position[2]
  end



 def think(chara)
  n = Node.new(@x, @z)
  n.evaluate_step(self, 5)
  self.evaluateNode(@x, @z, self.player.x, self.player.z)
  puts "#{self.z}, #{n.node.y}"
  if self.z != n.node.y
    if self.z < n.node.y
      self.move(:down)
    elsif self.z > n.node.y
      self.move(:up)
    end  
  elsif self.x != n.node.x
    if self.x < n.node.x
      self.move(:right)
    else
      self.move(:left)
    end 
  end  
 end 

  def evaluateNode(x, y, x1, y1)
    px = self.player.x
    py = self.player.z
    dx = x - px
    dy = y - py
    wert = 0
    a1 = Math.sqrt(dx * dx + dy * dy)

    dx = x1 - px
    dy = y1 - py
    a2 = Math.sqrt(dx * dx + dy * dy)


    if a1 > a2 
      wert = 10
    elsif a1 < a2
      wert = 9
    end
    return wert     
  end 

  def move(p)
  	move_speed = 0.0625
  	case p
	  when :right	
		@x += move_speed
	  when :left
		@x -= move_speed
	  when :down
		@z += move_speed
      when :up
		@z -= move_speed
	end

  end	


end