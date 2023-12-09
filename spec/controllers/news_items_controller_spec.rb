# frozen_string_literal: true

describe NewsItemsController do
  describe 'index' do
    it 'should find the right rep' do
      rep = Representative.new(name: "John", created_at: DateTime.now, updated_at: DateTime.now)
      allow(rep).to receive(:news_items) { "foo" }
      controller.params[:representative_id] = rep.id
      controller.index
      expect(assigns(:representative)).to eq(rep)
    end
  end
end