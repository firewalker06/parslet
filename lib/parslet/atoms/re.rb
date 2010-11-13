# Matches a special kind of regular expression that only ever matches one
# character at a time. Useful members of this family are: character ranges, 
# \w, \d, \r, \n, ...
#
# Example: 
#
#   match('[a-z]')  # matches a-z
#   match('\s')     # like regexps: matches space characters
#
class Parslet::Atoms::Re < Parslet::Atoms::Base
  attr_reader :match
  def initialize(match)
    @match = match
  end

  def try(io)
    r = Regexp.new(match, Regexp::MULTILINE)
    s = io.read(1)
    error(io, "Premature end of input") unless s
    error(io, "Failed to match #{match.inspect[1..-2]}") unless s.match(r)
    return s
  end

  def to_s_inner(prec)
    match.inspect[1..-2]
  end
end

