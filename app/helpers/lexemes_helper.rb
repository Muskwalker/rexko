# encoding: utf-8

module LexemesHelper
  # Do wikibold around a string, except around the | character, unless it's the |
  # that does pipe-linking.  This approach thanks to Ben Marini's suggestion at
  # http://refactormycode.com/codes/977-ugly-split-join
  def bold_around_pipes (str)
    stack, functional = 0, false
    "'''#{str}'''".each_char.inject('') do |memo, char|
      case char
      when '[' then stack, functional = stack + 1, true
      when ']' then stack, functional = stack - 1, !stack.zero?
      when '|' then stack.zero? || !functional ? char = "'''|'''" : functional = false
      end
      memo + char
    end
  end
  
  def wiki_title_for(lexeme, headword)
    dict = lexeme.dictionaries.first
    homographs = dict.try(:homographs_of, headword.form)
    count = homographs.try(:size) || 1
    index = homographs.try(:index, lexeme) || 0
    sortkey = headword.form.capitalize.delete " " # This will eventually want language- or dictionary-sensitive rules
    
    "{{%s|%s}}%s" % [
      dict.try(:title),
      sortkey,
      (" #{roman_numeral(index.next)}." unless count == 1)
    ]
  end
  
  def roman_numeral(int)
    "%s%s%s%s" % [
      ['', 'M', 'MM', 'MMM', 'Mↁ', 'ↁ', 'ↁM', 'ↁMM', 'ↁMMM', 'Mↂ'][int / 1000 % 10],
      ['', 'C', 'CC', 'CCC', 'CD', 'D', 'DC', 'DCC', 'DCCC', 'CM'][int / 100 % 10],
      ['', 'X', 'XX', 'XXX', 'XL', 'L', 'LX', 'LXX', 'LXXX', 'XC'][int / 10 % 10],
      ['', 'I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX'][int % 10]
    ]
  end

  def titleize_headwords_for lexeme    
    headwords = lexeme.headword_forms.inject([]) do |memo, form|
      swapform = form.dup
      swapform[0,1] = swapform[0,1].swapcase
      
      memo.include?(swapform) ? memo : memo << form
    end
    
    html_escape sentence_case(headwords.to_sentence(:two_words_connector  => ' or ', :last_word_connector => ", or "))
  end
end