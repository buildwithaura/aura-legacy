class JsFiles
  attr_accessor :files

  def initialize(files, options={})
    @files, @options = files, options
    @options[:prefix] ||= '/js/'
  end

  def mtime
    @files.map { |f| File.mtime(f) }.max
  end

  def combined
    @combined ||= @files.map { |file| File.open(file) { |f| f.read } }.join("\n")
  end

  def compressed
    require 'jsmin'
    @compressed ||= JSMin.minify(combined).strip
  end

  def hrefs
    @files.map { |f| @options[:prefix] + File.basename(f) }
  end

  def to_html
    hrefs.map { |href| "<script type='text/javascript' src='#{href}'></script>" }.join("\n")
  end
end

