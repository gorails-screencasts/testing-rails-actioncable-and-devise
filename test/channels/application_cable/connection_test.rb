require "test_helper"

class ApplicationCable::ConnectionTest < ActionCable::Connection::TestCase
  # test "connects with cookies" do
  #   cookies.signed[:user_id] = 42
  #
  #   connect
  #
  #   assert_equal connection.user_id, "42"
  # end

  test "connects with devise" do
    user = users(:one)
    connect_with_user(user)
    assert_equal connection.current_user, user
  end

  test "unauthorized without devise" do
    assert_raises ActionCable::Connection::Authorization::UnauthorizedError do
      connect_with_user(nil)
    end
  end

  private

    def connect_with_user(user)
      connect env: { 'warden' => FakeEnv.new(user) }
    end

    class FakeEnv
      attr_reader :user

      def initialize(user)
        @user = user
      end
    end
end
