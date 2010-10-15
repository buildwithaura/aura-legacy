class RakeStatus
  def self.heading(what, status)
    color = 33
    if what == :run
      color = 30
      puts ""
      puts "\033[1;#{color}m$ %s \033[0m" % [status]
      return
    end
    puts "\033[1;#{color}m* %s\033[0m" % [status]
  end

  def self.print(what, status)
    color = 32
    color = 31  if what == :error
    what = ""  if what == :info
    puts "\033[1;#{color}m  %-14s\033[0m %s" % [what, status]
  end
end

def syst(cmd)
  RakeStatus.heading :run, cmd
  system cmd
end

