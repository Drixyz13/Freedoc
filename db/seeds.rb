require 'faker'
#Tu fais un rails db:drop db:create db:migrate db:seed
#👉 Cela permet de repartir d’une base propre, reconstruite et peuplée automatiquement.
puts "🌪️ Nettoyage de la base..."
DoctorSpecialty.destroy_all
Appointment.destroy_all
Doctor.destroy_all
Patient.destroy_all
Specialty.destroy_all
City.destroy_all

puts "🏙️ Création des villes..."
cities = 5.times.map do
  City.create!(name: Faker::Address.city, zip_code: Faker::Address.zip_code)
end

puts "🧠 Création des spécialités..."
specialties = ["Cardiologie", "Dermatologie", "Pédiatrie", "Ophtalmologie", "Psychiatrie"].map do |name|
  Specialty.create!(name: name)
end

puts "👨‍⚕️ Création des docteurs..."
doctors = 10.times.map do
  doc = Doctor.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    zip_code: Faker::Address.zip_code,
    city: cities.sample
  )
  doc.specialties << specialties.sample(2)
  doc
end

puts "🧍 Création des patients..."
patients = 10.times.map do
  Patient.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    city: cities.sample
  )
end

puts "📆 Création des rendez-vous..."
20.times do
  Appointment.create!(
    date: Faker::Time.forward(days: 15, period: :day),
    doctor: doctors.sample,
    patient: patients.sample,
    city: cities.sample
  )
end

puts "✅ Seed terminé avec succès !"

puts "#{City.count} villes 🏙️ créées"
puts "#{Doctor.count} docteurs 🩺 disponibles"
puts "#{Patient.count} patients inscrits 🧍"
puts "#{Appointment.count} rendez-vous programmés 📆"
puts "#{Specialty.count} spécialités médicales 🧠"
