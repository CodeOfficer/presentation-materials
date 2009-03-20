# == Schema Information
# Schema version: 20090315094525
#
# Table name: classifieds
#
#  id               :integer(4)      not null, primary key
#  owner_id         :integer(4)      
#  owner_type       :string(255)     
#  status           :string(255)     

class Classified < ActiveRecord::Base

# includes ---------------------------------------------------------------------

  include Listable  
  include Statusable

end
