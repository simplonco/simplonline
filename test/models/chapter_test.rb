require 'test_helper'

class ChapterTest < ActiveSupport::TestCase

  test "valid factory" do
    assert FactoryGirl.build(:chapter).valid?
  end

  test "invalid without title" do
    assert FactoryGirl.build(:chapter, title: nil).invalid?
  end

  test "invalid without authors" do
    assert FactoryGirl.build(:chapter, authors: []).invalid?, 'should have at leat one author'
  end

  test "invalid without number" do
    assert FactoryGirl.build(:chapter, number: nil).invalid?, 'should have an number'
  end

  test "add definitions to chapter" do
    definition = FactoryGirl.create(:definition, keyword: "word")
    chapter = FactoryGirl.build(:chapter, content: "Word")
    chapter.insert_definitions!
    expected_content = "[Word](/definitions/#{definition.id})"
    assert_equal expected_content, chapter.content
  end

  test "insert defintion" do
    definition = FactoryGirl.create(:definition, keyword: 'keyword')
    chapter = FactoryGirl.build(:chapter, content: "a content with some **keyword** that I wanna link to *definition*")
    chapter.insert_definitions!
    expected_content = "a content with some [**keyword**](/definitions/#{definition.id}) that I wanna link to *definition*"
    assert_equal expected_content, chapter.content
  end

  test "add definitions when an other definition is already linked to chapter" do
    skip
    definition = FactoryGirl.create(:definition, keyword: 'agilité')
    chapter = FactoryGirl.build(:chapter, content: "le mot [agilité](/definitions/#{definition.id}) c'est mieux  le gras **agilité** est-ce mieux ?")
    chapter.insert_definitions!
    expected_content = "le mot [agilité](/definitions/#{definition.id}) c'est mieux le gras [**agilité**](/definitions/#{definition.id}) est-ce mieux ?"
    assert_equal expected_content, chapter.content
  end

  test "filter on tag" do
    tools_chapter = FactoryGirl.create(:chapter, tags: ['tools'])
    kata_chapter = FactoryGirl.create(:chapter, tags: ['kata'])
    assert_equal [kata_chapter], Chapter.about(:kata)
  end

  test "default sort by number" do
    second_chapter = FactoryGirl.create(:chapter, number: 1)
    first_chapter = FactoryGirl.create(:chapter, number: 0)
    assert_equal [first_chapter, second_chapter], Chapter.all
  end
end


