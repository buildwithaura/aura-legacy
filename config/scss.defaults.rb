class Main
  set :scss, { :load_paths => [ root_path, root_path('core'), root_path('extensions'), root_path('app/views/css'), root_path('vendor/compass_framework') ] }
  set :scss, self.scss.merge(:line_numbers => true, :debug_info => true, :always_check => true) if self.development?
  set :scss, self.scss.merge(:style => :compressed) if self.production?
end
