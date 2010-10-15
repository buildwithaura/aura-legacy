# Okay, not exactly a route. Move this please
class Aura
  module ErrorPages
    extend self

    def db_error
      e = {}
      e[:heading]     = "Something's not right."
      e[:description] =
        "Aura has encountered a database error. " +
        "Try running <code>rake setup</code>, then " +
        "restart the application."

      aura_error(e)
    end

    def aura_error(err)
  %{
  <!DOCTYPE html>
  <style type="text/css">
      body { font: 10pt/1.5 arial, sans-serif; }
      body { background: #555; }
      #error { margin: 80px auto; width: 400px; background: white; padding: 20px; }
      #error { text-align: center; }
      h1 { font-size: 1.5em; text-align: center; color: #7bd; line-height: 1.3; }
      h1, p { margin: 10px 0; }
      code { background: #eee; white-space: no-wrap; padding: 1px 3px; border: solid 1px #ddd; }
  </style>
  <body>
    <div id='error'>
      <h1>#{err[:heading]}</h1>
      <p>#{err[:description]}</p>
    </div>
  }
    end
  end
end
