# frozen_string_literal: true

class NewsItem < ApplicationRecord
  belongs_to :representative
  has_many :ratings, dependent: :delete_all

  def self.find_for(representative_id)
    NewsItem.find_by(
      representative_id: representative_id
    )
  end

  def self.get_topheadlines(rep_id, issue, api_key)
    headlines ||= []

    rep_name = Representative.find(rep_id).name
    uri = "https://newsapi.org/v2/top-headlines?country=us&q=" + issue
          + "&q=" + rep_name + "&apiKey=" + api_key
    uri_string = URI.parse(uri)
    response = JSON.parse(Faraday.get(uri_string).body)
    articles = response["articles"]

    x = 0
    while x < response["totalResults"] && x < 5
      headlines << {title: articles[x]["title"], 
                    description: articles[x]["description"],
                    url: articles[x]["url"],
                    representative_id: rep_id,
                    issue: issue}
    end
    return headlines
  end
end
