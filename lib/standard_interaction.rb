class StandardInteraction
  include Interactor

  def call
    validate_input
    execute
    validate_output
  end

  def execute
  end

  def validate_input(input: expected_arguments)
    context.fail!(errors: input_error) unless context.send(input)
  end

  def validate_output
  end

  def input_error
    { "#{self.class.name}": "invalid Interactor input" }
  end
end
