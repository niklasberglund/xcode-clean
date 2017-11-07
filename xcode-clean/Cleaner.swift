//
//  Cleaner.swift
//  xcode-clean
//
//  Created by Niklas Berglund on 2017-11-04.
//  Copyright © 2017 Niklas Berglund. All rights reserved.
//

import Foundation

enum DirectoryPath: String {
    case archives = "~/Library/Developer/Xcode/Archives"
    case derivedData = "~/Library/Developer/Xcode/DerivedData"
    case simulatorDevices = "~/Library/Developer/CoreSimulator/Devices"
    case deviceSupport = "~/Library/Developer/Xcode/iOS DeviceSupport"
}

class Cleaner {
    public func diskSpace(path: DirectoryPath) -> Int {
        return 0
    }
    
    public func humanReadableDiskSpace(path: DirectoryPath) -> String {
        return ""
    }
    
    public func deleteContents(path: DirectoryPath) {
        
    }
}
