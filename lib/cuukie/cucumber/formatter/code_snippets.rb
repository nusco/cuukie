module Cuukie
  module CodeSnippets
    def code_snippet(file, line)
      return nil unless File.exist? file

      all_lines = File.open(file) {|f| f.readlines}
      return nil unless line <= all_lines.size

      first_line = [1, line - 2].max

      {:first_line => first_line,
       :marked_line => line,
       :raw_lines => all_lines[(first_line - 1)..line].join }
    end

    def backtrace_to_snippet(backtrace)
      return nil unless backtrace[0] =~ /(.*):(\d+)/
      code_snippet $1, $2.to_i
    end
  end
end
