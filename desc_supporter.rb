# optparseのdescriptionのためのヘルパー
module DescSupporter
  module_function

  def gen_desc(desc, blank)
    terminal_width = `tput cols`.to_i
    strwidth_liner(desc, terminal_width - blank, 1).map.with_index { |line, index| index == 0 ? line + "\n" : ' ' * blank + line + "\n" }.inject(&:+)
  end

  def strwidth_liner(text, width, indent = 0)
    ret = []
    cur_width = indent
    line = ''
    text.chars.each do |w|
      cur_width += w.ascii_only? ? 1 : 2
      unless (0..width).cover?(cur_width)
        lastblank = line.rindex(' ')
        tmp = ''
        if !lastblank.nil?
          # 直前のblankまでさかのぼってもwidthを超える場合がある。
          # width以下になるまでさかのぼる。
          loop do
            tmp += line.slice(lastblank + 1, line.size - lastblank)
            line = line.slice(0, lastblank)
            break if line.size <= width || line.rindex(' ').nil?

            lastblank = line.rindex(' ')
          end
          ret << line
          line = tmp + w
        else
          ret << line
          line = w
        end
        cur_width = tmp.size + tmp.chars.reject(&:ascii_only?).size
        cur_width += w.ascii_only? ? 1 : 2
        next
      end
      if w == "\n"
        ret << line
        line = ''
        cur_width = indent + (w.ascii_only? ? 1 : 2)
        next
      end
      line += w
    end
    ret << line
    ret
  end
end
