module Cuukie
  module CodeSnippets
    def code_snippet(file, line)
      return null_snippet unless File.exist? file

      all_lines = File.open(file) {|f| f.readlines}
      return null_snippet unless line <= all_lines.size

      first_line = [1, line - 2].max
      
      { :raw_lines   => all_lines[(first_line - 1)..line].join,
        :first_line  => first_line,
        :marked_line => line }
    end

    def backtrace_to_snippet(backtrace)
      return null_snippet unless backtrace[0] =~ /(.*):(\d+)/
      code_snippet $1, $2.to_i
    end
    
    private
    
    def null_snippet; Hash.new; end
  end
end
