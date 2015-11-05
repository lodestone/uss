module USS
  class UniqueSearcher

    DEFAULT_UNIQUE_LENGTH  = 4
    DEFAULT_UNIQUE_OUTFILE = "uniques.txt"
    DEFAULT_STEMS_OUTFILE  = "stems.txt"

    attr_reader :uniques, :stems

    def initialize(corpus:, length:, uniques_outfile:, stems_outfile:)
      raise StringSearchError, "corpus is required!" unless corpus
      corpus = standardize_input(corpus)
      length          ||= DEFAULT_UNIQUE_LENGTH
      uniques_outfile ||= DEFAULT_UNIQUE_OUTFILE
      stems_outfile   ||= DEFAULT_STEMS_OUTFILE
      @stems, @uniques = parse(corpus, length)
      write_output_files(stems, uniques, stems_outfile, uniques_outfile)
    end

    def standardize_input(input)
      input = File.exists?(input.to_s) ? File.open(input).read : input
      raise StringSearchError, "\n☐☐☐☐⫸ Whoa! input must contain lots of words, each on a single line, silly!!!" unless input[/\n/]
      input
    end

    def parse(word_string, length)
      stems   = []
      uniques = []
      word_scanner = StringScanner.new(word_string)
      word_string.split("\n").each do |word|
        (0..word.length-1).each do |i|
          match = word[i..i+length-1]
          alpha = match[Regexp.compile("[A-z]{#{length},#{length}}")]
          next if match.length < length
          next if !alpha
          word_scanner.reset
          regexp = Regexp.compile(match)
          word_scanner.scan_until(regexp)
          if !word_scanner.scan_until(regexp)
            stems   << word
            uniques << match
          end
        end
      end
      [stems, uniques]
    end

    def write_output_files(stems, uniques, stems_outfile, uniques_outfile)
      File.open(stems_outfile, 'w+') << stems.join("\n")
      File.open(uniques_outfile, 'w+') << uniques.join("\n")
    end

  end

end
