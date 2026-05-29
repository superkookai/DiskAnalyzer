//
//  DiskInfo.swift
//  DiskAnalyzer
//
//  Created by Weerawut on 29/5/2569 BE.
//

import Foundation

struct DiskInfo {
    let fileSystemName: String
    let size: Int64
    let used: Int64
    let available: Int64
    let capacity: Int
    let mountPoint: String
    
    var isSystemVolume: Bool {
        mountPoint == "/"
    }
    
    var isDataVolume: Bool {
        mountPoint == "/System/Volumes/Data"
    }
}

// MARK: - Analysis Extension
extension Array where Element == DiskInfo {
    var systemVolume: DiskInfo? {
        first { $0.isSystemVolume }
    }

    var dataVolume: DiskInfo? {
        first { $0.isDataVolume }
    }
}
