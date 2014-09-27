require 'test_helper'

class TagsControllerTest < ActionController::TestCase

  def setup
    @user = FactoryGirl.create(:user, student_type: User::LOCAL)
    session[:user_id] = @user.id
  end

  test "show" do
    chapter = FactoryGirl.create(:chapter, tags: [:tools])
    get :show, id: 'tools'
    assert_response :success
    assert_equal 'tools', assigns(:tag)
    assert_equal [chapter], assigns(:chapters)
  end

end
