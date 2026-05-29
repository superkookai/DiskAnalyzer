//
//  DiskInfoFetcher.swift
//  DiskAnalyzer
//
//  Created by Weerawut on 29/5/2569 BE.
//

import Foundation

@Observable
class DiskInfoFetcher {
    enum CommandError: Error {
        case invalidData
        case commandFailed(String)
        case emptyOutput
    }
    
    var diskInfos: [FormattedDiskInfo] = []
    var error: Error?
    var isLoading: Bool = false
    
    func getDiskInfo() async throws -> [FormattedDiskInfo] {
        try await Task.detached(priority: .userInitiated) {
            let output = try await self.execute("df -k -P")
            let infos = try await self.parse(output)
            return await self.parse(infos)
        }.value
    }
    
    private func execute(_ command: String) throws -> String {
        let process = Process()
        let pipe = Pipe()
        
        process.launchPath = "/bin/sh"
        process.arguments = ["-c", command]
        process.standardOutput = pipe
        
        try process.run()
        process.waitUntilExit()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        guard let output = String(data: data, encoding: .utf8) else {
            throw CommandError.invalidData
        }
        
        process.waitUntilExit()
        
        guard process.terminationStatus == 0 else {
            throw CommandError.commandFailed(output)
        }
        
        return output
    }
    
    private func parse(_ output: String) throws -> [DiskInfo] {
        let lines = output.components(separatedBy: .newlines)
        guard lines.count > 1 else { throw CommandError.emptyOutput }
        
        // Skip header line
        let dataLines = lines.dropFirst()
        
        return dataLines.compactMap { line -> DiskInfo? in
            let components = line.split(separator: " ", omittingEmptySubsequences: true)
            guard components.count >= 5 else { return nil }
            
            return DiskInfo(
                fileSystemName: String(components[0]),
                size: Int64(components[1]) ?? 0,      // Now directly in KB
                used: Int64(components[2]) ?? 0,
                available: Int64(components[3]) ?? 0,
                capacity: Int(components[4].replacingOccurrences(of: "%", with: "")) ?? 0,
                mountPoint: components[5...].joined(separator: " ")
            )
        }
    }
    
    private func parse(_ infos: [DiskInfo]) -> [FormattedDiskInfo] {
        var results = [FormattedDiskInfo]()
        
        let total = infos.systemVolume?.size ?? 0
        
        if let systemVolume = infos.systemVolume {
            results.append(
                FormattedDiskInfo(title: "System",
                                  size: systemVolume.used,
                                  totalSize: total)
            )
        }
        
        if let dataVolume = infos.dataVolume {
            results.append(
                FormattedDiskInfo(title: "Available",
                                  size: dataVolume.available,
                                  totalSize: total)
            )
            
            results.append(
                FormattedDiskInfo(title: "User Data", size: dataVolume.used, totalSize: total)
            )
        }
        
        return results
    }
}
