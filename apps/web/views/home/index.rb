module Web::Views::Home
  class Index
    include Web::View

    def title
      t ".title"
    end
  end
end
