//
//  ScreenSizes.swift
//  minichallenge02
//
//  Created by Beatriz Sato on 27/04/20.
//  Copyright © 2020 Juan Suman. All rights reserved.
//

import UIKit

struct ScreenSize{
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
    static let maxLength = max(ScreenSize.width, ScreenSize.height)
    static let minLength = min(ScreenSize.width, ScreenSize.height)
}

struct DeviceType{
    static let isiPhone8 = ScreenSize.maxLength == 667
    static let isiPhone8plus = ScreenSize.maxLength == 736
    static let isiPhone11orProMax = ScreenSize.maxLength == 896
    static let isiPhoneSEorless = ScreenSize.maxLength == 568
    static let isiPhone11Pro = ScreenSize.maxLength == 812
}
