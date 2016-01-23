class ShowModel < StandardInteraction
  def validate_input
    context.fail!(errors: "invalid input") unless valid_input?
  end

  def execute
    context.model = context.active_record_class.find(context.id)
  end

  private

  def valid_input?
    context.id && context.active_record_class
  end
end
