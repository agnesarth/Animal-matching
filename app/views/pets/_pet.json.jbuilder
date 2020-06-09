json.extract! pet, :id, :name, :animal, :chip_number, :breed, :sex, :age, :created_at, :updated_at
json.url pet_url(pet, format: :json)
