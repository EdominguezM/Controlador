require 'rails_helper'

RSpec.describe Car, type: :model do
  describe 'Car model spec' do
    let(:car) do
      Car.create(make: 'Toyota', model: 'Yaris', year: 2019,
                 kilometers: 1000, max_wheel_usage_before_change: 12000,
                 max_trunk_space: 100)
    end
    context 'basic methods' do
      it 'should return basic model info' do
        expect(car.make).to eq 'Toyota'
        expect(car.model).to eq 'Yaris'
      end
    end
  end

  describe 'Car methods' do
    let(:car) do
      Car.create(make: 'Toyota', model: 'Yaris', year: 2019,
                 kilometers: 1000, max_wheel_usage_before_change: 12000,
                 max_trunk_space: 100)
    end
    context 'full modell' do
      it 'returns a full model name' do
        expect(car.full_model).to eq 'Toyota Yaris 2019'
      end
    end

    context 'available trunk space' do
      it 'returns the vailable trunk space' do
        expect(car.available_trunk_space).to eq 100
        car.update(current_trunk_usage: 50)
        expect(car.available_trunk_space).to eq 50
      end
    end

    context 'store methods' do
      it 'returns kilometers wheel change' do
        expect(car.kilometers_before_wheel_change).to eq 12000
        car.update(current_wheel_usage: 10000)
        expect(car.kilometers_before_wheel_change).to eq 2000
      end

      it 'returns kilometers wheel change' do
        expect{car.store_in_trunk(5000)}.to raise_error(RuntimeError)
      end
    end


    
  end
end
