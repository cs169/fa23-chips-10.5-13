# frozen_string_literal: true

class RepresentativesController < ApplicationController
  def index
    @representatives = Representative.all
  end

  def show
    address = params[:address] #not sure if its id, but smthn like that; too tired rn
    name = params[:representative].name
    service = Google::Apis::CivicinfoV2::CivicInfoService.new
    service.key = Rails.application.credentials[:GOOGLE_API_KEY]
    result = service.representative_info_by_address(address: address)

    result.officials.each_with_index do |official, index|
      if official.name == name
        @addr = official.address
        @party = official.party
        @photo = official.photoUrl

        @representatives.offices.each do |office|
          if office.official_indices.include? index
            @title_temp = office.name
            @ocdid_temp = office.division_id
          end
        end
        
      end
    end
  end
end
