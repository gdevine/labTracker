FactoryGirl.define do
  
  factory :analysis_type do
    sequence(:name) {|n| "Analysis Type" + " (#{n})"}
    instrument "Instrument X"
    description "A description of this analysis type"
    before(:create) do |analysis_type|
      analysis_type.technicians << FactoryGirl.create(:technician)
    end
  end

end
