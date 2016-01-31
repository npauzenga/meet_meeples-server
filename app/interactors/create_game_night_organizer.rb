class CreateGameNightOrganizer
  include Interactor::Organizer

  organize CreateGameNight, AddRoleToUser
end
