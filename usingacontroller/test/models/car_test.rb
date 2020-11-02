require 'test_helper'

class CarTest < ActiveSupport::TestCase
  def setup
    @car = Car.create(make: 'Bmw', model: '114', year: 2020, kilometers: 20000, max_wheel_usage_before_change: 20000, max_trunk_space:500)
  end
  test "returns a full model name " do
    assert_equal @car.full_model, "Bmw 114 2020"
  end

  test "returns the available trunk space" do
    assert_equal @car.available_trunk_space, 500
  end

  test "returns the kilometers wheel change" do
    assert_equal @car.kilometers_before_wheel_change, 20000
  end

  test "verify the correct available trunk" do
    @car.update(current_trunk_usage: 100)
    assert_equal  @car.available_trunk_space, 400
  end

  test "verify the correct kilometers wheel after change" do
    @car.update(current_wheel_usage: 10000)
    assert_equal  @car.kilometers_before_wheel_change, 10000
  end

  test "returns if equal for save the current trunk usage" do
    @car.store_in_trunk(40)
    assert_equal  @car.current_trunk_usage, 40
  end

  test "returns error when the current trunk usage exced the limit" do
   
    assert_raise RuntimeError do
      @car.store_in_trunk(5000)
    end
  end

  test "returns status of wheel" do
    @car.update(current_wheel_usage: 120000)
    assert_equal  @car.wheel_usage_status, 'Please change your wheels'
  end


  test "returns status error when is not you should change the wheels" do
    @car.update(current_wheel_usage: 600)
    assert_equal  @car.wheel_usage_status, 'Wheels are OK, you can keep using them'
  end
end