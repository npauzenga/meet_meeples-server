class CreatePasswordResetOrganizer
  include Interactor::Organizer

  organize FindUserByEmail,
           CreatePasswordResetToken,
           SendPasswordResetEmail
end
