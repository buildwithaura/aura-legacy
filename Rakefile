Dir['{core,extensions}/*/tasks/**/*.rake'].each { |rb| load rb }

namespace :db do
  task :migrate do
    exec `thor db:migrate`
  end
end
