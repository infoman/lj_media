module LJMedia

  # This module contains variuos error classes raised by our methods
  module Error

    # Raises when the provided LiveJournal username is invalid
    class InvalidUsername < RuntimeError

      # Exact username that caused this error
      attr_reader :username

      # Initializes the exception object with a username
      def initialize(username)
        @username = username
        super "#{username} is not a valid LiveJournal username"
      end
    end
  end
end
