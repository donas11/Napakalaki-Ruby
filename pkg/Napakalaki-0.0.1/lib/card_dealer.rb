#encoding: utf-8 
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require_relative 'prize.rb'
require_relative 'treasure_kind.rb'
require_relative 'bad_consequence.rb'
require_relative 'monster.rb'
require_relative 'treasure.rb'
require_relative 'cultist.rb'
require 'singleton'
module Napakalaki
class CardDealer
  include Singleton
  
  attr_accessor :unusedMonsters,:usedMonsters,:unusedTreaures,:usedTreaures
    def initialize
        @unusedMonsters=Array.new()
        @usedMonsters=Array.new()
        @unusedTreaures=Array.new()
        @usedTreaures=Array.new()
        @unusedCultist=Array.new()  
    end 
    def initTreasureCardDeck
        @unusedTreaures << Treasure.new("¡Sí mi amo!",0,4,7, HELMET )
        @unusedTreaures << Treasure.new("Botas de investigación",600,3,4, SHOE )
        @unusedTreaures << Treasure.new("Capucha de Cthulhu",500,3,5, HELMET )
        @unusedTreaures << Treasure.new("A pruebas de babas",400,2,5, ARMOR )
        @unusedTreaures << Treasure.new("Botas de lluvia ácida",800,1,1, BOTHHAND )
        @unusedTreaures << Treasure.new("Casco minero",400,2,4, HELMET )
        @unusedTreaures << Treasure.new("Ametralladora Thompson",600,4,8, BOTHHAND )
        @unusedTreaures << Treasure.new("Camiseta de la UGR",100,1,7, ARMOR )
        @unusedTreaures << Treasure.new("Clavo de rail ferroviario",400,3,6, ONEHAND )
        @unusedTreaures << Treasure.new("Cuchillo de sushi arcano",300,2,3, ONEHAND )
        @unusedTreaures << Treasure.new("Fez alópodo",700,3,5, HELMET )
        @unusedTreaures << Treasure.new("Hacha prehistórica",500,2,5, ONEHAND )
        @unusedTreaures << Treasure.new("El aparato del Pr. Tesla",900,4,8, ARMOR )
        @unusedTreaures << Treasure.new("Gaita",500,4,5, BOTHHAND )
        @unusedTreaures << Treasure.new("Insecticidad",300,2,3, ONEHAND )
        @unusedTreaures << Treasure.new("Escopeta de 3 cañones",700,4,6, BOTHHAND )
        @unusedTreaures << Treasure.new("Garabato místico",300,2,2, ONEHAND )
        @unusedTreaures << Treasure.new("la Fuerza de Mr.T",1000,0,0, NECKLACE )
        @unusedTreaures << Treasure.new("La rebeca metálica",400,2,3, ARMOR )
        @unusedTreaures << Treasure.new("Mazo de los antiguos",200,3,4, ONEHAND )
        @unusedTreaures << Treasure.new("Necro-playboycón",300,3,5, ONEHAND )
        @unusedTreaures << Treasure.new("Lanzallamas",800,4,8, BOTHHAND )
        @unusedTreaures << Treasure.new("Necro-comicón",100,1,1, ONEHAND )
        @unusedTreaures << Treasure.new("Necronomicón",800,5,7, BOTHHAND )
        @unusedTreaures << Treasure.new("Linterna a 2 manos",400,3,6, BOTHHAND )
        @unusedTreaures << Treasure.new("Necro-gnomicón",200,2,4, ONEHAND )
        @unusedTreaures << Treasure.new("Necrotelecom",300,2,3, HELMET )
        @unusedTreaures << Treasure.new("Porra preternatural",200,2,3, ONEHAND )
        @unusedTreaures << Treasure.new("Tentáculo de pega",200,0,1, HELMET )
        @unusedTreaures << Treasure.new("Zapato deja-amigos",500,0,1, SHOE )
        @unusedTreaures << Treasure.new("Shogulador",600,1,1, ONEHAND )
        @unusedTreaures << Treasure.new("Varita de atizamiento",400,3,4, ONEHAND )
    end
    
    def initMonsterCardDeck
        @unusedMonsters << Monster.new("El rey de rosa", 13,BadConsequence.newLevelNumberOfTreasures("Pierdes 5 niveles", 5, 0, 0),Prize.new(4,2),0)
        @unusedMonsters << Monster.new("3 Byakhees de bonanza", 8, BadConsequence.newLevelSpecificTreasures("Pierdes tu armadura visible y otra oculta ", 0, [ARMOR], [ARMOR]),Prize.new(2,1),0)
        @unusedMonsters << Monster.new("Chibithulhu", 2, BadConsequence.newLevelSpecificTreasures("Embobados con el lindo primigenio te descartas de tu casco visible", 0,[HELMET], []),Prize.new(1,1),0)
        @unusedMonsters << Monster.new("El sopor de Dunwich", 2, BadConsequence.newLevelSpecificTreasures("El primordial bostezo contagioso", 0, [SHOE], []),Prize.new(1,1),0)
        @unusedMonsters << Monster.new("Ángeles de la noche ibicenca", 14,BadConsequence.newLevelSpecificTreasures("Te atrapan para llevarte de fiesta y te dejan caer en mitad del vuelo.Descarta 1 mano visible y 1 mano oculta", 0, [ONEHAND], [ONEHAND]), Prize.new(4,1),0)
        @unusedMonsters << Monster.new("El gorrón en el umbral", 10, BadConsequence.newLevelNumberOfTreasures("Pierdes todos los tesoros visibles", 0, 10, 0),Prize.new(3,1),0)
        @unusedMonsters << Monster.new("H.P. Munchcraft", 6, BadConsequence.newLevelSpecificTreasures("Pierdes la armadura visible", 0, [ ARMOR], []),Prize.new(2,1),0)
        @unusedMonsters << Monster.new("Bichgooth", 2, BadConsequence.newLevelSpecificTreasures("Sientes bichos bajo la ropa.Descarta la armadura visible", 0, [ ARMOR], []),Prize.new(1,1),0)
        @unusedMonsters << Monster.new("El rey de rosa", 13, BadConsequence.newLevelNumberOfTreasures("Pierdes 5 niveles y 3 tesoros visibles", 5, 3, 0),Prize.new(4,2),0)
        @unusedMonsters << Monster.new("la que redacta en las tinieblas", 2, BadConsequence.newLevelNumberOfTreasures("Toses los pulmones y pierdes 2 niveles", 2, 0, 0),Prize.new(1,1),0)
        @unusedMonsters << Monster.new("Los hondos", 8, BadConsequence.newDeath("Estos monstruos resultan bastante superficiales y te aburren mortalmente. Estas muerto",true),Prize.new(2,1),0)
        @unusedMonsters << Monster.new("Semillas Cthulhu", 4, BadConsequence.newLevelNumberOfTreasures("Pierdes 2 niveles y 2 tesoros ocultos", 2, 0, 2),Prize.new(2,1),0)
        @unusedMonsters << Monster.new("Dameargo", 1, BadConsequence.newLevelSpecificTreasures("Te intentas escaquear. Pierdes una mano visible", 0, [ ONEHAND], []),Prize.new(2,1),0)
        @unusedMonsters << Monster.new("Pollipólipo Volante", 3, BadConsequence.newLevelNumberOfTreasures("Da mucho asquito", 3, 0, 0),Prize.new(1,1),0)
        @unusedMonsters << Monster.new("Yskhtihyssg-Goth", 12, BadConsequence.newDeath("No le hace gracia que pronuncien mal su nombre.Estas muerto",true),Prize.new(3,1),0)
        @unusedMonsters << Monster.new("Familia feliz", 1, BadConsequence.newDeath("La familia te atrapa, Estás muerto",true),Prize.new(4,1),0)
        @unusedMonsters << Monster.new("Roboggoth", 8, BadConsequence.newLevelSpecificTreasures("la quinta directiva primaria te obliga a perder 2 niveles y un tesoro visible 2 manos visibles", 2,  [BOTHHAND], []) ,Prize.new(2,1),0)
        @unusedMonsters << Monster.new("El espia", 5, BadConsequence.newLevelSpecificTreasures("Te asusta en la noche. Pierdes un casco visible", 0, [ HELMET], []),Prize.new(1,1),0)
        @unusedMonsters << Monster.new("El Lenguas", 20, BadConsequence.newLevelNumberOfTreasures("Menudo susto te llevas", 2, 5, 0),Prize.new(1,1),0 )
        @unusedMonsters << Monster.new("Bicéfalo", 20, BadConsequence.newLevelNumberOfTreasures("Te faltan manos para tanta cabeza", 3, 10, 0),Prize.new(1,1),0)
        @unusedMonsters << Monster.new("El mal indecible impronunciable", 10, BadConsequence.newLevelSpecificTreasures("Pierdes 1 mano visible", 0,[ONEHAND], []), Prize.new(3, 1),-2)
        @unusedMonsters << Monster.new("Testigos Oculares", 6, BadConsequence.newLevelNumberOfTreasures("Pierdes tus tesoros visibles. Jajaja.", 0, 6, 0), Prize.new(2, 1),2)
        @unusedMonsters << Monster.new("El gran cthulhu", 20, BadConsequence.newDeath("Hoy no es tu dia de suerte. Mueres", true), Prize.new(2, 5),4)
        @unusedMonsters << Monster.new("Serpiente Politico", 8,  BadConsequence.newLevelNumberOfTreasures("Tu gobierno te recorta 2 niveles", 2, 0, 0), Prize.new(2, 1),-2)
        @unusedMonsters << Monster.new("Felpuggoth", 2,BadConsequence.newLevelSpecificTreasures("Pierdes tu casco y tu armadura visible. Pierdes tus manos ocultas.", 0,[HELMET,ARMOR], [ONEHAND,ONEHAND,BOTHHAND]), Prize.new(1, 1), 5)
        @unusedMonsters << Monster.new("Shoggoth", 16, BadConsequence.newLevelNumberOfTreasures("Pierdes 2 niveles", 2, 0, 0), Prize.new(4, 2),4 )
        @unusedMonsters << Monster.new("Lolitagooth", 2, BadConsequence.newLevelNumberOfTreasures("Pintalabios Negro. Pierdes 2 niveles", 2, 0, 0), Prize.new(1, 1),3 )
    end
    def initCultistCardDeck
        @unusedCultist << Cultist.new("1", 1)
        @unusedCultist << Cultist.new("2", 2)
        @unusedCultist << Cultist.new("3", 1)
        @unusedCultist << Cultist.new("4", 2)
        @unusedCultist << Cultist.new("5", 1)
        @unusedCultist << Cultist.new("6", 1)  
    end
    def shuffleTreasures
      m = @unusedTreaures.shuffle
      @unusedTreaures= m
    end
    
    
    def shuffleMonsters
      m =@unusedMonsters.shuffle
      @unusedMonsters = m
    end
    
    def shuffleCultists
      m = @unusedCultist
      @unusedCultist = m
    end
    def nextCultist
        shuffleCultists
        siguiente = @unusedCultist.at(0)
        @unusedCultist.delete(0)
        @usedCultist
        return siguiente;
    end
    def nextTreasure
      if(@unusedTreaures.size==0)
          @unusedTreaures=@usedTreaures      
          @usedTreaures.clear
      end
        shuffleTreasures
        siguiente = @unusedTreaures.at(0)
        @unusedTreaures.delete(0)
        @usedTreaures << siguiente
        return siguiente;
    end
    
    def nextMonster
      if(@unusedMonsters.size()==0)
            @unusedMonsters=@usedMonsters
            @usedMonsters.clear 
      end
      shuffleMonsters
      siguiente = @unusedMonsters.at(0)
      @unusedMonsters.delete(0)
      @usedMonsters << siguiente
      return siguiente
    end
    
    
    def giveTreasureBack(t)
      @usedTreaures << t
    end
    
    
    def giveMonsterBack(m)
      @usedMonsters << m
    end
    
    def initCards
        initMonsterCardDeck
        initTreasureCardDeck
        initCultistCardDeck
    end
  
end
end
