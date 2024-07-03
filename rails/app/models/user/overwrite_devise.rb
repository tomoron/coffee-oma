module User::OverwriteDevise
  extend ActiveSupport::Concern

  class_methods do
    def send_reset_password_instructions(attributes = {})
      recoverable = find_or_initialize_with_errors(reset_password_keys, attributes, :not_registered_or_submitted)
      recoverable.send_reset_password_instructions if recoverable.persisted?
      recoverable
    end
  end
end
