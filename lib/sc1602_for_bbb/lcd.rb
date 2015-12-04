require 'beaglebone'

module SC1602ForBBB
  class LCD
    include Beaglebone

    def initialize(pins)
      @lcd_rs = GPIOPin.new(pins[:RS], :OUT)
      @lcd_en = GPIOPin.new(pins[:EN], :OUT)
      @lcd_d4 = GPIOPin.new(pins[:D4], :OUT)
      @lcd_d5 = GPIOPin.new(pins[:D5], :OUT)
      @lcd_d6 = GPIOPin.new(pins[:D6], :OUT)
      @lcd_d7 = GPIOPin.new(pins[:D7], :OUT)

      initialize_lcd
    end

    def write(str)
      str.chars do |c|
        if c == "\n"
          set_cursor(1, 0)
        else
          lcd_out4(:HIGH, c.ord)
        end
      end
    end

    def clear
      lcd_out4(:LOW, 0x01)
    end

    def set_cursor(line, x)
      fail "Display line index out of range - #{line}" unless (0..1).include?(line)
      fail "String index out of range - #{x}" unless (0..15).include?(x)
      lcd_out4(:LOW, 0x80 + 0x40 * line + x)
    end

    private

    def initialize_lcd
      lcd_out8(0x03)
      lcd_out8(0x03)
      lcd_out8(0x03)
      lcd_out8(0x02)

      lcd_out4(:LOW, 0x28)
      lcd_out4(:LOW, 0x0C)
      lcd_out4(:LOW, 0x06)

      lcd_out4(:LOW, 0x01)
      lcd_out4(:LOW, 0x02)
    end

    def lcd_out8(data)
      @lcd_rs.digital_write(:LOW)
      @lcd_en.digital_write(:HIGH)

      @lcd_d4.digital_write((data & 0x01) == 1 ? :HIGH : :LOW )
      data = data >> 1
      @lcd_d5.digital_write((data & 0x01) == 1 ? :HIGH : :LOW )
      data = data >> 1
      @lcd_d6.digital_write((data & 0x01) == 1 ? :HIGH : :LOW )
      data = data >> 1
      @lcd_d7.digital_write((data & 0x01) == 1 ? :HIGH : :LOW )

      sleep ns_to_s(83)
      @lcd_en.digital_write(:LOW)
      sleep 0.004
    end

    def lcd_out4(rs, data)
      @lcd_rs.digital_write(rs)
      @lcd_en.digital_write(:HIGH)

      bk = data

      bk = bk >> 4
      @lcd_d4.digital_write((bk & 0x01) == 1 ? :HIGH : :LOW )
      bk = bk >> 1
      @lcd_d5.digital_write((bk & 0x01) == 1 ? :HIGH : :LOW )
      bk = bk >> 1
      @lcd_d6.digital_write((bk & 0x01) == 1 ? :HIGH : :LOW )
      bk = bk >> 1
      @lcd_d7.digital_write((bk & 0x01) == 1 ? :HIGH : :LOW )

      sleep ns_to_s(83)
      @lcd_en.digital_write(:LOW)
      sleep ns_to_s(83)
      @lcd_en.digital_write(:HIGH)

      @lcd_d4.digital_write((data & 0x01) == 1 ? :HIGH : :LOW )
      data = data >> 1
      @lcd_d5.digital_write((data & 0x01) == 1 ? :HIGH : :LOW )
      data = data >> 1
      @lcd_d6.digital_write((data & 0x01) == 1 ? :HIGH : :LOW )
      data = data >> 1
      @lcd_d7.digital_write((data & 0x01) == 1 ? :HIGH : :LOW )

      sleep ns_to_s(83)
      @lcd_en.digital_write(:LOW)
      @lcd_rs.digital_write(:LOW)
      sleep 0.004
    end

    def ns_to_s(ns)
      ns / (1000.0 * 1000.0 * 1000.0)
    end
  end
end
