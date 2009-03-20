# == Schema Information
# Schema version: 20090315094525
#
# Table name: affiliates
#
#  id               :integer(4)      not null, primary key
#  name             :string(255)     
#  status           :string(255)    


class Affiliate < ActiveRecord::Base
  
# includes ---------------------------------------------------------------------
  
  include Statusable
  
# relationships --------------------------------------------------------------
  
  has_many :affiliations
  has_many :users, :through => :affiliations
  
# virtual attributes -----------------------------------------------------------
  
  attr_accessor :current_user
  
# state machines ---------------------------------------------------------------
  
  state_machine :status, :initial => lambda {|thing| thing.should_auto_approve? ? :approved : :unapproved} do
    after_transition :from => :unapproved, :to => :approved do  |affiliate, transition|
      affiliate.affiliations.each do |a| 
        a.current_user = affiliate.current_user
        a.approve!
      end
    end
    
    after_transition :to => :destroyed  do  |affiliate, transition|
      affiliate.affiliations.each do |a| 
        a.current_user = affiliate.current_user
        a.destroy!
      end
    end
    
    event :approve do
      transition :to => :approved, :from => [:unapproved]
    end
    event :destroy do
      transition :to => :destroyed, :from => [:unapproved, :approved]
    end
    event :recover do
      transition :to => :approved, :from => [:destroyed]
    end
  end

# misc -------------------------------------------------------------------------
  
  def should_auto_approve?
    current_user.try(:has_role?, 'admin')
  end
  
end
