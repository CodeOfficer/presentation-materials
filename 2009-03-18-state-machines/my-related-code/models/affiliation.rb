# == Schema Information
# Schema version: 20090315094525
#
# Table name: affiliations
#
#  id           :integer(4)      not null, primary key
#  affiliate_id :integer(4)      not null
#  user_id      :integer(4)      not null
#  status       :string(255)     

class Affiliation < ActiveRecord::Base
  
# includes ---------------------------------------------------------------------
  
  include Statusable
  
# relationships ----------------------------------------------------------------
  
  belongs_to :affiliate
  belongs_to :user

# virtual attributes -----------------------------------------------------------

  attr_accessor :current_user
  
# validations ------------------------------------------------------------------
  
  validates_presence_of :affiliate_id, :user_id
  validates_uniqueness_of :user_id, :scope => [:affiliate_id]
  
# state machines ---------------------------------------------------------------
  
  state_machine :status, :initial => lambda {|thing| thing.should_auto_approve? ? :approved : :unapproved} do
    event :approve do
      transition :to => :approved, :from => [:unapproved, :destroyed]
    end
    event :destroy do
      transition :to => :destroyed, :from => [:unapproved, :approved]
    end
  end
  
# misc -------------------------------------------------------------------------

  def should_auto_approve?
    user.try(:has_role?, 'admin') || current_user.try(:has_role?, 'admin')
  end
  
end
