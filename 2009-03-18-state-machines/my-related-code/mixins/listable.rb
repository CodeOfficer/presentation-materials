module Listable

  def self.included(base)
    base.send :include, InstanceMethods
    base.class_eval do
      
      # relationships ----------------------------------------------------------
      
        belongs_to :owner, :polymorphic => true
      
      # callbacks --------------------------------------------------------------
      
        before_validation_on_create :assign_polymorphic_owner
      
      # attributes -------------------------------------------------------------
      
        attr_protected :owner_id
        attr_protected :owner_type
      
      # virtual attributes -----------------------------------------------------
      
        attr_accessor :affiliate_id 
        attr_accessor :current_user
      
      # validations ------------------------------------------------------------
      
        validates_presence_of :current_user
    
      # state machines ---------------------------------------------------------
      
        state_machine :status, :initial =>:approved do
          after_transition :to => :destroyed  do  |listing, transition|
            listing.destroy_feature_if_featured!
          end
          
          event :approve do
            transition :to => :approved, :from => [:unapproved]
          end
          event :destroy do
            transition :to => :destroyed, :from => [:approved, :unapproved]
          end
          event :recover do
            transition :to => :approved, :from => [:destroyed]
          end
          event :spam do
            transition :to => :unapproved, :from => [:approved]
          end
        end
        
    end
  end
  
  module InstanceMethods
    
    def destroy_feature_if_featured!
      feature.destroy unless feature.nil?
    end
    
    # owner stuff --------------------------------------------------------------
    
      def assign_polymorphic_owner
        unless affiliate_id.blank?
          self.owner = current_user.affiliates.find(affiliate_id) 
        else
          self.owner = current_user
        end
      end
    
      def owned_by_user?
        owner.is_a? User
      end
    
      def owned_by_affiliate?
        owner.is_a? Affiliate
      end
    
      def owner_name
        owned_by_user? ? owner.full_name : owner.name
      end
    
  end
  
end