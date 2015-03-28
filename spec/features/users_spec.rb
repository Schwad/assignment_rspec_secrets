require 'rails_helper'

feature 'User accounts feature testing' do 
  before do
    visit root_path
  end
  let(:secret){ create(:secret) }
  let(:user){ create(:user) }

  context "as a visitor" do
    scenario "view all secrets" do 
      my_secret = secret
      click_link "All Secrets"
      expect(page).to have_content "foo"
      expect(page).to have_content "**hidden**"
      expect(page).to have_content "Login"
      expect(current_path).to eq(secrets_path)
    end

    #artifact for signed in user
    #expect(page).to have_content secret.author.name

    scenario "sign up" do
      click_link "All Users"
      click_link "New User"
      name = "Fooba"
      fill_in "Name", with: name
      fill_in "Email", with: "jim@hotmail.com"
      fill_in "Password", with: "packfan1"
      fill_in "Password confirmation", with: "packfan1"
      expect{ click_button "Create User"}.to change(User, :count).by(1)
      expect(page).to have_content "Welcome, #{name}!"
    end
    scenario "sign in" do
      sign_in(user)
      expect(page).to have_content "Logout"
    end

    context "bad credentials" do
      before do
        user.email = user.email + "x"
        sign_in(user)        
      end
      scenario "refuse sign in with incorrect details" do 
        expect(page).to have_content "Login"
      end
    end

  end

  context "as signed in user" do 
    scenario "create a secret"
    scenario "edit a secret"
    scenario "delete a secret"
  end
end