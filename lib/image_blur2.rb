class Image
  attr_accessor :image_data

  ON = 1
  OFF = 0

  def initialize(image_data)
    self.image_data = image_data
  end

  def output_image
    image_data.each do |pixel_row|
      pixel_row.each do |pixel_value|
        print pixel_value
      end
      print "\n"
    end
  end

  def blur
    distance = 1
    distance.times do
      blur_once
    end
  end

  private

  def width
    image_data[0].size
  end

  def height
    image_data.size
  end

  def location_of_on_pixels
    on_pixels = []
    # this gets the location of my 1's
    image_data.each_with_index do |row_elements, row_number|
      row_elements.each_with_index do |element, column_number|
        on_pixels << [row_number, column_number] if element == 1
      end
    end
    on_pixels
  end

  def left_edge?(column_number)
    column_number - 1 < 0
  end

  def blur_left(row_number, column_number)
    image_data[row_number][column_number - 1] = ON
  end

  def right_edge?(column_number)
    column_number == width - 1
  end

  def blur_right(row_number, column_number)
    image_data[row_number][column_number + 1] = ON
  end

  def top_edge?(row_number)
    row_number - 1 < 0
  end

  def blur_top(row_number, column_number)
    image_data[row_number - 1][column_number] = ON
  end

  def bottom_edge?(row_number)
    row_number == height - 1
  end

  def blur_bottom(row_number, column_number)
    image_data[row_number + 1][column_number] = ON
  end

  def blur_once
    location_of_on_pixels.each do |row_number, column_number|
      blur_left(row_number, column_number) unless left_edge?(column_number)
      blur_right(row_number, column_number) unless right_edge?(column_number)
      blur_top(row_number, column_number) unless top_edge?(row_number)
      blur_bottom(row_number, column_number) unless bottom_edge?(row_number)
    end
  end
end
