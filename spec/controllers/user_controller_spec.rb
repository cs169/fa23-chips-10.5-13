# frozen_string_literal: true

describe UserController do
  describe 'profile' do
    it 'should find user from current session' do
      user1 = User.new(provider: 1, uid: '1', first_name: 'John', last_name: 'Smith', created_at: DateTime.now, updated_at: DateTime.now)
      user2 = User.new(provider: 1, uid: '2', first_name: 'Bob', last_name: 'Jones', created_at: DateTime.now, updated_at: DateTime.now)
      get :profile, session: {current_user_id: '2'}
      expect(assigns(:user)).to eq(user2)
    end
  end
end