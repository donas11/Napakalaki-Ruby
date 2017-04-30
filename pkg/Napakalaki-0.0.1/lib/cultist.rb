#encoding: utf-8 
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require_relative 'card.rb'
require_relative 'cultist_player.rb'
 module Napakalaki
  include Card
  class Cultist
    attr_accessor :name, :gainedLevels
    def initialize(name , gainedLevels) 
      @name="name"
      @gainedLevels=gainedLevels
    end
   
    def getSpecialValue
      return @gainedLevels*CultistPlayer.totalCultistPlayers
      
    end
    def to_s
      "\nSectarios:
      \nNombre = #{@name}
      \nNiveles Ganados = #{@gainedLevels}"
    end
  end
 end