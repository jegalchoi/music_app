require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    it "renders the new template" do
      get :new, {}
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    context "with invalid params" do
      it "validates the presence of user's email and password" do
        post :create, params: { user: { email: "example@email.com", password: "" } }
        expect(response).to render_template(:new)
        expect(flash[:errors]).to be_present
      end

      it "validates that the password is at least six chars long" do
        post :create, params: { user: { email: "example@email.com", password: "pass" } }
        expect(response).to render_template(:new)
        expect(flash[:errors]).to be_present
      end
    end

    context "with valid params" do
      it "redirects user to bands index on success" do
        post :create, params: { user: { email: "example@email.com", password: "password" } }
        expect(response).to redirect_to(user_url(User.find_by(email: "example@email.com")))
      end
    end

  end

end
