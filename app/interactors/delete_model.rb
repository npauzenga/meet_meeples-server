class DeleteModel < StandardInteraction
  def validate_input
    context.fail!(errors: "invalid input") unless valid_input?
  end

  def execute
    context.model = context.active_record_class.destroy(context.id)
  end

  def validate_output
    context.fail!(errors: "model not deleted") unless context.model.destroyed?
  end

  private

  def valid_input?
    context.id && context.active_record_class
  end
end
