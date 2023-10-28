require 'rails_helper'

RSpec.describe User, type: :model do
  # Associations
  it { should have_many(:foods).dependent(:destroy) }
  it { should have_many(:recipes) }

  # Devise tests (basic)
  describe 'Devise modules' do
    it 'should have :database_authenticatable module' do
      expect(User.devise_modules).to include(:database_authenticatable)
    end

    it 'should have :registerable module' do
      expect(User.devise_modules).to include(:registerable)
    end

    it 'should have :recoverable module' do
      expect(User.devise_modules).to include(:recoverable)
    end

    it 'should have :rememberable module' do
      expect(User.devise_modules).to include(:rememberable)
    end

    it 'should have :validatable module' do
      expect(User.devise_modules).to include(:validatable)
    end

    it 'should have :confirmable module' do
      expect(User.devise_modules).to include(:confirmable)
    end
  end

  # Additional tests for custom methods or logic in User can be added as needed.
end
