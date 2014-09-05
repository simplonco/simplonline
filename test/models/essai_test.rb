require 'test_helper'

class EssaiTest < ActiveSupport::TestCase
  test "valid factory" do
    assert_equal true, FactoryGirl.build(:essai).valid?
  end

  test "invalid without exercice" do
    assert_equal true, FactoryGirl.build(:essai, exercice: nil).invalid?
  end

  test 'inscrire fichier uploader dans la base de données' do
   # essai = FactoryGirl.build(:essai)
   # assert_equal "def app(echantillon)\n  echantillon.split(',').map{|s| s.to_i}.inject(:+)\nend\n", essai.file_writer
  end

end
