
Store.create(name: 'STORE 1', location: "226 S Wabash Ave,Chicago, IL 60604", open_hour: Time.local(2002, 10, 31, 8, 0, 0), close_hour: Time.local(2002, 10, 31, 22, 0, 0), description: "An Exclusive SPA offering luxurious cacials & therapeutic massages.",phone_number: Faker::PhoneNumber.cell_phone )

  Store.create(name: 'STORE 2', location: "73 W Monroe st, Chicago, IL 60603", open_hour: Time.local(2002, 10, 31, 7, 0, 0), close_hour: Time.local(2002, 10, 31, 21, 0, 0), description: "An Exclusive SPA offering luxurious cacials & therapeutic massages.",phone_number: Faker::PhoneNumber.cell_phone )

  Store.create(name: 'STORE 3', location: "1 S State st, Chicago, IL 60603", open_hour: Time.local(2002, 10, 31, 9, 0, 0), close_hour: Time.local(2002, 10, 31, 23, 0, 0), description: "An Exclusive SPA offering luxurious cacials & therapeutic massages.",phone_number: Faker::PhoneNumber.cell_phone )


Service.create(name: 'Basic Facial(For men, women and teens)', duration: '60', price: '50',description: 'cleansing, peeling, steam, eyebrows shaping, facial massage, remove blackhead, high frequency treatment, eye mask, cold mask', category: 'facial treatment')
Service.create(name: 'Acne Facial', duration: '80', price: '60',description: 'deep layer cleansing,peeling, steam, eyebrows shaping, facial massage, remove blackhead, high frequency treatment, galvanic machine with special essence, Eye Mask Cold Mask', category: 'facial treatment')
Service.create(name: 'Ultrasonic Firm Up Skin Facial', duration: '75', price: '75',description: 'cleansing,peeling, steam, eyebrows shaping, facial massage, remove blackhead, high frequency treatment,Ultrasonic machine, cold mask', category: 'facial treatment')
Service.create(name: 'Vitamin C & Seaweed SPA Facial', duration: '90', price: '110',description: 'cleansing,peeling, steam, eyebrows shaping, facial massage, remove blackhead, high frequency treatment, vitamin C concentrate, facial massage with seaweed serum rich in vitamin C,minerals and proteins, fresh seaweed mask', category: 'facial treatment')
Service.create(name: 'Botinol(Botox-like effect)', duration: '90', price: '85',description: 'This anti-aging procedure provides a Botox-like effect. No needle, no pain, no risk. This clinically proven, four step treatmenteffectively, reduce superficial lines and deeper wrinkles. Using collagen and vegetal filling spheres, the relaxing treatment plumps and reidentifies skin for a rejuvenated appearance. After just one session, up to 97% of wrinkles and visibly reduced, with even more amazing results after the next three sessions.', category: 'special treatment')
Service.create(name: 'Hydrolifting', duration: '60', price: '45',description: 'A five phase anti-aging treatment formulated to exfoliate, deeply rehydrate, restore, lift and firm the skin. A potent moizturizer and toner.', category: 'special treatment')
Service.create(name: 'Alog Mask', duration: '30', price: '40',description: 'Deeply rehydrate. Tighten the pore. Reduce redness. Good for oil skin with open pore.', category: 'special treatment')
Service.create(name: 'collagen Mask', duration: '30', price: '30',description: 'Hydrating, brightening and firm the skin.', category: 'special treatment')
Service.create(name: 'Back Facial', duration: '30', price: '40', category: 'Body Treatment')
Service.create(name: 'Body Scrub Full Body', duration: '30', price: '40', category: 'Body Treatment')
Service.create(name: 'Seaweed Wrap Full Body', duration: '60', price: '50', category: 'Body Treatment')
Service.create(name: ' 30 mins Swedish/Deep Tissue Massage', duration: '30', price: '30', category: 'Body Treatment')
Service.create(name: ' 60 mins Swedish/Deep Tissue Massage', duration: '60', price: '50', category: 'Body Treatment')
Service.create(name: ' 90 mins Swedish/Deep Tissue Massage', duration: '90', price: '85', category: 'Body Treatment')
Service.create(name: ' 30 mins Reflexology', duration: '30', price: '35', category: 'Body Treatment')
Service.create(name: ' 60 mins Reflexology', duration: '60', price: '55', category: 'Body Treatment')
Service.create(name: ' 30 mins Aromatherapy Massage', duration: '30', price: '35', category: 'Body Treatment')
Service.create(name: ' 60 mins Aromatherapy Massage', duration: '60', price: '55', category: 'Body Treatment')
Service.create(name: ' 90 mins Aromatherapy Massage', duration: '90', price: '85', category: 'Body Treatment')
Service.create(name: ' Mini Day Spa', duration: '90', price: '80', category: 'Spa Specials', description:'Full facial and half hour massage')
Service.create(name: ' Special Spa', duration: '120', price: '110', category: 'Spa Specials', description:'Ultrasonic facial, collagen mask, half hour body massage')
Service.create(name: ' Half Day Spa', duration: '150', price: '150', category: 'Spa Specials', description:'Full facial, half hour body massage, full body scrub, full body mask')
Service.create(name: ' Lip or chin waxing', duration: '15', price: '8', category: 'waxing', )
Service.create(name: ' Face waxing', duration: '15', price: '7', category: 'waxing', )
Service.create(name: ' Stomach waxing', duration: '20', price: '25', category: 'waxing', )
Service.create(name: ' Half arm waxing', duration: '20', price: '18', category: 'waxing', )
Service.create(name: ' Full arm waxing', duration: '30', price: '30', category: 'waxing', )
Service.create(name: ' Back waxing', duration: '30', price: '40', category: 'waxing', )


Store.all.each do |store|
  5.times do
    store.staffs.create(name: Faker::Name.first_name, phone_number: Faker::PhoneNumber.cell_phone)
  end
    store.staffs.all.each do |staff|
      5.times do
        staff.appointments.create(name: Faker::Name.name, date_time: Faker::Time.between(Time.zone.now + 5, Time.zone.now),email: Faker::Internet.email, phone_number: Faker::PhoneNumber.cell_phone, service_ids:2, store_id:staff.store_id )
        
        staff.appointments.create(name: Faker::Name.name, date_time: Faker::Time.between(Time.zone.now + 5, Time.zone.now),email: Faker::Internet.email, phone_number: Faker::PhoneNumber.cell_phone, service_ids:1, store_id:staff.store_id )

        staff.appointments.create(name: Faker::Name.name, date_time: Faker::Time.between(Time.zone.now + 5, Time.zone.now),email: Faker::Internet.email, phone_number: Faker::PhoneNumber.cell_phone, service_ids:3, store_id:staff.store_id )
      end
    end
end


user1 = User.create(name: 'Jin', email: 'admin@gmail.com', password: '123456', phone_number: Faker::PhoneNumber.cell_phone,time_zone: 'Central Time (US & Canada)')
user2 = User.create(name: 'Mike', email: 'mike@gmail.com', password: '123456', phone_number: Faker::PhoneNumber.cell_phone, time_zone: 'Central Time (US & Canada)')
user1.add_role :admin
user1.remove_role :customer



