
require 'rails_helper'

RSpec.describe Car, type: :model do
  describe "validations" do
    it { should belong_to(:user) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:model) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:photo) }
  end

    describe "test for car inputs" do 
        before :each do 
            @user = User.create(username: 'Obi', password: '12345678')
            @car = Car.create(
                name: "Civic",
                description: "Civic has good engine cappacity",
                photo: "https://images.hgmsites.net/lrg/2020-honda-civic-sport-manual-angular-front-exterior-view_100751892_l.jpg",
                price: 1000,
                model: 2020,
                user_id: @user.id
            )
        end
        it "should test car name to be presence" do 
            expect(@car.name).to eq "Civic"
        end
        it  "should create an instance of car price" do
            expect(@car.price).to eq 1000
        end
        it "should create the model" do 
            expect(@car.model).to eq "2020"
        end 
    end
end
