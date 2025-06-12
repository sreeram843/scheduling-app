require 'faker'

puts "Cleaning up existing data..."
[ Communication, QualificationIdentifier, Qualification, Photo, Address, ContactInformation, Name, Credential, RecurringWorkHour, TimeException, Schedule, Practitioner ].each(&:delete_all)

puts "Seeding 50 practitioners..."
50.times do
  practitioner = Practitioner.create!(
    name: "#{Faker::Name.first_name} #{Faker::Name.last_name}",
    active: true,
    gender: %w[male female other unknown].sample,
    birth_date: Faker::Date.birthday(min_age: 25, max_age: 65),
    pronouns: %w[he/him she/her they/them].sample,
    status_reason: [ 'active', 'retired', 'sabbatical' ].sample,
    employment_type: [ 'full-time', 'part-time', 'contractor' ].sample,
    department: Faker::Educator.subject,
    nationality: Faker::Address.country,
    extensions: {
      legacy_id: Faker::Number.number(digits: 6),
      availability_notes: Faker::Lorem.sentence
    }
  )

  # Name
  practitioner.names.create!(
    use: 'official',
    prefix: [ Faker::Name.prefix ],
    given: [ Faker::Name.first_name ],
    family: Faker::Name.last_name,
    suffix: [ Faker::Name.suffix ]
  )

  # Credentials
  practitioner.credentials.create!(
    system: 'NPI',
    value: Faker::Number.number(digits: 10),
    use: 'official',
    credential_type: 'License'
  )

  # Contact Info
  practitioner.contact_informations.create!(
    system: 'phone',
    value: Faker::PhoneNumber.phone_number,
    use: 'work',
    rank: 1
  )

  practitioner.contact_informations.create!(
    system: 'email',
    value: Faker::Internet.email,
    use: 'home',
    rank: 2
  )

  # Address
  practitioner.addresses.create!(
    use: 'home',
    address_type: 'physical',
    line: [ Faker::Address.street_address ],
    city: Faker::Address.city,
    district: Faker::Address.community,
    state: Faker::Address.state,
    postal_code: Faker::Address.zip,
    country: Faker::Address.country
  )

  # Photo
  practitioner.photos.create!(
    url: Faker::Avatar.image,
    content_type: 'image/png',
    size: 12345,
    file_hash: SecureRandom.hex(8)
  )

  # Qualification
  qualification = practitioner.qualifications.create!(
    code: 'MD',
    start_date: Faker::Date.backward(days: 4000),
    end_date: Faker::Date.forward(days: 2000),
    issuer_name: Faker::University.name
  )

  qualification.qualification_identifiers.create!(
    system: 'License',
    value: Faker::Alphanumeric.alphanumeric(number: 8)
  )

  # Communication
  practitioner.communications.create!(
    language_code: %w[en es fr hi zh ar ru].sample,
    preferred: [ true, false ].sample
  )
end


puts "Seeding schedules and recurring work hours..."

Practitioner.find_each do |practitioner|
  availability_days = (Date.today..(Date.today + 89)).to_a.sample(45)
  unavailability_days = ((Date.today..(Date.today + 89)).to_a - availability_days).sample(20)

  availability_days.each do |date|
    schedule = practitioner.schedules.create!(
      category: "availability",
      event_type: "extra_working_hours",
      appointment_type: %w[initial ongoing flex].sample,
      start_date: date,
      end_date: date,
      start_time: date.to_datetime.change(hour: 9),
      end_time: date.to_datetime.change(hour: 17),
      timezone: "America/Chicago",
      enabled: true
    )

    3.times do |i|
      schedule.recurring_work_hours.create!(
        weekday: date.wday,
        start_time: "#{9 + i * 3}:00",
        end_time: "#{9 + (i + 1) * 3}:00",
        recurrence_rules: {
          frequency: "weekly",
          interval: 1,
          days_of_week: [ date.wday ],
          repeat_until: (date + 60).to_s
        },
        timezone: "America/Chicago"
      )
    end
  end

  unavailability_days.each do |date|
    practitioner.schedules.create!(
      category: "unavailability",
      event_type: "holiday",
      appointment_type: nil,
      start_date: date,
      end_date: date,
      start_time: date.to_datetime.change(hour: 0),
      end_time: date.to_datetime.change(hour: 23, min: 59),
      timezone: "America/Chicago",
      enabled: true
    )
  end
end

puts "✔ Schedules and recurring work hours seeded."

puts "Seeding complete!"
