#!/usr/bin/env ruby

# From Sam Ruby: http://intertwingly.net/stories/2005/09/28/xchar.rb

module XChar
  # http://intertwingly.net/stories/2004/04/14/i18n.html#CleaningWindows
  CP1252 = {
    128 => 8364, # euro sign
    130 => 8218, # single low-9 quotation mark
    131 =>  402, # latin small letter f with hook
    132 => 8222, # double low-9 quotation mark
    133 => 8230, # horizontal ellipsis
    134 => 8224, # dagger
    135 => 8225, # double dagger
    136 =>  710, # modifier letter circumflex accent
    137 => 8240, # per mille sign
    138 =>  352, # latin capital letter s with caron
    139 => 8249, # single left-pointing angle quotation mark
    140 =>  338, # latin capital ligature oe
    142 =>  381, # latin capital letter z with caron
    145 => 8216, # left single quotation mark
    146 => 8217, # right single quotation mark
    147 => 8220, # left double quotation mark
    148 => 8221, # right double quotation mark
    149 => 8226, # bullet
    150 => 8211, # en dash
    151 => 8212, # em dash
    152 =>  732, # small tilde
    153 => 8482, # trade mark sign
    154 =>  353, # latin small letter s with caron
    155 => 8250, # single right-pointing angle quotation mark
    156 =>  339, # latin small ligature oe
    158 =>  382, # latin small letter z with caron
    159 =>  376} # latin capital letter y with diaeresis
  
  # http://www.w3.org/TR/REC-xml/#dt-chardata
  PREDEFINED = {
    38 => '&amp;', # ampersand
    60 => '&lt;',  # left angle bracket
    62 => '&gt;'}  # right angle bracket
  
  # http://www.w3.org/TR/REC-xml/#charsets
  VALID = [[0x9, 0xA, 0xD], (0x20..0xD7FF), 
    (0xE000..0xFFFD), (0x10000..0x10FFFF)]
end
  
class Fixnum
  # xml escaped version of chr
  def xchr
    n = XChar::CP1252[self] || self
    n = 42 unless XChar::VALID.find {|range| range.include? n}
    XChar::PREDEFINED[n] or (n<128 ? n.chr : "&##{n};")
  end
end

class String
  # xml escaped version of to_s
  def to_xs
    unpack('U*').map {|n| n.xchr}.join # ASCII, UTF-8
  rescue
    unpack('C*').map {|n| n.xchr}.join # ISO-8859-1, WIN-1252
  end
end
