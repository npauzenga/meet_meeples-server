class CheckTokenExpiration
  include Interactor

  def call
    validate_input
    execute
  end

  private

  def validate_input
    context.fail!(errors: "invalid token") unless context.sent_at
  end

  def execute
    context.fail!(errors: "token expired") if token_expired?
  end

  def token_expired?
    context.sent_at < 1.day.ago
  end
end
