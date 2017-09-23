//
//  AdTime.swift
//  ADIN
//
//  Created by Islam on 10.07.17.
//  Copyright © 2017 Islam Temirbek. All rights reserved.
//

enum AdTime: String {
    
    case one = "1/24"
    case two = "2/24"
    case three = "3/24"
    case four = "4/24"
    case five = "5/24"
    case six = "6/24"
    case seven = "1/48"
    case eight = "2/48"
    case nine = "3/48"
    case ten = "4/48"
    case eleven = "5/48"
    case twelve = "6/48"
    case forever = "Без удаления"
    
    static var all: [AdTime] {
        return [.one, .two, .three, .four, .five,
                .six, .seven, .eight, .nine, .ten,
                .eleven, .twelve, .forever]
    }
}
