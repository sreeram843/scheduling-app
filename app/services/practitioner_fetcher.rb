# app/services/practitioner_fetcher.rb
class PractitionerFetcher
  def self.full_details(practitioner)
    {
      id: practitioner.id,
      name: practitioner.name,
      active: practitioner.active,
      gender: practitioner.gender,
      birth_date: practitioner.birth_date,
      pronouns: practitioner.pronouns,
      employment_type: practitioner.employment_type,
      contact: practitioner.contact_informations.map(&:attributes),
      addresses: practitioner.addresses.map(&:attributes),
      credentials: practitioner.credentials.map(&:attributes),
      qualifications: practitioner.qualifications.map do |q|
        q.attributes.merge(identifiers: q.qualification_identifiers.map(&:attributes))
      end,
      communications: practitioner.communications.map(&:attributes),
      photos: practitioner.photos.map(&:attributes)
    }
  end
end
