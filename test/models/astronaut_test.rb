require "test_helper"

class AstronautTest < ActiveSupport::TestCase
  test "#name method" do
    astronaut = Astronaut.new(first_name: "John", last_name: "Doe")
    assert_equal "John Doe", astronaut.name
  end

  test "astronaut age validation" do
    astronaut = Astronaut.new(first_name: "John", last_name: "Doe", position: "Commander", country_code: "US")

    valid_astronaut = astronaut.tap { _1.age = "34" }
    assert astronaut.valid?, "Astronaut age should be between 20 and 60"

    invalid_astronaut = astronaut.tap { _1.age = "19" }
    assert_not astronaut.valid?, "Astronaut age should be between 20 and 60"
  end
end
