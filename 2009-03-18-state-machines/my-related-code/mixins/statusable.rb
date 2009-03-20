module Statusable

  def self.included(base)
    base.send :include, InstanceMethods
    base.has_many :status_transitions, :as => :subject
  end
  
  module InstanceMethods
    
    def available_status_events
      self.class.state_machines[:status].events.select{|n| n.can_fire?(self)}
    end
  
    def available_statuses
      self.class.state_machines[:status].events.select{|n| n.can_fire?(self) }.map{|s|s.name}
    end
    
  end
  
end