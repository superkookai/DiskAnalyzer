//
//  ContentView.swift
//  DiskAnalyzer
//
//  Created by Weerawut on 29/5/2569 BE.
//

import SwiftUI

struct ContentView: View {
    @State private var fetcher = DiskInfoFetcher()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Disk Analyzer")
                .font(.title2)
                .bold()
            
            DiskInfoListView(diskInfos: fetcher.diskInfos)
            
            DiskInfoChart(diskInfos: fetcher.diskInfos)
        }
        .padding()
        .task {
            do {
                fetcher.diskInfos = try await fetcher.getDiskInfo()
            } catch {
                fetcher.error = error
            }
        }
    }
}

#Preview {
    ContentView()
        .frame(width: 300, height: 400)
}
