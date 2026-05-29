//
//  DiskInfoRow.swift
//  DiskAnalyzer
//
//  Created by Weerawut on 29/5/2569 BE.
//

import SwiftUI

struct DiskInfoRow: View {
    let info: FormattedDiskInfo
    
    var processColor: Color {
        switch info.title {
        case "System": .blue
        case "Available": .green
        default: .orange
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(info.title)
                
                Spacer()
                
                Text(info.formattedSize)
                    .font(.system(.body, design: .monospaced))
            }
            
            GeometryReader { proxy in
                Rectangle()
                    .fill(.gray.opacity(0.2))
                
                Rectangle()
                    .fill(processColor)
                    .frame(width: proxy.size.width * info.percentage)
            }
            .frame(height: 6)
            .clipShape(.capsule)
        }
    }
}

#Preview {
    DiskInfoRow(info: FormattedDiskInfo.example)
        .padding()
        .frame(width: 300)
}
