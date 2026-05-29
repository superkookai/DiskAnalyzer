//
//  FormattedDiskInfo.swift
//  DiskAnalyzer
//
//  Created by Weerawut on 29/5/2569 BE.
//

import Foundation

struct FormattedDiskInfo: Identifiable {
    let id = UUID()
    let title: String
    let size: Int64
    let totalSize: Int64
    
    var formattedSize: String {
        ByteCountFormatter.string(fromByteCount: size * 1024, countStyle: .file)
    }
    
    var formattedTotalSize: String {
        ByteCountFormatter.string(fromByteCount: totalSize * 1024, countStyle: .file)
    }
    
    var percentage: Double {
        Double(size) / Double(totalSize)
    }
    
    static var example: FormattedDiskInfo {
        FormattedDiskInfo(title: "System", size: 11 * 1024 * 1024,
                          totalSize: 910 * 1024 * 1024)
    }
    
    static var examples: [FormattedDiskInfo] {
        [FormattedDiskInfo(title: "System", size: 11 * 1024 * 1024,
                          totalSize: 910 * 1024 * 1024),
         FormattedDiskInfo(title: "Available", size: 300 * 1024 * 1024,
                           totalSize: 910 * 1024 * 1024),
         FormattedDiskInfo(title: "User Data", size: 600 * 1024 * 1024,
                           totalSize: 910 * 1024 * 1024)
        ]
    }
}
