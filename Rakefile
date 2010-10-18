Dir['{core,extensions}/*/tasks/**/*.rake'].each { |rb| load rb }

task :default do
  exec 'rake -s -T'
end

namespace :lol do
  task :default => [:a, :b]

  task :a do
    puts "A"
  end

  task :b do
    puts "B"
  end
end
