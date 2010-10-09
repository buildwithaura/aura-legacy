class Main
  helpers do
    def admin_watermark
      return  if current_user.nil?
      partial 'watermark/watermark'
    end
  end
end
