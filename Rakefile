Dir['{app,core/*,extensions/*}/tasks/**/*.rake'].each { |rb| load rb }

task :default do
  exec 'rake -s -T'
end

# Use 'monk test' for more options, like:
#
#   monk test -v
#   monk test migration
#
task :test do
  $:.unshift File.join(File.dirname(__FILE__), 'app','test')

  Dir['{app,core/*,extensions/*}/test/**/*_test.rb'].each do |file|
    next  if ENV['test'] and !file.match(ENV['test'])
    load file unless file =~ /^-/
  end
end

task :stories do
  $:.unshift File.join(File.dirname(__FILE__), 'app','test')

  Dir['{app,core/*,extensions/*}/test/**/*_stor{y,ies}.rb'].each do |file|
    next  if ENV['test'] and !file.match(ENV['test'])
    load file unless file =~ /^-/
  end
end
