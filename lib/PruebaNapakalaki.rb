# To change this template, choose Tools | Templates
# and open the template in the editor.

module Napakalaki
  require_relative 'prize'
  require_relative 'bad_consequence'
  require_relative 'treasure_kind'
  require_relative 'monster'

  
  #Consulta: Monstruos con nivel de combate >10
  
  #def self.combatLevel10 (monsters)
  #  puts "\nMonstruos con nivel de combate superior a 10:\n"
  #  for i in 0... monsters.size 
  #    if monsters[i].combatLevel > 10
  #      puts monsters[i]
  #    end
  #  end
    
  #end
  
  #Consulta: Monstruos que tengan un mal rollo que implique solo perdida de niveles
  
  #def self.MonstruosPerdidaNiveles (monsters)
   # puts "\nMonstruos con mal rollo que implique solo perdida de niveles :\n"
    
    #for i in 0... monsters.size
      
     # if monsters[i].bad_consequence.levels > 0
      #  puts monsters[i]
      #end
   # end
    
  #end
  
  #Mostrar todos los monstruos que tengan un buen rollo que indique una ganancia de niveles superior a 1.
  
   # def self.MonstruosGananciaNiveles(monsters)
    #puts "\nMonstruos que tengan un buen rollo que indique una ganancia de niveles superior a 1:\n"
    #for i in 0...monsters.size
     #   if monsters[i].prize.levels > 1
      #    puts monsters[i]
       # end 
    #end
 # end  
  
  #def self.MonstruosPerdidaTesoros(monsters, treasure)
   #  puts "\nMostrar todos los monstruos que tengan un mal rollo que suponga la perdida de un determinado tipo de tesoros ya sea visibles y/o ocultos:\n"
    # for i in 0...monsters.size
     #  for j in 0...monsters[i].bad_consequence.specificVisibleTreasures.size
      #   if monsters[i].bad_consequence.specificVisibleTreasures[j] == treasure
       #    puts monsters[i]
        # else
         #  for k in 0...monsters[i].bad_consequence.specificHiddenTreasures.size
          #   if monsters[i].bad_consequence.specificHiddenTreasures[k] == treasure
           #   puts monsters[i]
            # end
           #end
         #end
        #end
     #end
  #end
 
  
  
  
  
  
end