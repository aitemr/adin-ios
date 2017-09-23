//
//  Constant.swift
//  ADIN
//
//  Created by Islam on 07.01.17.
//  Copyright © 2017 Islam Temirbek. All rights reserved.
//

import UIKit

struct Constant {
    static let appName = "adin - биржа размещения рекламы в популярных аккаунтах Instagram"
    static let appID = "id1230890924"
    static let reviewUrl = "https://itunes.apple.com/us/app/\(Constant.appID)?ls=1&mt=8&action=write-review"
    static let appUrl = "http://apple.co/2t3pfZv"
    static let companyMail = "info@adinapp.me"
}

struct ScreenSize {
    static let SCREEN_FRAME         = UIScreen.main.bounds
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType {
    static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
    static let IS_IPAD_PRO          = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1366.0
}
