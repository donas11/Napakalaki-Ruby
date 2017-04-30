#encoding: utf-8 
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require_relative 'prize.rb'
require_relative 'bad_consequence.rb'
require_relative 'treasure_kind.rb'
require_relative 'monster.rb'
require_relative 'card_dealer.rb'
require_relative 'combat_result.rb'
require_relative 'dice.rb'
require_relative 'napakalaki.rb'
require_relative 'treasure.rb'
require_relative 'cultist_player.rb'

module Napakalaki
    require_relative 'napakalaki'

class Player
  attr_accessor :dead, :name, :level, :hiddenTreasures, :visibleTreasures, :pendingBadConsequence
 
  def initialize(name , dead = true , level = 1, hiddenTreasures = Array.new , visibleTreasures = Array.new)
      @dead = dead
      @name=name
      @level=level
      @pendingBadConsequence=nil
      @hiddenTreasures=hiddenTreasures
      @visibleTreasures=visibleTreasures
  end
    def shouldConvert
      dice = Dice.instance
      if dice.nextNumber == 6
        return true
      else 
        return false
      end
    end
    def bringToLife
      @dead=false
    end 
    def getHiddenTreasures()
        return hiddenTreasures
    end
    def getVisibleTreasures()
        return visibleTreasures
    end
    
    def getCombatLevel
      bonus = @level 
      if(howManyVisibleTreasures(NECKLACE)==1)
          for v in 0... @visibleTreasures.length 
                bonus += @visibleTreasures.at(v).maxBonus
          end
      else
          for v in 0... @visibleTreasures.length 
                bonus += @visibleTreasures.at(v).minBonus
          end
      end
      
      return bonus
    end
    def incrementLevels(i)
      if @level+i >= 10
        return @level=10
      else
         return @level+=i
      end
    end  
  
    def decrementLevels(i)
      numlevel=@level
      if numlevel-i >1
        return @level=numlevel-i
      else
        return @level=1
      end
    end
    def setPendingBadConsequence(b)
        @pendingBadConsequence = b
    end
    def dielfNoTreasures
        if @hiddenTreasures.size==0 && @visibleTreasures.size==0
              return @dead=true
        end
    end

    def discandNecklacelfVisible
        cd=CardDealer.instance
        i=0
        while i < @visibleTreasures.length do
          tipo=NECKLACE
          if @visibleTreasures[i].type.equal?(tipo) 
                cd.giveTreasureBack(@visibleTreasures.at(i));#pasa al mazo de descartes cardDealer
                @visibleTreasures.delete_at(i)
          end
          i+=1
        end
    end
   
    def die
      dealer = CardDealer.instance
      @level = 1
      for i in 0...@visibleTreasures.length 
          dealer.giveTreasureBack(@visibleTreasures.at(i))
      end
      @visibleTreasures.clear
      for i in 0...@hiddenTreasures.length 
          dealer.giveTreasureBack(@hiddenTreasures.at(i))
      end
      @hiddenTreasures.clear
      dielfNoTreasures
    end
    
    def computerGoldConinsValue(t= Array.new)
        buylevel=0
        for i in 0... t.length
            buylevel+=t[i].goldCoins 
        end
        return buylevel
    end
    
    def canIBuyLevels(i)
        return @level+i < 10
    end
    
    def applyPrize(m)
      nlevels = m.getLevelsGained
      incrementLevels(nlevels)
      nTreasures = m.getTreasuresGained
      if(nTreasures > 0)
          dealer = CardDealer.instance
          for i in 0...nTreasures
               @hiddenTreasures << dealer.nextTreasure
          end
      end
    end
    
    def applyBadConsequence(bad)
        nlevels = bad.levels
        @level=decrementLevels(nlevels)
        @pendingBadConsequence = bad.adjustToFitTreasureList(@visibleTreasures, @hiddenTreasures)
        setPendingBadConsequence(@pendingBadConsequence)
    end
    
    def canMakeTreasureVisible(t)
        encontrado=true
        if howManyVisibleTreasures(t.type) ==1 && t.type!=ONEHAND 
            encontrado=false
        elsif @visibleTreasures.size()==6#en el juego de Munckins existen cartas que puede que tengas otra mano
            encontrado=false              #pero según el guion el maximo seria 6   
        elsif howManyVisibleTreasures(BOTHHAND) == 1 && t.type==ONEHAND
            encontrado=false
        elsif howManyVisibleTreasures(ONEHAND)== 2 && t.type==ONEHAND
            encontrado=false
        elsif howManyVisibleTreasures(ONEHAND) > 0 && t.type==BOTHHAND
            encontrado=false  
        end
        return encontrado
        
    end
    
    def howManyVisibleTreasures(tKind)
        num=0
        for i in 0... @visibleTreasures.length 
              if @visibleTreasures.at(i).type==tKind
                  num+=1
              end
        end
        return num
    end
    def getOponentLevel(m)
      return m.getBasicValue
    end           
    def combat(monstruo)
      myLevel=getCombatLevel
      monster_level =getOponentLevel(monstruo)
      if myLevel > monster_level
        applyPrize(monstruo)
        if @level >=10
          combatResult = WINANDWINGAME
        else
          combatResult= WIN
        end
      else
        dice = Dice.instance
        escape= dice.nextNumber
         if escape<5
           amIDead=monstruo.kills
           if amIDead==true
              die
              combatResult=LOSEANDDIE
              if shouldConvert
                combatResult = LOSEANDCONVERT
              end
           else
              bad=monstruo.badConsequence
              combatResult=LOSE
              applyBadConsequence(bad)
           end
         else
              combatResult=LOSEANDESCAPE
         end
      end
      discandNecklacelfVisible
      return combatResult
    end
            
    def makeTreasureVisible(t)
        if canMakeTreasureVisible(t)
           @visibleTreasures << t
           @hiddenTreasures.delete(t)
        end
    end
    
    def discardVisibleTreasure(t)
        @visibleTreasures.delete(t);
        if @pendingBadConsequence!=nil && (@pendingBadConsequence.someSpecificVisiblesTreasures.size > 0 ||  @pendingBadConsequence.someVisiblesTreasures)
              @pendingBadConsequence.substractVisibleTreasure(t)
        end
        dielfNoTreasures
    end
            
    def discardHiddenTreasure(t= Array.new)
        @hiddenTreasures.delete(t);
        if @pendingBadConsequence!=nil && (@pendingBadConsequence.someSpecificHiddenTreasures.size > 0 || @pendingBadConsequence.someHiddenTreasures >0)
              @pendingBadConsequence.substractHiddenTreasure(t)
                 
        end
        dielfNoTreasures
    end
            
      
    
     def buyLevels(visible = Array.new, hidden = Array.new)
      levelsMayBought=0
      comprar = false
      levelsMayBought = computerGoldConinsValue(visible)
      levelsMayBought += computerGoldConinsValue(hidden)
      level= levelsMayBought/1000
      if canIBuyLevels(level)
          incrementLevels(level)
          comprar = true         
      end
        for i in 0... @visibleTreasures.length 
              enc=false
                  for j in 0... visible.length  
                      if visible.at(i)==@visibleTreasures.at(j) && enc==false
                          @visibleTreasures.delete_at(j)          
                          enc=true
                      end
                  end
        end
        for i in 0... @hiddenTreasures.length 
              enc=false
                  for j in 0... hidden.length  
                      if hidden.at(i)==@hiddenTreasures.at(j) && enc==false
                          @hiddenTreasures.delete_at(j)          
                          enc=true
                      end
                  end
        end
      dealer = CardDealer.instance
      for i in 0...visible.length 
        dealer.giveTreasureBack(visible.at(i))
      end
      for i in 0...hidden.size
        dealer.giveTreasureBack(hidden.at(i))
      end
      return comprar 
    end
            
    def validState
      return (@pendingBadConsequence==nil || @pendingBadConsequence.isEmpty == true ) && @hiddenTreasures.size <=4
    end
            
    def initTreasures()
      dealer = CardDealer.instance
      dice = Dice.instance
      bringToLife
      treasure = dealer.nextTreasure()
      @hiddenTreasures << treasure
      number = dice.nextNumber() 
      if number > 1
        treasure = dealer.nextTreasure()
        @hiddenTreasures << treasure
      end
      if number == 6
        treasure = dealer.nextTreasure()
        @hiddenTreasures << treasure
      end
    end      
    def hasVisibleTreasures
        return @visibleTreasures.length  > 0 
    end
    def to_s
      "\nJugador:
        \nNombre = #{@name}
        \nNivel = #{@level}
        \nNivel de combate = #{getCombatLevel()}"
       
    end
    
end
end
