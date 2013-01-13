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
    self.read_file
  end

  def read_file
    map = ""
    x=0
    y=0
    
    File.open("res/map.txt", "r") do |file|
      file.each_line do |line|
        line=line.gsub(/\\n/, "")
        
        x = 0
        line.each_char do |c|
          

          
          if c == "1"
          	puts "1 founf x:#{x} y:#{y}"
          @w=Item.new
          @w.x = x 
          @w.y = y
          end
          x += 1
        end  
        y += 1
      end  

    end  
   
  end



 def think(chara)
  n = Node.new(@x, @z)
  n.evaluate_step(self, 1)
  self.evaluateNode(@x, @z, self.player.x, self.player.z)
 # puts "#{@w.x}, #{@w.y}"
  if self.z != n.node.y
    if self.z < n.node.y
      self.move(:down) if self.check
    elsif self.z > n.node.y
      self.move(:up) if self.check
    end  
  elsif self.x != n.node.x
    if self.x < n.node.x
      self.move(:right) if self.check
    else
      self.move(:left) if self.check
    end 
  end  
 end 


 def check
 	if self.x != @w.x and self.z != @w.y
 		return true
 	else
 		return false
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