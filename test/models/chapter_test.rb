require 'test_helper'

class ChapterTest < ActiveSupport::TestCase

  test "valid factory" do
    assert FactoryGirl.build(:chapter).valid?
  end

  test "invalid without title" do
    assert FactoryGirl.build(:chapter, title: nil).invalid?
  end

  test "invalid without authors" do
    assert FactoryGirl.build(:chapter, authors: []).invalid?
  end

  test "insert defintion" do
    definition = FactoryGirl.create(:definition, keyword: 'keyword')
    chapter = FactoryGirl.create(:chapter, content: "a content with some **keyword** that I wanna link to *definition*")
    chapter.insert_definitions!
    expected_content = "a content with some [**keyword**](/definitions/#{definition.id}) that I wanna link to *definition*"
    assert_equal expected_content, chapter.content
  end

  test "add definitions to chapter" do
    chapter = FactoryGirl.create(:chapter, content: "Word")
    definition = FactoryGirl.create(:definition, id: 1, keyword: "word")
    chapter.insert_definitions!
    expected_content = "[Word](/definitions/#{definition.id})"
    assert_equal expected_content, chapter.content
  end
end


