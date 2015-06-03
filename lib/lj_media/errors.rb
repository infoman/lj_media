require 'contracts'

module LJMedia

  # This module contains variuos error classes raised by our methods
  module Error

    # Raises when the provided LiveJournal username is invalid
    #
    # Examples
    #
    #   begin
    #     username = 'fa-' + '-il' # Generated somewhere or received from user input
    #     journal = LJMedia::Journal.new(username)
    #   rescue LJMedia::Error::InvalidUsername => e
    #     puts e.username #=> fa--il
    #   end
    class InvalidUsername < RuntimeError
      include Contracts

      # Exact username that caused this error
      attr_reader :username

      # Initializes the exception object with a username
      Contract String => Any
      def initialize(username)
        @username = username
        super "#{username} is not a valid LiveJournal username"
      end
    end
  end
end
