# frozen_string_literal: true

describe MyEventsController do
  describe 'new' do
    it 'should create new event' do
      controller.new
      expect(assigns(:event)).to_not eq(nil)
    end
  end
end