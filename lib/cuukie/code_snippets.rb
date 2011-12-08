module Cuukie
  module CodeSnippets
    NULL_SNIPPET = Hash.new
    
    def code_snippet(file, line)
      return NULL_SNIPPET unless File.exist? file

      all_lines = File.open(file) {|f| f.readlines}
      return NULL_SNIPPET unless line <= all_lines.size

      first_line = [1, line - 2].max
      
      { :raw_lines   => all_lines[(first_line - 1)..line].join,
        :first_line  => first_line,
        :marked_line => line }
    end

    def backtrace_to_snippet(backtrace)
      return NULL_SNIPPET unless backtrace[0] =~ /(.*):(\d+)/
      code_snippet $1, $2.to_i
    end
  end
end
