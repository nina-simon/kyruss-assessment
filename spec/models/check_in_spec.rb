require 'rails_helper'

RSpec.describe CheckIn, type: :model do
  it { should validate_presence_of :patient_id }
end
