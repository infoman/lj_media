require 'spec_helper'

describe LJMedia::Author do
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
end
