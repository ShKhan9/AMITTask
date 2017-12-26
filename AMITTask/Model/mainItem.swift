//
//  mainItem.swift
//  AMITTask
//
//  Created by ShKhan on 12/18/17.
//  Copyright © 2017 Approcks. All rights reserved.
//

import Foundation

struct mainItem {
    
    var id: String
    var lon: String
    var lat: String
    var userNumber: String
    var address:String
    var userFX:String
    
    
    init(id: String, lon: String, lat: String,userNumber: String, address: String, userFX: String)
    {
        
        
        self.id = id
        self.lon = lon
        self.lat = lat
        self.userNumber = userNumber
        self.address = address
        self.userFX = userFX
        
        
    }
}
