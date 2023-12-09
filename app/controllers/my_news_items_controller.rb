# frozen_string_literal: true

class MyNewsItemsController < SessionController
  before_action :set_representative
  before_action :set_representatives_list
  before_action :set_news_item, only: %i[edit update destroy]

  def new
    @news_item = NewsItem.new
    rep_id = params[:news_item][:representative_id]
    @representative = Representative.find(rep_id)
    issue = params[:issue]
    
    api_key = Rails.application.credentials[:GOOGLE_NEWS_API_KEY]
    query = "#{@representative.name}+#{params[:issue]}"
    url = "https://newsapi.org/v2/everything?q=#{query}&pageSize=5&apiKey=#{api_key}"
    uri = URI.parse(url)
    raise ArgumentError, 'Invalid URL scheme' unless %w[http https].include?(uri.scheme)

    response = Net::HTTP.get_response(uri)
    article_serialized = response.body
    @articles = JSON.parse(article_serialized)
    @headlines = @articles[:articles]
    if @headlines.nil?
      @headlines = []
    end
    
    rescue StandardError => e
      @headlines = []
      flash.now[:error] = "Error: #{e.message}"

  end
    
  #   @headlines = []
  #   if rep_id.nil? or issue.nil?
  #     render :new, error: 'An error occured when searching the news item.'
  #   end
  #   @headlines = NewsItem.get_topheadlines(rep_id, issue, api_key)
  # end

  def edit; end

  def create
    @news_item = NewsItem.new(news_item_params)
    if @news_item.save
      redirect_to representative_news_item_path(@representative, @news_item),
                  notice: 'News item was successfully created.'
    else
      render :new, error: 'An error occurred when creating the news item.'
    end
  end

  def update
    if @news_item.update(news_item_params)
      redirect_to representative_news_item_path(@representative, @news_item),
                  notice: 'News item was successfully updated.'
    else
      render :edit, error: 'An error occurred when updating the news item.'
    end
  end

  def destroy
    @news_item.destroy
    redirect_to representative_news_items_path(@representative),
                notice: 'News was successfully destroyed.'
  end

  def search
    
    render :search

  end

  private

  def set_representative
    @representative = Representative.find(
      params[:representative_id]
    )
  end

  def set_representatives_list
    @representatives_list = Representative.all.map { |r| [r.name, r.id] }
  end

  def set_news_item
    @news_item = NewsItem.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def news_item_params
    params.require(:news_item).permit(:news, :title, :description, :link, :representative_id, :issue)
  end
end
