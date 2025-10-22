puts "🌱 Seeding database..."

# Clear existing data
puts "Clearing existing data..."
Review.destroy_all
Booking.destroy_all
Favorite.destroy_all
PropertyAmenity.destroy_all
Photo.destroy_all
Property.destroy_all
Amenity.destroy_all
User.destroy_all

# Create Amenities
puts "Creating amenities..."
amenities_data = [
    { name: 'Wi-Fi', icon: 'wifi', category: 'basic' },
    { name: 'Kitchen', icon: 'utensils', category: 'basic' },
    { name: 'Free parking', icon: 'car', category: 'basic' },
    { name: 'TV', icon: 'tv', category: 'basic' },
    { name: 'Air conditioning', icon: 'wind', category: 'comfort' },
    { name: 'Washer', icon: 'washing-machine', category: 'convenience' },
    { name: 'Hair dryer', icon: 'hair-dryer', category: 'convenience' },
    { name: 'Pool', icon: 'swimming-pool', category: 'luxury' },
    { name: 'Hot tub', icon: 'hot-tub', category: 'luxury' },
    { name: 'Gym', icon: 'dumbbell', category: 'luxury' },
    { name: 'Beach access', icon: 'umbrella-beach', category: 'location' },
    { name: 'Mountain view', icon: 'mountain', category: 'location' }
]

amenities = amenities_data.map { |data| Amenity.create!(data) }
puts "✅ Created #{amenities.count} amenities"

# Create Users
puts "Creating users..."
admin = User.create!(
    email: 'admin@propertyrent.com',
    password: 'password123',
    first_name: 'Admin',
    last_name: 'User',
    role: :admin
)

host1 = User.create!(
    email: 'sarah@example.com',
    password: 'password123',
    first_name: 'Sarah',
    last_name: 'Johnson',
    role: :host,
    bio: 'Luxury property owner with 10+ years of hospitality experience',
    phone: '+1234567890'
)

host2 = User.create!(
    email: 'michael@example.com',
    password: 'password123',
    first_name: 'Michael',
    last_name: 'Chen',
    role: :host,
    bio: 'Passionate about unique stays and exceptional guest experiences',
    phone: '+1234567891'
)

guest1 = User.create!(
    email: 'john@example.com',
    password: 'password123',
    first_name: 'John',
    last_name: 'Doe',
    role: :guest,
    phone: '+1234567892'
)

guest2 = User.create!(
    email: 'jane@example.com',
    password: 'password123',
    first_name: 'Jane',
    last_name: 'Smith',
    role: :guest,
    phone: '+1234567893'
)

puts "✅ Created #{User.count} users"

# Create Properties
puts "Creating properties..."

property1 = Property.create!(
    user: host1,
    title: 'Luxury Home in Campoamor',
    description: 'Experience the epitome of coastal luxury in this stunning modern villa. Floor-to-ceiling windows frame breathtaking Mediterranean views, while the infinity pool seems to merge with the azure horizon. The minimalist interior design features premium furnishings and state-of-the-art amenities. Perfect for families or groups seeking an unforgettable retreat.',
    location: 'Orihuela Costa',
    city: 'Campoamor',
    country: 'Spain',
    latitude: 37.8722,
    longitude: -0.7408,
    price_per_night: 2740.00,
    property_type: :entire_home,
    bedrooms: 4,
    bathrooms: 3,
    guests: 8,
    status: :active,
    featured: true
)

property2 = Property.create!(
    user: host1,
    title: 'The Homewood',
    description: 'Nestled in lush greenery, this architectural masterpiece combines contemporary design with natural tranquility. The open-plan living space flows seamlessly onto expansive terraces, perfect for al fresco dining. With premium amenities and stunning forest views, this property offers a peaceful escape from city life.',
    location: 'Pacific Palisades',
    city: 'Los Angeles',
    country: 'USA',
    latitude: 34.0522,
    longitude: -118.2437,
    price_per_night: 5399.00,
    property_type: :entire_home,
    bedrooms: 5,
    bathrooms: 4,
    guests: 10,
    status: :active,
    featured: true
)

property3 = Property.create!(
    user: host2,
    title: 'Mirror House Sud',
    description: 'Mirror Houses are two small houses immersed in a beautiful scenery of apple orchards just outside, in the wonderful surroundings of the South Tyrolean Dolomites. The Mirror Houses offer a unique opportunity to spend a wonderful holiday surrounded by contemporary architecture of the highest standards in close contact with one of the most evocative landscapes that nature can offer.',
    location: 'Bolzano, Trentino-Alto Adige',
    city: 'Bolzano',
    country: 'Italy',
    latitude: 46.4983,
    longitude: 11.3548,
    price_per_night: 1600.00,
    property_type: :unique_stay,
    bedrooms: 2,
    bathrooms: 1,
    guests: 4,
    status: :active,
    featured: true
)

