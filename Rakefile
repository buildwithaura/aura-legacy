Dir['{app,core/*,extensions/*}/tasks/**/*.rake'].each { |rb| load rb }

task :default do
  exec 'rake -s -T'
end

desc "Runs tests."
task :test do
  $:.unshift File.join(File.dirname(__FILE__), 'app','test')

  Dir['{app,core/*,extensions/*}/test/**/*_{test,story}.rb'].each do |file|
    next  if ENV['test'] and !file.match(ENV['test'])
    load file unless file =~ /^-/
  end
end
