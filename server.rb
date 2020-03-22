require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require 'csv'
require_relative "spec/models/article_class.rb"
set :bind, '0.0.0.0'

def get_articles
  articles = []

  CSV.foreach(csv_file, headers: true) do |row|
    articles.push(Article.new(row["title"], row["description"], row["url"], row["image"]))
  end

  return articles
end

def articles_to_json
  articles = []
  CSV.foreach(csv_file, headers: true) do |row|
    new_article = {
        title: row["title"],
        description: row["description"],
        url: row["url"],
        image: row["image"]
    }
    articles << new_article
  end
  articles_json = articles.to_json
  File.write("articles.json", articles_json)
end


get "/" do
    erb :index

end

get "/articles" do
    @articles = get_articles
    erb :articles
end

get "/articles/new" do
    erb :submit
end

get "/articles/random" do
  erb :random
end

post "/articles/new" do
  @articles = get_articles

  if (params["title"] != "" && params["description"] != "" && params["url"] != "" && params["image"])
    CSV.open(csv_file, 'a') do |csv|
      csv << [
          params["title"],
          params["description"],
          params["url"],
          params["image"]
      ]
    end
    redirect "/articles"
  else
    @error = "Error fill out all fields!"
    erb :submit
  end
end

def csv_file
    if ENV["RACK_ENV"] == "test"
      "articlestest.csv"
    else
      "articles.csv"
    end
  end

  def reset_csv
    CSV.open(csv_file, "w", headers: true) do |csv|
      csv << ["title", "description", "url", "image"]
    end
  end

get "/articles.json" do
  articles_to_json
  articles_json_data = File.read("articles.json")

  status(200)
  content_type(:json)
  articles_json_data
end
