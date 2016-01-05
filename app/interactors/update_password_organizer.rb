class UpdatePasswordOrganizer
  include Interactor::Organizer

  organize FindUserByResetToken,
           CheckTokenExpiration,
           UpdatePassword
end
