#encoding: utf-8 
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require_relative 'player.rb'
require_relative 'treasure.rb'
 module Napakalaki
class CultistPlayer < Player
  attr_accessor :totalCultistPlayers, :myCultistCard
  @@totalCultistPlayers=0
  def initialize (p,c)
    super(p)
    @nombre=p.name #variable para mostrar el nombre, pq si llamos a name del padre me muestra todos los parametros del jugador
    @myCultistCard=c
    @@totalCultistPlayers+=1
  end
  
  def getCombatLevel
    return @myCultistCard.getSpecialValue+super
  end
  def shouldConvert
    return false
  end
  def getOponentLevel(m)
    return m.combatLevel
  end
 
  def computerGoldConinsValue(t= Array.new)
    buylevel=super(t)
    buylevel*=2
    return buylevel
  end
  def self.totalCultistPlayers
    return @@totalCultistPlayers
  end
  def to_s
    "\n Jugador Sectario
        \nNombre = #{@nombre}
        \nNivel = #{@level}
        \nNivel de combate = #{getCombatLevel()}
        \nNumero de sectarios en juego= #{@@totalCultistPlayers} "
  end
end
end