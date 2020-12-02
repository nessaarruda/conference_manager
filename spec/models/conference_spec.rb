require 'rails_helper'

describe Conference do
  describe 'validations' do
      it { should validate_presence_of :name}
      it { should validate_presence_of :organization}
      it { should validate_presence_of :start_date}
      it { should validate_presence_of :end_date}
  end
end
