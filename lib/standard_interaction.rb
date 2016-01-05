class StandardInteraction
  include Interactor

  def call
    validate_input
    execute
    validate_output
  end

  def execute
  end

  def validate_input
  end

  def validate_output
  end
end
