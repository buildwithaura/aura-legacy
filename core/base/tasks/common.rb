class RakeStatus
  def self.print_heading(what, status)
    color = 33
    color = 35 if what == :run
    puts "\033[1;#{color}m* %s\033[0m" % [status]
  end

  def self.print(what, status)
    color = 32
    color = 31  if what == :error
    what = ""  if what == :info
    puts "\033[1;#{color}m%10s\033[0m  %s" % [what, status]
  end
end

def syst(cmd)
  RakeStatus.print_heading :run, cmd
  system cmd
end

