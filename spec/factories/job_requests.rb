FactoryGirl.define do
  factory :job_request do
    analysis_type
    researcher
    samples "1 2-3 4,5, 435"
    project "Project X"
    comments "Some text"
  end
end