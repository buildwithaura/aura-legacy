class Main
  helpers do
    def body_class(v = nil)
      @body_classes ||= []
      @body_classes << v  if v

      @body_classes.join(' ')
    end

    def title(title = nil, base = '')
      @page_title = title  if title
      [@page_title, base].compact.map { |s| s }.join(' &mdash; ')
    end

    def has_content?(key)
      content_blocks[key.to_sym].any?
    end
  end
end
