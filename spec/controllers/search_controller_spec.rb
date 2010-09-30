require 'spec_helper'

describe SearchController do
  
  describe "GET search" do
    it "search with valid search params"do
      post :search, {}
    end
  end
  
  
  def params
    {
      
    }
  end
end