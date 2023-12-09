# frozen_string_literal: true
require 'rails_helper'

describe EventsController do
  before (:each) do
    @event = Event.create
  end
  describe 'GET index' do
    it 'assgins events' do
      get :index
      expect(assigns(:events)).to eq([@event])
    end
  end
end