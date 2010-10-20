class UserAgent
  UA_REGEXP = %r{([^ /]+)/([^ ]+)(?: \(([^)]+)\))?}

  def initialize(ua)
    @ua_string = ua
    @ua = ua.scan(UA_REGEXP).map { |r|
      r[2] = r[2].split(';')  unless r[2].nil?
      { :product => r[0], :version => r[1], :details => r[2] }
    }
  end

  # Browsers
  def webkit?()    product?('AppleWebKit'); end
  def chrome?()    product?('Chrome'); end
  def safari?()    product?('Safari'); end
  def ios?()       product?('Safari') && product?('Mobile'); end
  def gecko?()     product?('Gecko'); end
  def opera?()     product?('Opera'); end
  def ie?()        detail?(/^MSIE/, 'Mozilla'); end

  # OS's and devices
  def linux?()     detail?(/^Linux/, 'Mozilla'); end
  def iphone?()    detail?(/^iPhone/, 'Mozilla'); end
  def ipad?()      detail?(/^iPad/, 'Mozilla'); end
  def windows?()   detail?(/^Windows/, 'Mozilla'); end
  def osx?()       detail?(/^(Intel )?Mac OS X/, 'Mozilla'); end
  def mac?()       detail?(/^Macintosh/, 'Mozilla') || osx?; end

  # IE
  def ie9?()       detail?('MSIE 9.0', 'Mozilla'); end
  def ie8?()       detail?('MSIE 8.0', 'Mozilla'); end
  def ie7?()       detail?(/^MSIE 7.0/, 'Mozilla'); end
  def ie6?()       detail?(/^MSIE 6/, 'Mozilla'); end

  def to_s()       @ua_string; end
  def inspect()    @ua.inspect; end

  # Checks for, say, 'Gecko' in 'Gecko/3.9.82'
  def product?(str)
    !! @ua.detect { |p| p[:product] == str }
  end

  # Checks for, say, 'MSIE' in 'Mozilla/5.0 (MSIE; x; x)'
  def detail?(detail, prod=nil)
    !! @ua.detect { |p|
      prod.nil? || prod == p[:product] && has_spec(p[:details], detail)
    }
  end

  def body_class
    (%w(webkit chrome safari ios gecko opera ie linux iphone) +
     %w(ipad windows osx mac ie6 ie7 ie8 ie9)).map do |aspect|
      aspect  if self.send :"#{aspect}?"
    end.compact.join(' ')
  end

protected
  def has_spec(haystack, spec)
    !haystack.nil? && haystack.detect { |d| d.match(spec) }
  end
end

module Sinatra
  module UserAgentHelpers
    def browser
      UserAgent.new(env['HTTP_USER_AGENT'])
    end
  end
end

# Usage example:
#
#   Main.register Sinatra::UserAgentHelpers
#
#   -# haml
#   %body{class: browser.body_class}
#
#   - if browser.ios?
#     %p Download our mobile app!
#
# Output:
#
#   <body class='webkit safari mac'>
#   <body class='windows ie ie6'>
