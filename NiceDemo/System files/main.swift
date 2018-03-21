//
//  main.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/21/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import UIKit

let isRunningTests = NSClassFromString("XCTestCase") != nil
let appDelegateClass : AnyClass = isRunningTests ? TestAppDelegate.self : AppDelegate.self


UIApplicationMain(
    CommandLine.argc,
    UnsafeMutableRawPointer(CommandLine.unsafeArgv)
        .bindMemory(
            to: UnsafeMutablePointer<Int8>.self,
            capacity: Int(CommandLine.argc)),
    nil,
    NSStringFromClass(appDelegateClass)
)
