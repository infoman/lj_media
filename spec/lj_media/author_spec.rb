require 'spec_helper'

describe LJMedia::Author do
  before(:context) do
    @local    = LJMedia::Author.new(15140396)
    @external = LJMedia::Author.new(33479568)
  end

  describe '#new' do
    it 'must accept initialization by user id only and get username from profile page' do
      a = nil
      expect(a = LJMedia::Author.new(33479568)).to be_an LJMedia::Author
      expect(a.username).to be_a String
      expect(a.username).to eq('ext_384967')
    end

    it 'must accept initialization by user id and username' do
      a = nil
      expect(a = LJMedia::Author.new(15140396)).to be_an LJMedia::Author
      expect(a.username).to be_a String
      expect(a.username).to eq('v_glaza_smotri')
    end

    it 'must take already parsed info from cache instead of reloading profile page from server' do
      a = nil
      b = nil

      expect(a = LJMedia::Author.new(73993180)).to be_an LJMedia::Author
      expect(b = LJMedia::Author.new(73993180, 'wrong_username')).to be_an LJMedia::Author
      expect(b.username).to_not eq('wrong_username')
      expect(b.username).to eq(a.username)
    end
  end

  describe '#type' do
    it 'must be :local for LiveJournal accounts' do
      expect(@local.type).to be(:local)
    end

    it 'must be :identity for external accounts' do
      expect(@external.type).to be(:identity)
    end
  end

  describe '#username' do
    it 'must have a String value' do
      expect(@local.username).to    be_a(String)
      expect(@external.username).to be_a(String)
    end
  end

  describe '#profile_name' do
    it 'must have a String value' do
      expect(@local.profile_name).to    be_a(String)
      expect(@external.profile_name).to be_a(String)
    end
  end

  describe '#profile_url' do
    it 'must have a value of URI::Generic or its subclasses' do
      expect(@local.profile_url).to    be_a(URI::Generic)
      expect(@external.profile_url).to be_a(URI::Generic)
    end

    it 'must be a correct link to the user\'s page' do
      expect(@local.profile_url.scheme).to be_a(String)
      expect(@local.profile_url.host).to   be_a(String)
      expect(@local.profile_url.host).to   end_with('.livejournal.com')

      expect(@external.profile_url.scheme).to   be_a(String)
      expect(@external.profile_url.host).to     be_a(String)
      expect(@external.profile_url.host).not_to end_with('.livejournal.com')
    end
  end
end
