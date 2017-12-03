//
//  main.swift
//  xcode-clean
//
//  Created by Niklas Berglund on 2017-11-04.
//  Copyright © 2017 Niklas Berglund. All rights reserved.
//

import Foundation

func deleteContents(_ path: DirectoryPath, dryRun: Bool, cleaner: Cleaner) {
    let diskSpaceString = cleaner.humanReadableDiskSpace(path: path)
    
    if dryRun {
        print("Clearing \(path.rawValue) would free \(diskSpaceString)")
    }
    else {
        print("Clearing \(path) (freeing \(diskSpaceString) disk space)")
        cleaner.deleteContents(path: path)
    }
}


let commandLine = CommandLine()

let helpFlag = BoolOption(shortFlag: "h", longFlag: "help", required: false, helpMessage: "Print help message")
let allFlag = BoolOption(shortFlag: "A", longFlag: "all", required: false, helpMessage: "Clear archives")
let dryRunFlag = BoolOption(shortFlag: "x", longFlag: "dry-run", required: false, helpMessage: "Dry run")

let archivesFlag = BoolOption(shortFlag: "a", longFlag: "archives", required: false, helpMessage: "Clear archives")
let derivedDataFlag = BoolOption(shortFlag: "d", longFlag: "derived-data", required: false, helpMessage: "Clear DerivedData")
let deviceSupportFlag = BoolOption(shortFlag: "D", longFlag: "device-support", required: false, helpMessage: "Clear device support")
let simulatorDevicesFlag = BoolOption(shortFlag: "s", longFlag: "simulator-devices", required: false, helpMessage: "Clear simulator devices")
let backupDsymsFlag = StringOption(shortFlag: "b", longFlag: "backup-dsyms", helpMessage: "Backup dSYM files")

/// Which paths to delete contents in
var clearPaths: [DirectoryPath] = []

commandLine.addOptions(helpFlag, allFlag, dryRunFlag, archivesFlag, derivedDataFlag, deviceSupportFlag, simulatorDevicesFlag, backupDsymsFlag)

do {
    try commandLine.parse()
} catch {
    commandLine.printUsage(error)
    exit(EX_USAGE)
}

if helpFlag.value {
    commandLine.printUsage()
    exit(0)
}

if let backupPath = backupDsymsFlag.value {
    print("Backup path is \(backupPath)")
}

if allFlag.value { // All
    clearPaths = DirectoryPath.allValues
}
else {
    if archivesFlag.value {
        clearPaths.append(DirectoryPath.archives)
    }
    
    if derivedDataFlag.value {
        clearPaths.append(DirectoryPath.derivedData)
    }
    
    if deviceSupportFlag.value {
        clearPaths.append(DirectoryPath.deviceSupport)
    }
    
    if simulatorDevicesFlag.value {
        clearPaths.append(DirectoryPath.simulatorDevices)
    }
}

let cleaner = Cleaner()

if dryRunFlag.value { // Dry run mode
    print("Running in dry run mode. No files will be removed.")
}

for path in clearPaths {
    deleteContents(path, dryRun: dryRunFlag.value, cleaner: cleaner)
}

