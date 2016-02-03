class IndexProfile < StandardInteraction
  def execute
    context.profiles = User.all
  end

  def validate_output
    context.fail!(errors: "internal server error") unless context.profiles
  end
end
