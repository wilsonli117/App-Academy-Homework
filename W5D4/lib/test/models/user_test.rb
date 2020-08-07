# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  user_name  :string
#  first_name :string
#  last_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'test_helper'

class UserNameTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
