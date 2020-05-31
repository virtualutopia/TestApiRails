require 'rails_helper'

RSpec.describe Pokemon do
    describe "Name Validation" do
        it 'must be present' do
            pokemon = described_class.new
            expect(pokemon).to_not be_valid
            pokemon.Name = 'Taranauserause'
            expect(pokemon).to be_valid
        end
    end
end