# app/serializers/practitioner_serializer.rb
class PractitionerSerializer
  def initialize(practitioner)
    @practitioner = practitioner
  end

  def as_json
    PractitionerFetcher.full_details(@practitioner)
  end
end
