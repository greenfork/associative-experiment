require 'i18n'

I18n.load_path += Dir[Hanami.root.join("config/locales/**/*.yml")]
I18n.available_locales = [:en, :ru]
I18n.enforce_available_locales = true
I18n.default_locale = :ru
I18n.backend.load_translations
