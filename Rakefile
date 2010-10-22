Dir['{app,core/*,extensions/*}/tasks/**/*.rake'].each { |rb| load rb }

task :default do
  exec 'rake -s -T'
end
