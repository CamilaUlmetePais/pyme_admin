require 'rails_helper'

RSpec.describe Reminder, type: :model do
  describe "validations" do
		it { should validate_presence_of(:title) }
    it { should validate_presence_of(:due_date) }  
  end 

  describe ".due_date_cannot_be_in_the_past" do
    it "fails if due_date is in the past" do
      expect(Reminder.create(title:"test", due_date: DateTime.now - 10.days)).not_to be_valid
    end

    it "validates that due_date isn't in the past" do
      expect(Reminder.create(title:"test", due_date: DateTime.now + 10.days)).to be_valid
    end
  end
end
