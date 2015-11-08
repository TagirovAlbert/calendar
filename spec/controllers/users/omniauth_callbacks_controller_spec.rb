require 'rails_helper'

RSpec.describe Users::OmniauthCallbacksController, type: :controller do

  describe "GET #facebook" do
    it "returns http success" do
      get :facebook
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #vkontakte" do
    it "returns http success" do
      get :vkontakte
      expect(response).to have_http_status(:success)
    end
  end

end
