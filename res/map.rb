class Map
  def initialize(parent_window, filename)
    @parent_window = parent_window
    @graphics = {
      0 => Gosu::Image.new(@parent_window, "media/way.png", true),
      1 => Gosu::Image.new(@parent_window, "media/wall.png", true)
    }

    @map_height = 0
    @tiles = Hash.new
    File.open(filename).readlines.each do |line|
      line = line.chomp.split(",")
      if !defined?(@map_width)
        @map_width = line.size #it should 9
      end

      for x in 0...@map_width
        @tiles[[x, @map_height]] = line[x].to_i
      end
      @map_height += 1  
    end

  end

  def draw3D
    size = 1.0
    @y = 0.0
    @tiles.each do |coords, tile|
      texture = @graphics[tile].gl_tex_info
      @x = coords[0]
      @z = coords[1]
      glBindTexture(GL_TEXTURE_2D, texture.tex_name)
      glBegin(GL_QUADS)
        glTexCoord2f(texture.left, texture.top); glVertex3f(@x, @y, @z)
        glTexCoord2f(texture.right, texture.top); glVertex3f(@x + size, @y, @z)
        glTexCoord2f(texture.right, texture.bottom); glVertex3f(@x + size, @y, @z + size)
        glTexCoord2f(texture.left, texture.bottom); glVertex3f(@x, @y, @z + size)
      glEnd

    end
    
  end
  

end