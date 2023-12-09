# frozen_string_literal: true

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all

  def self.civic_api_to_representative_params(rep_info)
    reps = []

    rep_info.officials.each_with_index do |official, index|
      ocdid_temp = ''
      title_temp = ''

      rep_info.offices.each do |office|
        if office.official_indices.include? index
          title_temp = office.name
          ocdid_temp = office.division_id
        end
      end

      party = official.party
      photo = official.photo_url

      rep = Representative.where({ name: official.name, ocdid: ocdid_temp, title: title_temp })
      if (rep.length() == 0)
        address_temp = nil
        if !official.address.nil? and !official.address.length.zero?
          address_list = official.address[0]
          address_temp = "#{address_list.line1} #{address_list.city} #{address_list.state} #{address_list.zip}"
        end
        rep = Representative.new(
          name: official.name,
          ocdid: ocdid_temp,
          title: title_temp,
          address: address_temp,
          political_party: party,
          photo_url: photo)
        rep.save!
      else
        rep = rep.first
      end
      reps.push(rep)
    end
    reps
  end
end
