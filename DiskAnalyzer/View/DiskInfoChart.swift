//
//  DiskInfoChart.swift
//  DiskAnalyzer
//
//  Created by Weerawut on 29/5/2569 BE.
//

import SwiftUI
import Charts

struct DiskInfoChart: View {
    let diskInfos: [FormattedDiskInfo]
    
    var body: some View {
        Chart(diskInfos) { info in
            SectorMark(
                angle: .value(
                    info.title,
                    info.percentage
                ),
                innerRadius: .ratio(
                    0.6
                ),
                angularInset: 1.0
            )
                .foregroundStyle(
                    by: .value(
                        Text(
                            verbatim: info.title
                        ),
                        info.title
                    )
                )
                .annotation(position: .overlay) {
                    Text("\(info.percentage * 100, specifier: "%.1f")%").bold()
                }
                .cornerRadius(5)
        }
        .chartLegend(position: .trailing, alignment: .center)
        .frame(height: 150)
    }
}

#Preview {
    DiskInfoChart(diskInfos: FormattedDiskInfo.examples)
        .padding()
}
