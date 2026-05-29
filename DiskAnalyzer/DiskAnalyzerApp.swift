//
//  DiskAnalyzerApp.swift
//  DiskAnalyzer
//
//  Created by Weerawut on 29/5/2569 BE.
//

import SwiftUI

@main
struct DiskAnalyzerApp: App {
    var body: some Scene {
        MenuBarExtra {
            ContentView()
                .frame(width: 350)
        } label: {
            Label("Disk Analyzer", systemImage: "externaldrive.connected.to.line.below.fill")
        }
        .menuBarExtraStyle(.window)
    }
}
