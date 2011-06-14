task :deploy do
  system "cd .. && rake doc"
  system "git add ."
  system "git add -u"
  system "git commit -m ."
  system "git push"
end
