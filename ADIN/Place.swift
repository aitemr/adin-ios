//
//  Place.swift
//  ADIN
//
//  Created by Islam on 04.05.17.
//  Copyright © 2017 Islam Temirbek. All rights reserved.
//

import Firebase
import ObjectMapper

class Place: Mappable {
    
    var username: String?
    var proFileImageUrl: String?
    var theme: String?
    var descrip: String?
    var followers: Int?
    var time: String?
    var price: Int?
    var involvement: Int?
    var averageCommentsCount: Int?
    var averageLikesCount: Int?
    var averageViewsCount: Int?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        username <- map["username"]
        proFileImageUrl <- map["proFileImageUrl"]
        theme <- map["theme"]
        descrip <- map["descrip"]
        followers <- map["followers"]
        time <- map["time"]
        price <- map["price"]
        involvement <- map["involvement"]
        averageCommentsCount <- map["averageCommentsCount"]
        averageLikesCount <- map["averageLikesCount"]
        averageViewsCount <- map["averageViewsCount"]
    }
    
    static func fetch(completion: @escaping (([Place]?, String?) -> Void)) {
        Database.database().reference().child("Items").observe(.value, with: { (snapshot) in
            if let values = snapshot.value as? [String: Any] {
                var places: [Place] = []
                for (_ , value) in values {
                    guard let items = value as? [String: Any] else { return }
                    for (_, item) in items {
                        if let place = Mapper<Place>().map(JSONObject: item) {
                            places.append(place)
                        }
                    }
                }
                completion(places, nil)
            }
        }) { (error) in
            completion(nil, error.localizedDescription)
        }
    }
    
    static func add(username: String?, theme: String?, descrip: String?, time: String?, price: Int?,
                    completion: @escaping ((String?) -> Void)) {
        guard let id = Auth.auth().currentUser?.uid else { return }
        var place = Dictionary<String, Any>()
        place["username"] = username
        place["theme"] = theme
        place["time"] = time
        place["descrip"] = descrip
        place["price"] = price
        place["proFileImageUrl"] = ""
        place["followers"] = 0
        place["averageCommentsCount"] = 0
        place["averageLikesCount"] = 0
        place["averageViewsCount"] = 0
        place["isVerified"] = false
        place["involvement"] = 0
        guard let username = username else { return }
        Database.database().reference().child("Items").child(id).child(username).setValue(place) { (error, reference) in
            if error == nil {
                completion(nil)
            } else {
                completion(error?.localizedDescription)
            }
        }
    }
    
    static func fetchCurrentUserPlaces(completion: @escaping (([Place]?, String?) -> Void)) {
        guard let id = Auth.auth().currentUser?.uid else { return }
        Database.database().reference().child("Items").child(id).observe(.value, with: { (snapshot) in
            if let values = snapshot.value as? [String: Any] {
                var places: [Place] = []
                for (_ , value) in values {
                    if let place = Mapper<Place>().map(JSONObject: value) {
                        places.append(place)
                    }
                }
                completion(places, nil)
            }
        }) { (error) in
            completion(nil, error.localizedDescription)
        }
    }
    
    static func update(username: String?, theme: String?, descrip: String?, time: String?, price: Int?,
                    completion: @escaping ((String?) -> Void)) {
        guard let id = Auth.auth().currentUser?.uid else { return }
        var place = Dictionary<String, Any>()
        place["theme"] = theme
        place["time"] = time
        place["descrip"] = descrip
        place["price"] = price
        guard let username = username else { return }
        Database.database().reference().child("Items").child(id).child(username).updateChildValues(place) { (error, reference) in
            if error == nil {
                completion(nil)
            } else {
                completion(error?.localizedDescription)
            }
        }
    }
    
}