property4 = Property.create!(
    user: host2,
    title: 'Modern Beach Villa',
    description: 'Wake up to the sound of waves in this stunning beachfront property. Contemporary design meets coastal charm with floor-to-ceiling windows, a private pool, and direct beach access. The spacious interior features a gourmet kitchen, luxurious bedrooms, and a rooftop terrace perfect for sunset cocktails.',
    location: 'Malibu Beach',
    city: 'Malibu',
    country: 'USA',
    latitude: 34.0259,
    longitude: -118.7798,
    price_per_night: 3500.00,
    property_type: :entire_home,
    bedrooms: 4,
    bathrooms: 3,
    guests: 8,
    status: :active,
    featured: false
)

property5 = Property.create!(
    user: host1,
    title: 'Mountain Retreat Cabin',
    description: 'Escape to this cozy mountain cabin surrounded by pine forests and stunning alpine views. Perfect for nature lovers, this rustic yet modern retreat features a stone fireplace, hot tub, and large deck for stargazing. Ideal for winter skiing or summer hiking adventures.',
    location: 'Aspen',
    city: 'Aspen',
    country: 'USA',
    latitude: 39.1911,
    longitude: -106.8175,
    price_per_night: 1200.00,
    property_type: :cabin,
    bedrooms: 3,
    bathrooms: 2,
    guests: 6,
    status: :active,
    featured: false
)

properties = [property1, property2, property3, property4, property5]

puts "✅ Created #{Property.count} properties"

# Add photos to properties (using placeholder URLs)
puts "Adding photos to properties..."

properties.each_with_index do |property, index|
    3.times do |i|
        Photo.create!(
            property: property,
            url: "https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=1200",
            position: i,
            is_primary: i.zero?
        )
    end
end
puts "✅ Created #{Photo.count} photos"

# Add amenities to properties
puts "Adding amenities to properties..."

properties.each do |property|
    property.amenities << amenities.sample(rand(5..8))
end

puts "✅ Added amenities to properties"

# Create Bookings
puts "Creating bookings..."

booking1 = Booking.create!(
  user: guest1,
  property: property1,
  check_in: 30.days.from_now,
  check_out: 37.days.from_now,
  guests_count: 4,
  total_price: property1.price_per_night * rand(2..5),
  status: :confirmed
)

booking2 = Booking.create!(
  user: guest2,
  property: property2,
  check_in: 45.days.from_now,
  check_out: 52.days.from_now,
  guests_count: 6,
  total_price: property2.price_per_night * rand(2..5),
  status: :pending
)

puts "✅ Created #{Booking.count} bookings"

# Create Reviews
puts "Creating reviews..."
review1 = Review.create!(
    property: property1,
    user: guest1,
    rating: 4.82,
    comment: 'Everything was great. Sabina was very kind and responsive. She always answered us very quick. Check in was very smooth. The building itself is literally in a beautiful scenery of apple orchards just outside, in the wonderful surroundings.'
)

review2 = Review.create!(
    property: property3,
    user: guest2,
    rating: 4.95,
    comment: 'Amazing stay! The Mirror House exceeded all expectations. The architecture is stunning and the location is perfect for exploring the Dolomites. Would definitely return!'
)

puts "✅ Created #{Review.count} reviews"

# Create Favorites
puts "Creating favorites..."

Favorite.create!(user: guest1, property: property2)
Favorite.create!(user: guest1, property: property3)
Favorite.create!(user: guest2, property: property1)

puts "✅ Created #{Favorite.count} favorites"

puts "\n✨ Seeding complete!"
puts "\n📊 Summary:"
puts "  Users: #{User.count}"
puts "  Properties: #{Property.count}"
puts "  Photos: #{Photo.count}"
puts "  Amenities: #{Amenity.count}"
puts "  Bookings: #{Booking.count}"
puts "  Reviews: #{Review.count}"
puts "  Favorites: #{Favorite.count}"

puts "\n🔐 Login Credentials:"
puts "  Admin: admin@propertyrent.com / password123"
puts "  Host 1: sarah@example.com / password123"
puts "  Host 2: michael@example.com / password123"
puts "  Guest 1: john@example.com / password123"
puts "  Guest 2: jane@example.com / password123"