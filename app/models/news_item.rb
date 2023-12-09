# frozen_string_literal: true

class NewsItem < ApplicationRecord
  belongs_to :representative
  has_many :ratings, dependent: :delete_all
  ISSUES = ["Free Speech", "Immigration", "Terrorism", "Social Security and Medicare", "Abortion", "Student Loans", "Gun Control", "Unemployment", "Climate Change", "Homelessness", "Racism", "Tax Reform", "Net Neutrality", "Religious Freedom", "Border Security", "Minimum Wage", "Equal Pay"]
  enum issue:ISSUES
  
  def self.find_for(representative_id)
    NewsItem.find_by(
      representative_id: representative_id
    )
  end

  def self.get_topheadlines(rep_id, issue, api_key)
    headlines ||= []
  
    rep_name = Representative.find(rep_id).name
    uri = "https://newsapi.org/v2/top-headlines"
    params = {
      country: "us",
      q: "#{issue} #{rep_name}",
      apiKey: api_key
    }
  
    uri_string = "#{uri}?#{URI.encode_www_form(params)}"
    response = JSON.parse(Faraday.get(uri_string).body)
    articles = response["articles"]
  
    if response["totalResults"].present? # Check if totalResults is not nil
      x = 0
  
      while x < response["totalResults"] && x < 5
        headlines << {
          title: articles[x]["title"],
          description: articles[x]["description"],
          url: articles[x]["url"],
          representative_id: rep_id,
          issue: issue
        }
        x = x + 1
      end
    end
  
    return headlines
  end
end
