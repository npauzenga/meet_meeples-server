class AuthenticationController < ApplicationController
  include Knock::Authenticable

  before_action :authenticate
end
