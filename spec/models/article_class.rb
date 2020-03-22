class Article
  attr_reader(:title, :description, :url, :image)
  def initialize(title, description, url, image)
    @title = title
    @description = description
    @url = url
    @image = image
  end
end
