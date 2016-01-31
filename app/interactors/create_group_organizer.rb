class CreateGroupOrganizer
  include Interactor::Organizer

  organize CreateGroup, AddRoleToUser
end
