task :update do
  system "cd .. && yard"
end

task :deploy => [:update] do
  system "git add ."
  system "git add -u"
  system "git commit -m ."
  system "git push"
end
