class CreateModel < StandardInteraction
  def validate_input
    context.fail!(errors: "invalid input") unless valid_input?
  end

  def execute
    context.model = context.active_record_class.create(context.model_params)
  end

  def validate_output
    context.fail!(errors: context.model.errors) unless model_saved?
  end

  private

  def valid_input?
    context.model_params && context.active_record_class
  end

  def model_saved?
    context.model.persisted?
  end
end
