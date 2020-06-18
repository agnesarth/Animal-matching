module ApplicationHelper
  def bootstrap_class_for_flash(type)
    case type
      when 'notice' then "alert-info"
      when 'success' then "alert-success"
      when 'error' then "alert-danger"
      when 'alert' then "alert-warning"
    end
  end

  def gravatar_for(user, opts = {})
    opts[:alt] = user.name
    image_tag "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email)}?s=#{opts.delete(:size) { 40 }}",
              opts
  end

  def current_pet
    return Pet.find(current_user.default_pet_id)
  end

  def any_match?
    return Like.where(match: true,liker_id: current_pet.id).exists?
  end

  def my_pets_matches
    matches = Like.where(match: true,liker_id: current_pet.id)
    matched_pets = []
    matches.each do |matching|
      matched_pets << matching.liked
    end 
    return matched_pets
  end

  def other_user_match(other_user)
    other_pets = []
    other_user.pets.each do |p|
      my_like = Like.where(match: true, liker_id: current_user.default_pet_id, liked_id: p.id)
      if !my_like.first.nil?
        other_pets << p.name
      end
    end
    return other_pets
  end

end
