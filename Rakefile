Dir['{app,core/*,extensions/*}/tasks/**/*.rake'].each { |rb| load rb }

task :default do
  exec 'rake -s -T'
end

task :test do
  $:.unshift File.join(File.dirname(__FILE__), 'app','test')

  Dir['{app,core/*,extensions/*}/test/**/*_test.rb'].each do |file|
    load file unless file =~ /^-/
  end
end
