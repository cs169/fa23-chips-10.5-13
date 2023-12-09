# frozen_string_literal: true

describe State, type: :model do
  describe 'fips_code' do 
    it 'should add a leading zero to single digits' do
      california = State.create(name: 'california', symbol: 'CA', fips_code: 1, is_territory: 1, lat_min: 1, lat_max: 1, long_min: 1, long_max: 1, created_at: DateTime.now, updated_at: DateTime.now)
      expect(california.std_fips_code).to eq('01')
    end
  end
end