#!/usr/bin/env ruby

$LOAD_PATH << './state_machine/lib'

require 'rubygems'
require 'commander'
require 'state_machine'

#  -----------------------------------------------------------------------------

class HondaCBR600F4i
  
  def initialize
    @speed = 0
    super
  end
  
  state_machine :initial => :parked do
    event :park do
      transition [:idling, :first_gear] => :parked
    end
    
    event :ignite do
      transition :stalled => same, :parked => :idling
    end
    
    event :idle do
      transition :first_gear => :idling
    end
    
    event :shift_up do
      transition :idling => :first_gear, :first_gear => :second_gear, :second_gear => :third_gear
    end
    
    event :shift_down do
      transition :third_gear => :second_gear, :second_gear => :first_gear
    end
    
    event :crash do
      transition [:first_gear, :second_gear, :third_gear] => :stalled
    end
    
    event :repair do
      transition :stalled => :parked
    end

    state :parked, :idling, :stalled do
      def speed; 0; end
    end

    state :first_gear do
      def speed; 30; end
    end

    state :second_gear do
      def speed; 60; end
    end

    state :third_gear do
      def speed; 90; end
    end
  end
end

#  -----------------------------------------------------------------------------

program :name, 'Vehicle State Machine Demo'
program :version, '1.0.0'
program :description, 'Stupid stuff =)'
default_command :game_on

command :game_on do |c|
  c.when_called do |args, options|
    bike = HondaCBR600F4i.new
    
    while(true) do
      choice = choose *(bike.state_events << "-quit!")
      break if choice == "-quit!"
      eval "bike.#{choice}!"
      say "\n"
      say "Your vehicle state is now #{bike.state} traveling #{bike.speed}"
    end
    
  end
end
