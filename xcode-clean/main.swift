//
//  main.swift
//  xcode-clean
//
//  Created by Niklas Berglund on 2017-11-04.
//  Copyright © 2017 Niklas Berglund. All rights reserved.
//

import Foundation

let commandLine = CommandLine()

let helpFlag = BoolOption(shortFlag: "h", longFlag: "help", required: false, helpMessage: "Print help message")
let allFlag = BoolOption(shortFlag: "A", longFlag: "all", required: false, helpMessage: "Clear archives")
let dryRunFlag = BoolOption(shortFlag: "d", longFlag: "dry-run", required: false, helpMessage: "Dry run")
let archivesFlag = BoolOption(shortFlag: "a", longFlag: "archives", required: false, helpMessage: "Clear archives")
let backupDsymsFlag = StringOption(shortFlag: "b", longFlag: "backup-dsyms", helpMessage: "Backup dSYM files")

commandLine.addOptions(helpFlag, allFlag, dryRunFlag, archivesFlag, backupDsymsFlag)

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

print("All is \(allFlag.value)")
print("Archives is \(archivesFlag.value)")
print("Dry run is \(dryRunFlag.value)")

if let backupPath = backupDsymsFlag.value {
    print("Backup path is \(backupPath)")
}

