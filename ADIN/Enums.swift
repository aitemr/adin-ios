//
//  Enums.swift
//  ADIN
//
//  Created by Aidar Nugmanov on 7/14/17.
//  Copyright © 2017 Islam Temirbek. All rights reserved.
//

import Foundation

//Enums

enum ViewControllerType {
    case welcome
    case conversations
}

enum PhotoSource {
    case library
    case camera
}

enum MessageType {
    case photo
    case text
    case location
}

enum MessageOwner {
    case sender
    case receiver
}
