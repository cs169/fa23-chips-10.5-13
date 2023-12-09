# frozen_string_literal: true

describe RepresentativesController do
  describe 'index' do
    it 'should return all representatives' do
      rep1 = Representative.new(name: "John", created_at: DateTime.now, updated_at: DateTime.now)
      rep2 = Representative.new(name: "Bob", created_at: DateTime.now, updated_at: DateTime.now)
      get :index
      expect(assigns(:representatives)).to eq([rep1, rep2])
    end
  end
end