require 'test_helper'

class EssaiTest < ActiveSupport::TestCase
  test "valid factory" do
    assert_equal true, FactoryGirl.build(:essai).valid?
  end

  test "invalid without exercice" do
    assert_equal true, FactoryGirl.build(:essai, exercice: nil).invalid?
  end

  test "return a dossier" do
    essai = FactoryGirl.create(:essai)
    expected_dir = "#{Rails.root}/public/exercice/#{essai.exercice.id}/user/essai/#{essai.id}"
    assert_equal expected_dir, essai.dossier
  end

  test "valid pour une réponse texte exacte" do
    exercice = FactoryGirl.create(:exercice, reponse: "10", format_reponse: 1)
    essai = FactoryGirl.create(:essai, exercice_id: exercice.id, reponse_char: "10")
    assert_equal true, essai.is_valid?
  end

  test "valide pour un programme en ruby" do
    exercice = FactoryGirl.create(:exercice, reponse: "10", format_reponse: 3, echantillon: "4, 6")
    essai = FactoryGirl.create(:essai, exercice_id: exercice.id)
    assert_equal true, essai.is_valid?
  end

end
