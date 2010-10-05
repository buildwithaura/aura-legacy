class Monk::Glue::Reloader
  def files
    f = Dir[root_path("{app,lib,extensions}", "**", "*")]
    f+= [@app_class.app_file]
    f
  end
end
