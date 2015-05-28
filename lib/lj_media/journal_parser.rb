require 'sax-machine'
require 'feedjira'
require 'lj_media/post'

module LJMedia

  # Internal: Feedjira parser for LJ \Journal feed. Not intended for direct #
  # creation or calling. Use LJMedia::Journal class for this.
  class JournalParser
    include SAXMachine
    include Feedjira::FeedUtilities

    ##
    # Public: \Journal ID as reported by LiveJournal
    # :attr_reader: id
    element  :"lj:journalid",   as: :id,        class: Integer

    ##
    # Public: \Journal type. Can be +personal+ or +community+
    # :attr_reader: type
    element  :"lj:journaltype", as: :type

    ##
    # Public: \Journal name
    # :attr_reader: name
    element  :"lj:journal",     as: :name

    ##
    # Public: \Journal name
    # :attr_reader: name
    element  :title

    ##
    # Public: \Journal description set by it's author
    # :attr_reader: description
    element  :description

    ##
    # Public: Link to this journal
    # :attr_reader: link
    element  :link

    ##
    # Public: \Journal last updated date
    # :attr_reader: published
    element  :lastBuildDate,    as: :published

    ##
    # Public: Array of LJMedia::Post entries parsed from journal's feed
    # :attr_reader: posts
    elements :item,             as: :posts,     class: Post
  end
end
