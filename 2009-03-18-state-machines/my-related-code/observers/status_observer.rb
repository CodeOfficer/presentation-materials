class StatusObserver < ActiveRecord::Observer
  
  observe :affiliate, :affiliation, :course, :classified, :job, :service
    
  def before_transition(object, transition)      
    s = StatusTransition.new do |t|
      t.actor = object.current_user
      t.subject = transition.object
      t.event = transition.to_name.to_s
    end
    s.save!
  end

end
