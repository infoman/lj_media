module LJMedia

  # This module contains variuos error classes raised by our methods
  module Error

    # Raises when the provided LiveJournal username is invalid
    class InvalidUsername < RuntimeError
    end
  end
end
