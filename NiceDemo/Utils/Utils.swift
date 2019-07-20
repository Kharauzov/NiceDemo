//
//  Utils.swift
//
//
//  Created by Serhii Kharauzov on 1/9/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation
import UIKit

// MARK: iOS System Constants

private enum UIUserInterfaceIdiom: Int {
    case unspecified
    case phone
    case pad
}

private struct ScreenSize {
    static let screenWidth        = UIScreen.main.bounds.size.width
    static let screenHeight       = UIScreen.main.bounds.size.height
    static let screenMaxLength    = max(ScreenSize.screenWidth, ScreenSize.screenHeight)
    static let screenMinLength    = min(ScreenSize.screenWidth, ScreenSize.screenHeight)
}

/// Type of device, based on screen size.

public struct DeviceType {
    public static let isIphone5OrLess          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.screenMaxLength <= 568.0
    public static let isIphone8                = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.screenMaxLength == 667.0
    public static let isIphone8PlusOrMore      = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.screenMaxLength >= 736.0
    public static let isIphoneX                = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.screenMaxLength == 812.0
    public static let isIpad                   = UIDevice.current.userInterfaceIdiom == .pad
    
    public static var hasTopNotch: Bool {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
        return false
    }
}

// MARK: App internal constants

struct Constants {
    static let passwordRequiredLength = 6
}
