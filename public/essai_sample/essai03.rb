class Demande
  attr_reader :debut, :fin, :prix

  def initialize(debut, fin, prix)
    @debut = debut
    @fin = fin
    @prix = prix
  end

  def compatible?(demandes_suivantes)
    return true if demandes_suivantes.empty?

    @fin <= demandes_suivantes[0].debut
  end

  def to_s
    return "[#{@debut}, #{@fin}] = #{@prix}"
  end
end


def calcul_chiffre_affaire_max(demandes)
  return 0 if (demandes.empty?) 

  chiffre_affaire_suivantes = calcul_chiffre_affaire_max(demandes[1..-1])

  suivantes_compatibles = demandes[1..-1].delete_if(){|demande| ! demandes[0].compatible?([demande])}
  chiffre_affaire_demande = demandes[0].prix + calcul_chiffre_affaire_max(suivantes_compatibles)

  return [chiffre_affaire_demande, chiffre_affaire_suivantes].max
end

def app(input)
  demandes = eval(input)
  calcul_chiffre_affaire_max(demandes)
end
