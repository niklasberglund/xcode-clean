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
        let expandedPath = Cleaner.expandTilde(path.rawValue)
        var totalSize: Int = 0
        
        if let files = FileManager.default.subpaths(atPath: expandedPath) {
            for filePath in files {
                let filePathFull = "\(expandedPath)/\(filePath)"
                
                if let fileAttributes = try? FileManager.default.attributesOfItem(atPath: filePathFull) {
                    totalSize += fileAttributes[FileAttributeKey.size] as! Int
                }
            }
        }
        
        return totalSize
    }
    
    public func humanReadableDiskSpace(path: DirectoryPath) -> String {
        return ""
    }
    
    public func deleteContents(path: DirectoryPath) {
        
    }
    
    private static func expandTilde(_ path: String) -> String {
        return NSString(string: path).expandingTildeInPath
    }
}
