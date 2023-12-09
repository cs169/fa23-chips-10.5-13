# frozen_string_literal: true

describe MapController do
  before (:each) do
    @california = State.create(name: 'california', symbol: 'CA', fips_code: 1, is_territory: 1, lat_min: 1, lat_max: 1, long_min: 1, long_max: 1, created_at: DateTime.now, updated_at: DateTime.now)
    @texas = State.create(name: 'texas', symbol: 'TX', fips_code: 1, is_territory: 1, lat_min: 1, lat_max: 1, long_min: 1, long_max: 1, created_at: DateTime.now, updated_at: DateTime.now)
  end
  describe 'GET index' do
    it 'assigns states' do
      get :index
      expect(assigns(:states)).to eq([@california, @texas])
    end
  end

  describe 'GET state' do
    it 'finds state with correct symbol' do 
      get :state, params: {state_symbol: 'tx'}
      expect(assigns(:state)).to eq(@texas)
    end
  end
end