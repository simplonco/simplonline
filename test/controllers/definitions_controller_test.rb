require 'test_helper'

class DefinitionsControllerTest < ActionController::TestCase

  attr_reader :user

  def setup
    @user = FactoryGirl.create(:user)
    session[:user_id] = user.id
  end

  test "index" do
    get :index
    assert_response :success
  end

  test "new" do
    get :new
    assert_response :success
  end

  test "create" do
    FactoryGirl.create(:definition)
    post :create, definition: {keyword: 'something', description: 'truc'}
    assert_redirected_to definitions_path(anchor: 'something')
  end

  test "edit" do
    definition = FactoryGirl.create(:definition)
    get :edit, id: definition.id
    assert_response :success
    assert_equal definition, assigns(:definition)
  end

  test "update" do
    definition = FactoryGirl.create(:definition)
    post :update, id: definition.id, definition: {description: 'other thing'}
    assert_redirected_to definitions_path(anchor: definition.keyword)
  end

  test "destroy" do
    definition = FactoryGirl.create(:definition, keyword: 'foo')
    chapter = FactoryGirl.create(:chapter, title: 'something', content: "<a href='/definitions/#{definition.id}' class='definition'>#{definition.keyword}</a>", authors: "c")
    definition.delete_links_in_chapters
    delete :destroy, id: definition.id
    assert_equal "foo", chapter.content
    assert_response :redirect
  end
end
  