def app(echantillon)
  echantillon.split(',').map{|s| s.to_i}.inject(:+)
end
