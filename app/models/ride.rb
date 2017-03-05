class Ride < ActiveRecord::Base
  belongs_to :user
  belongs_to :attraction

  def take_ride
    if meets_requirements
      update_user
      "Thanks for riding the #{self.attraction.name}!"
    elsif too_short && too_few_tickets
      "Sorry. You do not have enough tickets to ride the #{self.attraction.name}. You are not tall enough to ride the #{self.attraction.name}."
    elsif too_few_tickets
      "Sorry. You do not have enough tickets to ride the #{self.attraction.name}."
    elsif too_short
      "Sorry. You are not tall enough to ride the #{self.attraction.name}."
    end
  end

  def meets_requirements
    self.user.tickets >= self.attraction.tickets && self.user.height >= self.attraction.min_height
  end

  def too_short
    !(self.user.height >= self.attraction.min_height)
  end

  def too_few_tickets
    !(self.user.tickets >= self.attraction.tickets)
  end

  def update_user
    self.user.update(
      tickets: (self.user.tickets -= self.attraction.tickets),
      nausea: (self.user.nausea += self.attraction.nausea_rating),
      happiness: (self.user.happiness += self.attraction.happiness_rating)
    )
  end
end
