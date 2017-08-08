//
//  Item.swift
//  Signup
//
//  Created by Sajay Velmurugan on 13/07/17.
//  Copyright © 2017 Sajay Velmurugan. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Item {
    
    var ref: DatabaseReference?
    var title: String?
    
    init (snapshot: DataSnapshot) {
        ref = snapshot.ref
        
        let data = snapshot.value as! Dictionary<String, String>
        title = data["title"]! as String
    }
    
}
