# encoding: utf-8
require_relative 'treasure_kind'
require_relative 'card.rb'
module Napakalaki
  include Card
  class Treasure
       
    attr_accessor :name, :goldCoins, :minBonus, :maxBonus, :type
     
    def initialize(name, goldCoins , minBonus , maxBonus, type)
      @name = name
      @goldCoins = goldCoins
      @minBonus = minBonus
      @maxBonus =  maxBonus
      @type = type
    end
    def getBasicValue
        return @minBonus
    end
    def getSpecialValue
        return @maxBonus
    end
    def gettype
        return type
    end 
    def to_s
       "\nTesoro:
        \nNombre =  #{@name}
        \nMonedas de Oro = #{@goldCoins}
        \nBonus Minimo = #{@minBonus}
        \nBonus Maximo = #{@maxBonus}
        \nTipo de Tesoro = #{@type}"
    end
  
  
  end
end

