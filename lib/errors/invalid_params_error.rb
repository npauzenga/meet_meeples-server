class InvalidParamsError < Error
  attr_accessor :title, :code, :details

  def initialize
    @title = "Invalid Params"
    @code = :invalid_params
    @details = "One or more of the parameters was missing or failed valiation."
  end
end
