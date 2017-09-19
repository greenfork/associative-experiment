module Web
  module Views
    class ApplicationLayout
      include Web::Layout

      def title
        t 'default.title'
      end
    end
  end
end
