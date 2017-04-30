# encoding: utf-8
# To change this template, choose Tools | Templates
# and open the template in the editor.

module Napakalaki
  require_relative 'monster.rb'
  attr_reader :treasures, :Levels
  
  class Prize
    def initialize(treasures,levels)
        @treasures = treasures
        @Levels = levels
    end
    def getlevel
        return @Levels
    end
    def gettreasure
        return @treasures
    end
    def to_s
      "\nTesoros ganados = #{@treasures} 
       \nNiveles ganados = #{@Levels}"
    end
  end
end