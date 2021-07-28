require 'rails_helper'

RSpec.describe Portfolio, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:start_date) }
end
