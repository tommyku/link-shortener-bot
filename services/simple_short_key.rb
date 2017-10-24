require_relative './short_key'

class SimpleShortKey < ShortKey
  @vowel = ['a', 'e', 'i', 'o', 'u']
  @consonant = ['b', 'c', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'm', 'n', 'p', 'q', 'r', 's', 't', 'v', 'w', 'x', 'y', 'z']

  def self.get_key
    (1..4).reduce('') { |memo| memo + @consonant.sample + @vowel.sample }
  end
end
