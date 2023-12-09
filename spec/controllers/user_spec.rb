# frozen_string_literal: true

describe User, type: :model do
  describe 'name' do
    it 'should return name based on parameters' do
      user = User.new(provider: 1, uid: '1', first_name: 'John', last_name: 'Smith', created_at: DateTime.now, updated_at: DateTime.now)
      expect(user.name).to eq("John Smith")
    end
  end
end