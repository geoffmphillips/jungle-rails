require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should be valid when all fields included' do
      @user = User.new(first_name: "first", last_name: "last", email: "hheheh@gmail.com", password: "12345", password_confirmation: "12345")
      expect(@user).to be_valid
    end

    it 'should be invalid without password_confirmation' do
      @user = User.new(first_name: "first", last_name: "last", email: "hheheh@gmail.com", password: "12345", password_confirmation: nil)
      expect(@user).to_not be_valid
    end

    it 'should be invalid when password and password_confirmation do not match' do
      @user = User.new(first_name: "first", last_name: "last", email: "hheheh@gmail.com", password: "12345", password_confirmation: "ABCDE")
      expect(@user).to_not be_valid
    end

    it 'should be invalid when first_name is not provided' do
      @user = User.new(first_name: nil, last_name: "last", email: "hheheh@gmail.com", password: "12345", password_confirmation: "ABCDE")
      expect(@user).to_not be_valid
    end

    it 'should be invalid when last_name is not provided' do
      @user = User.new(first_name: "first", last_name: nil, email: "hheheh@gmail.com", password: "12345", password_confirmation: "ABCDE")
      expect(@user).to_not be_valid
    end

    it 'should be invalid when email is not provided' do
      @user = User.new(first_name: "first", last_name: "last", email: nil, password: "12345", password_confirmation: "ABCDE")
      expect(@user).to_not be_valid
    end

    it 'should be invalid when email already exists in database, case insensitive' do
      @email = "TeSt@tEsT.tESt".downcase
      @user = User.new(first_name: "first", last_name: "last", email: @email, password: "12345", password_confirmation: "12345")
      @user.save
      @user2 = User.new(first_name: "first", last_name: "last", email: @email, password: "12345", password_confirmation: "12345")
      expect{@user2.save}.to_not change {User.count}
    end

    it 'should be invalid when password is not minimum length of 5' do
      @user = User.new(first_name: "first", last_name: "last", email: "hahahahaha@gmail.com", password: "1234", password_confirmation: "1234")
      expect(@user).to_not be_valid
    end

  end

  describe '.authenticate_with_credentials' do
    it 'should be truthy when logging in with correct credentials' do
      @user = User.new(first_name: "first", last_name: "last", email: "geoff@geoff.geoff", password: "12345", password_confirmation: "12345")
      @user.save
      @params = { email: 'geoff@geoff.geoff', password: '12345' }
      expect(User.authenticate_with_credentials(@params)).to be_truthy
    end

    it 'should be falsey when attempting to log in with incorrect credentials' do
      @user = User.new(first_name: "first", last_name: "last", email: "geoff@geoff.geoff", password: "12345", password_confirmation: "12345")
      @user.save
      @params = { email: 'geoff@geoff.geoff', password: 'ABCDE' }
      expect(User.authenticate_with_credentials(@params)).to be_falsey
    end

    it 'should be truthy when logging in using email with whitespace' do
      @user = User.new(first_name: "first", last_name: "last", email: "geoff@geoff.geoff", password: "12345", password_confirmation: "12345")
      @user.save
      @email = "     geoff@geoff.geoff     ".strip
      @params = { email: @email, password: '12345' }
      expect(User.authenticate_with_credentials(@params)).to be_truthy
    end

    it 'should be truthy when email inputted with uppercase characters - authentication should be case insensitive' do
      @user = User.new(first_name: "first", last_name: "last", email: "geoff@geoff.geoff", password: "12345", password_confirmation: "12345")
      @user.save
      @email = "GeOfF@gEoFf.GeOfF".downcase
      @params = { email: @email, password: '12345' }
      expect(User.authenticate_with_credentials(@params)).to be_truthy
    end
  end
end
