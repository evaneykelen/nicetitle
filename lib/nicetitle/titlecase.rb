module Nicetitle
  class Titlecase
    SMALL_WORDS = Regexp.new('\b(a(nd|n|s|t)?|b(ut|y)|en|for|i(f|n)|o(f|n|r)|t(he|o)|vs?\.?)\b').freeze

    def self.is_small_word?(word)
      SMALL_WORDS.match(word)
    end

    # "__foo" => "__Foo"
    def self.upcase_first_real_letter(word)
      word.sub(/[a-zA-Z0-9]/, &:upcase)
    end

    # step-by-step => Step-by-Step
    def self.upcase_word_with_dashes(word)
      word.split('-').map { |part| is_small_word?(part) ? part : part.capitalize }.join("-")
    end

    # before/after => Before/After
    def self.upcase_word_with_slashes(word)
      word.split('/').map(&:capitalize).join('/')
    end

    def self.titlecase(str)
      # Replace tabs by single space
      # Replace weird spaces by regular space
      str = (str || '').gsub(/\t/, ' ').gsub("\u{2011}", ' ').strip
      return '' if str.empty?

      # Downcase an all-upcase sentence
      str.downcase! if str.scan(/[A-Z]|\s|\W/).length == str.length

      # Split sentence at space boundaries
      word_arr = str.split(' ')

      # Initialize operand array
      operand_arr = Array.new(word_arr.size, :capitalize)

      word_arr.each_with_index do |word, idx|
        # Don't capitalize small words...
        # ... unless it's first word
        # ... unless it's last word
        # ... unless word is preceded by word ending with colon
        operand_arr[idx] = :do_not_upcase  if idx != 0 && idx != word_arr.size - 1 && is_small_word?(word) && word_arr[idx - 1][-1] != ':'
        # Don't simply capitalize first letter if word starts with (, _, ', or "
        operand_arr[idx] = :upcase_later   if word[0].match(/\(|_|'|"/)
        # Capitalize first letter and letters preceded by -
        operand_arr[idx] = :upcase_dashed  if word.count('-') > 0
        # Capitalize letters preceded by / inside word
        operand_arr[idx] = :upcase_slashed if word[1..].count('/') > 0
        # Don't capitalize word if it starts with /
        operand_arr[idx] = :do_not_upcase  if word[0] == '/'
        # Don't capitalize URLs
        operand_arr[idx] = :do_not_upcase  if word.match(/https?:\/\//i)
        # Don't capitalize words containing capitals besides first letter
        # Don't capitalize words containing dots inside word
        operand_arr[idx] = :do_not_upcase  if word[1..].match(/[A-Z]/) || word[1..-3].match(/\.|&/)
      end

      word_arr.each_with_index do |word, idx|
        word_arr[idx] = upcase_first_real_letter(word) if operand_arr[idx] == :upcase_later
        word_arr[idx] = upcase_word_with_dashes(word)  if operand_arr[idx] == :upcase_dashed
        word_arr[idx] = upcase_word_with_slashes(word) if operand_arr[idx] == :upcase_slashed
        word_arr[idx] = word.capitalize                if operand_arr[idx] == :capitalize
      end

      word_arr.join(' ')
    end
  end
end
