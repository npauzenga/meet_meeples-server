class AuthenticationController < ApplicationController
  include Knock::Authenticatable

  before_action :authenticate
end
