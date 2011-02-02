require 'spec_helper'

describe "Microposts" do

  before(:each) do
    user = Factory(:user)
    visit signin_path
    fill_in :email, :with => user.email
    fill_in :password, :with => user.password
    click_button
  end

  it "should have sidebar micropost counts with proper pluralization" do
    visit root_path
    response.should have_selector('span.microposts', :content => "0 microposts")
  end


  describe "creation" do

    describe "failure" do

      it "should not make a new micropost" do
        lambda do
          visit root_path
          fill_in :micropost_content, :with => ""
          click_button
          response.should render_template('pages/home')
          response.should have_selector("div#error_explanation")
        end.should_not change(Micropost, :count)
      end

      it "should not create new micropost longer than 140 characters and not clear text area" do
        lambda do
          visit root_path
          fill_in :micropost_content, :with => "a" * 141
          click_button
          response.should render_template('pages/home')
          response.should have_selector("textarea", :content => "a" *141)
        end.should_not change(Micropost,:count)
      end
    end

    describe "success" do
      it "should make a new micropost" do
        content = "Lorem ipsum dolor sit amet"
        lambda do
          visit root_path
          fill_in :micropost_content, :with => content
          click_button
          response.should have_selector("span.content", :content => content)
        end.should change(Micropost, :count).by(1)
      end
    end
  end
end
