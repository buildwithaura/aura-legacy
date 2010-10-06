class Object
  def try(meth, *a)
    send(meth, *a)  if respond_to?(meth)
  end
end
