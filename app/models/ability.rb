class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    elsif user.member?
      can [:read, :update, :delete], User, id: user.id
      can :manage, Category, user: {id: user.id}
      can :manage, Post, category: {user: {id: user.id}}
      can :manage, Image
    else
      can :read, [User, Category, Post]
    end

  end
end
