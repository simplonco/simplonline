require 'test_helper'

class DefinitionsControllerTest < ActionController::TestCase

  attr_reader :user

  def setup_with(student_type)
    @user = FactoryGirl.create(:user, student_type: student_type)
    session[:user_id] = @user.id
  end

  test "index" do
    setup_with(User::REMOTE)
    get :index
    assert_response :success
  end

  test "new" do
    setup_with(User::LOCAL)
    get :new
    assert_response :success
  end

  test "remote student can't acceed to new" do
    setup_with(User::REMOTE)
    get :new
    assert_redirected_to root_path
  end

  test "create" do
    setup_with(User::LOCAL)
    FactoryGirl.create(:definition)
    post :create, definition: {keyword: 'something', description: 'truc'}
    assert_redirected_to definitions_path(anchor: 'something')
  end

  test "edit" do
    setup_with(User::LOCAL)
    definition = FactoryGirl.create(:definition)
    get :edit, id: definition.id
    assert_response :success
    assert_equal definition, assigns(:definition)
  end

  test "update" do
    setup_with(User::LOCAL)
    definition = FactoryGirl.create(:definition)
    post :update, id: definition.id, definition: {description: 'other thing'}
    assert_redirected_to definitions_path(anchor: definition.keyword)
  end

  test "destroy" do
    setup_with(User::LOCAL)
    definition = FactoryGirl.create(:definition, keyword: 'foo')
    chapter = FactoryGirl.create(:chapter, title: 'something', content: "<a href='/definitions/#{definition.id}' class='definition'>#{definition.keyword}</a>")
    definition.delete_links_in_chapters
    delete :destroy, id: definition.id
    assert_redirected_to definitions_path
    assert_equal 0, Definition.count
  end
end

