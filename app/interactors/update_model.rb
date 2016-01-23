class UpdateModel < StandardInteraction
  def validate_input
    context.fail!(errors: "invalid input") unless valid_input?
  end

  def execute
    context.fail!(errors: "update failed") unless update_model
  end

  private

  def update_model
    context.active_record_class.update(context.id, context.model_params)
  end

  def valid_input?
    context.model_params && context.id && context.active_record_class
  end
end
