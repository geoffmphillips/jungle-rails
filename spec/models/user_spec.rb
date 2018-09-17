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
      expect{@user.save}.to_not change {User.count}
    end

    it 'should be invalid when password is not minimum length of 5' do
      @user = User.new(first_name: "first", last_name: "last", email: "hahahahaha@gmail.com", password: "1234", password_confirmation: "1234")
      expect(@user).to_not be_valid
    end

  end
end
