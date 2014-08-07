Given(/^a user$/) do
  FactoryGirl.create(:user)
end

When(/^I go to home page$/) do
  visit root_path
end

Then(/^I can login$/) do
  page.has_content?(I18n.t('.login'))
end
