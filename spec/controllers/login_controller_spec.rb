# frozen_string_literal: true

describe LoginController do
  before (:each) do
    request.env['omniauth.auth'] = 'foo'
    @user = double('user')
    allow(@user).to receive(:id) { '0' }
    controller.stub(:find_or_create_user) { @user }
  end
  describe 'Google login' do
    it 'redirects to google login' do
      get :google_oauth2
      expect(response.status).to eq(302)
    end
  end
  describe 'Github login' do
    it 'redirects to github login' do
      get :github
      expect(response.status).to eq(302)
    end
  end
  describe 'logout' do
    it 'redirects and nulls out user id' do
      get :logout, session: { current_user_id: 1}
      expect(response.status).to eq(302)
      expect(session[:current_user_id]).to eq(nil)
    end
  end
end