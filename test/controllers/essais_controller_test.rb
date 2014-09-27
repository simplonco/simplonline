require 'test_helper'

class EssaisControllerTest < ActionController::TestCase
  def setup
    user = FactoryGirl.create(:user, student_type: User::LOCAL)
    session[:user_id] = user.id
  end

  test "should get show" do
    exercice = FactoryGirl.create(:exercice)
    essai = FactoryGirl.create(:essai)
    get :show, exercice_id: exercice.id, id: essai.id
    assert_response :success
  end
end
