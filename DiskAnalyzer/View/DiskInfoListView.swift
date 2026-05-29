//
//  DiskInfoListView.swift
//  DiskAnalyzer
//
//  Created by Weerawut on 29/5/2569 BE.
//

import SwiftUI

struct DiskInfoListView: View {
    var diskInfos: [FormattedDiskInfo]
    
    var body: some View {
        GroupBox {
            ForEach(diskInfos) { info in
                DiskInfoRow(info: info)
            }
        } label: {
            Text("Disk Space Overview")
        }
    }
}

#Preview {
    DiskInfoListView(diskInfos: FormattedDiskInfo.examples)
        .padding()
        .frame(width: 300)
}
