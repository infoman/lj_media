require 'uri'
require "faraday"
require "feedjira"
require "contracts"
require "lj_media/version"
require "lj_media/errors"
require "lj_media/post"
require "lj_media/journal_parser"
require "lj_media/journal"

# See {LJMedia::Journal} and other classes in this module for documentation
# and examples
module LJMedia
  include Contracts

  # Fetches raw page from specified URI
  #
  # Sends a cookie to ensure that the english page version will be returned
  # in case if this makes sense, then fetches the page and returns
  # it's content.
  #
  # @param url page to fetch
  # @return page content
  # @api private
  Contract Or[String, URI::Generic] => String
  def self.fetch(url)
    conn = Faraday.new(url, headers: {'Cookie' => "langpref=en_LJ/#{Time.now.to_i}"})
    conn.get.body
  end
end
