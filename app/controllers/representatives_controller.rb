# frozen_string_literal: true

class RepresentativesController < ApplicationController
  def index
    @representatives = Representative.all
  end

  # def show
  #   address = params[:format]
  #   # get :state, params: {state}
  #   @representative = Representative.find(params[:id])
  #   service = Google::Apis::CivicinfoV2::CivicInfoService.new
  #   service.key = Rails.application.credentials[:GOOGLE_API_KEY]
  #   result = service.representative_info_by_address(address: address)
    

  #   result.officials.each_with_index do |official, index|
  #     if official.name == @representative.name
  #       @address = official.address
  #       @party = official.party
  #       @photo = official.photo_url
  #     end
  #   end
  # end

  def show
    @representative = Representative.find(params[:id])
    @address = @representative[:address]
    @photo = @representative[:photo_url]
    @party = @representative[:political_party]
  end

end
