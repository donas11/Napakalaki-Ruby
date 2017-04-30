# encoding: utf-8
# To change this template, choose Tools | Templates
# and open the template in the editor.

require_relative 'prize.rb'
require_relative 'bad_consequence.rb'
require_relative 'treasure_kind.rb'
require_relative 'card_dealer.rb'
require_relative 'combat_result.rb'
require_relative 'dice.rb'
require_relative 'napakalaki.rb'
require_relative 'player.rb'
require_relative 'treasure.rb'
require_relative 'card.rb'

module Napakalaki
  
  
  class Monster
    
    attr_accessor :name, :combatLevel, :badConsequence ,:prize, :levelChangeAgainstCultistPlayer
    def initialize(name, combatLevel,badConsequence , prize, levelChangeAgainstCultistPlayer)
      @name = name
      @combatLevel = combatLevel
      @badConsequence = badConsequence
      @prize = prize
      @levelChangeAgainstCultistPlayer=levelChangeAgainstCultistPlayer
    end  
    def kills
      return @badConsequence.myBadConsequeseIsDeath()
    end
    def getLevelsGained
      
      return @prize.getlevel
    end
    def getBasicValue
      
      return @combatLevel
    end
    def getTreasuresGained
      return @prize.gettreasure
    end
    def getSpecialValue
      return @combatLevel+@levelChangeAgainstCultistPlayer
    end
    def to_s
     "\nMonstro:
      \nNombre = #{@name} 
      \nNivel = #{@combatLevel} 
      \nPremios = #{@prize} 
      \nMal Rollo = #{@badConsequence}"
    end
  end
end