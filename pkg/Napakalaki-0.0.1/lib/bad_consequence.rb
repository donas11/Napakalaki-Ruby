#encoding: utf-8 
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require_relative 'prize.rb'
require_relative 'treasure_kind.rb'
require_relative 'monster.rb'
require_relative 'treasure.rb'
module Napakalaki
class BadConsequence
    attr_reader :text, :levels, :someVisiblesTreasures, :someHiddenTreasures, :someSpecificVisiblesTreasures, :someSpecificHiddenTreasures, :death
    
  def initialize(text, levels,someVisiblesTreasures,someHiddenTreasures,someSpecificVisiblesTreasures,someSpecificHiddenTreasures,death)
    @text = text
    @levels = levels
    @someVisiblesTreasures = someVisiblesTreasures
    @someHiddenTreasures = someHiddenTreasures
    @someSpecificVisiblesTreasures = Array.new(someSpecificVisiblesTreasures)
    @someSpecificHiddenTreasures = Array.new(someSpecificHiddenTreasures)
    @death = death
  end
  private_class_method :new
  def BadConsequence.newLevelNumberOfTreasures(aText,someLevels,someVisiblesTreasures,someHiddenTreasures)
    new(aText,someLevels,someVisiblesTreasures,someHiddenTreasures,Array.new,Array.new,false)
  end
  def BadConsequence.newLevelSpecificTreasures(aText, someLevels, someSpecificVisiblesTreasures, someSpecificHiddenTreasures)
    new(aText,someLevels,0,0,Array.new(someSpecificVisiblesTreasures),Array.new(someSpecificHiddenTreasures),false)
  end
  def BadConsequence.newDeath(aText, death)
    new(aText,0,0,0,Array.new,Array.new,true)
  end
  
  def to_s
    "
    - Consecuencia Negativa:  #{@text} 
    - Niveles que pierdes: #{@levels} 
    - Tesoros visibles: #{@someVisiblesTreasures} 
    - Tesoros ocultos:   #{@someHiddenTreasures}
    - Tesoros  visibles especificos que pierdes: #{@someSpecificVisiblesTreasures}
    - Tesoros  ocultos especificos que pierdes: #{@someSpecificHiddenTreasures} "
  
   
  end
  
  def isEmpty
    if @levels==0 && @someHiddenTreasures==0 && @someVisiblesTreasures==0 && @someSpecificHiddenTreasures.length==0 && @someSpecificVisiblesTreasures.length==0 && @death == false
            return true;
    else
            return false;
    end
  end
  
  def substractHiddenTreasure(t)
    if @someSpecificHiddenTreasures.size==0 && @someHiddenTreasures >0
            @someHiddenTreasures-=1;
    elsif @someSpecificHiddenTreasures.size==0 && @someHiddenTreasures == 0
            @someHiddenTreasures=0
    else
        for i in 0...@someSpecificHiddenTreasures.length        
            if @someSpecificHiddenTreasures.at(i)==t.type
                   @someSpecificHiddenTreasures.delete_at(i) 
            end
        end
    end  
  end
    
  def substractVisibleTreasure(t)
    if @someSpecificVisiblesTreasures.size==0 && @someVisiblesTreasures >0
            @someVisiblesTreasures-=1;
    elsif @someSpecificVisiblesTreasures.size==0 && @someVisiblesTreasures ==0        
            @someVisiblesTreasures=0
    else
            for i in 0...@someSpecificVisiblesTreasures.length       
               if @someSpecificVisiblesTreasures.at(i)==t.type
                        @someSpecificVisiblesTreasures.delete_at(i) 
               end
            end
    end
  end

  def adjustToFitTreasureList(v = Array.new,h = Array.new)
    @encontrado=false
    enc=false
    @VisiTre = Array.new
    @Hidetre = Array.new
    @H=Array.new(@someSpecificHiddenTreasures)
    i=0
    while i < v.length do
          tipo=NECKLACE
          if v.at(i).type.equal?(tipo) 
              @encontrado=true
          else
              @encontrado=false
          end
          i+=1
    end
    if  v.size==0 && h.size==0
            return @Vacio= BadConsequence.newLevelNumberOfTreasures("Mal rollo vacio",0,0,0)
    else
          @sht=@someHiddenTreasures
          @svt=@someVisiblesTreasures
        if @svt > 0  || @sht >0 
              if @sht >= h.size                  
                        @sht=h.size;
              end
              if @svt >=v.size && @encontrado==false
                        @svt=v.size;
              elsif (@svt>=v.size  && @encontrado==true && @svt>0) 
                        @svt=v.size-1;
              end
              return @Vacio= BadConsequence.newLevelNumberOfTreasures("Tesoros que descartar",0,@svt,@sht)
        else
            if @someSpecificHiddenTreasures.size>0 && @H.size>0 
                  for j in 0... h.length 
                        enc=false
                        for i in 0...  @H.length                         
                            if h[j].type==@H.at(i) && enc==false
                                @Hidetre<<h.at(j).type
                                @H.delete_at(i)
                                enc=true
                            end
                        end
                  end
            
            end          
            if @someSpecificVisiblesTreasures.size >0 && v.size >0
                  for j in 0... @someSpecificVisiblesTreasures.length
                        enc=false
                        for i in 0... v.length 
                            if v.at(i).type == @someSpecificVisiblesTreasures.at(j) && enc==false
                              @VisiTre<<v.at(i).type
                              enc=true
                            end
                        end
                  end
            
            end
            return @Vacio= BadConsequence.newLevelSpecificTreasures("Mal rollo pendiente", 0, @VisiTre, @Hidetre)
        end
    end
  end

  def myBadConsequeseIsDeath
      return @death
  end

end
end
