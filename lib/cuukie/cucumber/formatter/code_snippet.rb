s = "abc \
def"
module Cuukie
  class CodeSnippet
    attr_reader :marked_line, :first_line, :lines
    
    def initialize(file, line)
      @file = file
      @marked_line = line

      if File.exist? @file
        all_lines = File.open(@file) {|f| f.readlines}
        if all_lines.size >= @marked_line
          @first_line = [1, @marked_line - 2].max
          selected_lines = all_lines[(@first_line - 1)..@marked_line]
          while selected_lines.first == "\n"
            selected_lines.delete_at(0)
            @first_line += 1
          end
          @lines = selected_lines.join
        end
      end
    end
  end
end
