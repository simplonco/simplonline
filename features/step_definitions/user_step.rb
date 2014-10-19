Given(/^a user$/) do
  FactoryGirl.create(:user)
end

Given(/^I am a loggued user$/) do
  user = FactoryGirl.create(:user, email: 'me@laposte.net', password: 'generic', password_confirmation: 'generic')
  visit welcome_path
  fill_in("email", :with => user.email)
  fill_in("password", :with => 'generic')
  click_button(I18n.t("layouts.application.login"))
  assert_text(user.name.capitalize)
end

Given(/^a lesson call "(.*?)" exist$/) do |lesson_name|
  FactoryGirl.create(:lesson, title: lesson_name, online: true)
end

Given(/^I am a loggued remote user$/) do
  @user = FactoryGirl.create(:user, email: 'me@laposte.net', password: 'generic', password_confirmation: 'generic', student_type: User::REMOTE)
  visit welcome_path
  fill_in("email", :with => @user.email)
  fill_in("password", :with => 'generic')
  click_button(I18n.t("layouts.application.login"))
  assert_text(@user.name.capitalize)
end

When(/^I go to home page$/) do
  visit root_path
end

When(/^I go to lessons page$/) do
  visit lessons_path
end

When(/^I go to edit profil page$/) do
  visit edit_user_path(@user)
end

Then(/^I can see user form$/) do
  assert page.has_button?(I18n.t('users.edit.submit')), 'pas de boutont pour mise à jour du profil'
end

Then(/^I can login$/) do
  assert page.has_content?(I18n.t('layouts.application.email')), 'pas de label email'
  assert page.has_button?(I18n.t('layouts.application.login')), 'pas de bouton login'
end

Then(/^I can see lesson call "(.*?)"$/) do |lesson_title|
  assert_text(lesson_title)
end

