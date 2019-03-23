module LocaleHelper
  def t(key, options = {})
    if key.to_s[0] == '.'
      app, _, controller, action = self.class.name.split('::').map(&:downcase)
      scope    = "#{app}.#{controller}"
      defaults = [:"#{scope}#{key}"]
      scope    << ".#{action}"
      defaults << :"#{scope}#{key}"
      defaults << options[:default] if options[:default]

      options[:default] = defaults
      key = "#{scope}#{key}"
    end

    ::I18n.t key, options
  end
end
