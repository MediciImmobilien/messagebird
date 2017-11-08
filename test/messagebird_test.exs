defmodule MessagebirdTest do
  	use ExUnit.Case
  	doctest Messagebird
  	@valid_number "+4944452643"
	@invalid_number "string"

  	test "valid phonenumber" do
    	assert  Messagebird.valide_phonenumber?(@valid_number) == true
  	end
	
  	test "invalid phonenumber" do
    	assert  Messagebird.valide_phonenumber?(@invalid_number) == false
  	end
end
