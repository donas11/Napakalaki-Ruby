# encoding: utf-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require'singleton'
require_relative 'prize'
require_relative 'bad_consequence'
require_relative 'treasure_kind'
require_relative 'monster'
require_relative 'card_dealer'
require_relative 'combat_result'
require_relative 'dice'
require_relative 'player'
require_relative 'treasure'
module Napakalaki

class Napakalaki
  
  include Singleton
 
    attr_accessor :currentPlayer, :players, :dealer, :currentMonster
     
    def initialize
      @currentPlayer = nil
      @players = Array.new
      @dealer = CardDealer.instance
      @currentMonster = nil
    end
    
    def getCurrentPlayer()
      return @currentPlayer
    end
    
    def getCurrentMonster()
      return @currentMonster
    end
     
    def initPlayers(names = Array.new)
      for i in 0...names.length
         @players << Player.new(names.at(i))
       end
    end
     
    def nextPlayer
        if(@CurrentPlayer==nil)
              indice=rand(@players.length)
              @CurrentPlayer=players.at(indice)
        else
            i=0
            while i < @players.length
              if @players.at(i).eql?(@currentPlayer)
                    indice=i
              end
                    i+=1
            end
             if indice== @players.length-1
                 @CurrentPlayer=@players.at(0)
             end
             if indice != @players.length-1
                 @CurrentPlayer=@players.at(indice+1)
             end
        end       
        return @CurrentPlayer
    end
     
    def nextTurnAllowed()
      if @currentPlayer==nil
          return true
      else
        @currentPlayer.validState
      end
    end
     
    def developCombat()
       
        @combat = @currentPlayer.combat(@currentMonster)
        @dealer.giveMonsterBack(@currentMonster)
        if @combat == LOSEANDCONVERT
          cultist = @dealer.nextCultist()
          cultistPlayer = CultistPlayer.new(@currentPlayer, cultist)
          i=0
          while i< @players.length
            if @players.at(i).eql?(@currentPlayer)
              @players[i]=cultistPlayer
            end
            i+=1
          end
          @currentPlayer = cultistPlayer
        end
        return @combat
    end
     
    def discardVisibleTreasures(treasures = Array.new)
      for i in 0..treasures.length
        @currentPlayer.discardVisibleTreasure(treasures[i])
        @dealer.giveTreasureBack(treasures[i])
      end
    end
     
    def discardHiddenTreasures(treasures = Array.new )
      for i in 0...treasures.length
        @currentPlayer.discardHiddenTreasure(treasures[i])
        @dealer.giveTreasureBack(treasures[i])
      end
    end
     
    def makeTreasuresVisible(treasures = Array.new)
        for i in 0...treasures.length
          @currentPlayer.makeTreasureVisible(treasures[i])
        end
    end
     
    def buyLevels(visible = Array.new , hidden = Array.new )
      return @currentPlayer.buyLevels(visible, hidden)
    end
     
    def initGame(players = Array.new )
      initPlayers(players)
      @dealer.initCards()
      nextTurn()
    end
             
    def nextTurn()
        stateOK = false
        stateOK = nextTurnAllowed()
      
      if (stateOK)
          @currentMonster = dealer.nextMonster()
          @currentPlayer = nextPlayer()
          dead = @currentPlayer.dead
          if (dead)
              @currentPlayer.initTreasures()
          end
      end
      return stateOK
    end
     
    def endOfGame(result)
      if (result == WINANDWINGAME)
        return true
      else
        return false
    end
     
    def to_s
      "\nNapakalaki:
      \nJugadores = #{@players}
      \nRepartidor: #{@dealer}
      \nMonstruo Actual: #{@currentMonster}
      \nJugador Actual: #{@currentPlayer}"
    end
  end
end
end
