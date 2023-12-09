# frozen_string_literal: true

describe MyNewsItemsController do
  describe 'new' do
    it 'should create new item' do
      controller.new
      expect(assigns(:news_item)).to_not eq(nil)
    end
  end
end