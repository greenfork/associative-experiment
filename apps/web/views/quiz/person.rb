module Web::Views::Quiz
  class Person
    include Web::View

    def js_person
      javascript 'person'
    end

    def title
      t ".title"
      self.class
    end

    def display_alert(flag)
      alert = t ".alert"
      labl = t ".#{flag}"
      html.div(class: 'alert alert-danger hidden', id: "person-#{flag}-alert") { alert << ' ' << labl }
    end

    def language_select(options = {})
      output = "<select"
      options.each do |k, v|
        output += " #{k}='#{v}'"
      end
      output += ">"
      languages = t "languages" # I18n
      output += "<option disabled='disabled' selected='selected' value='--'>--</option>"
      languages.each_with_index do |language, index|
        if index != 5
          output += "<option value='#{language}'>#{language}</option>"
        else
          output += "<option disabled='disabled' value='--'>---</option>"
        end
      end
      output += "</select>"
      raw output
    end

    def first_disabled_select(enu, options = {})
      output = "<select"
      options.each do |k, v|
        output += " #{k}='#{v}'"
      end
      output += ">"
      output += "<option disabled='disabled' selected='selected' value='--'>--</option>"
      if enu.is_a?(Array) || enu.is_a?(Range)
        enu.each do |e|
          output += "<option value='#{e}'>#{e}</option>"
        end
      elsif enu.is_a? Hash
        enu.each do |k, v|
          output += "<option value='#{v}'>#{k}</option>"
        end
      end
      output += "</select>"
      raw output
    end
  end
end
