//
//  ChangePill.swift
//  CoinPriceTracker
//
//  Created by Rachit Sharma on 15/02/2026.
//

import Foundation
import SwiftUI

struct ChangePill: View {
    let percentage: Double?

    var body: some View {
        let pct = percentage ?? 0
        let isPositive = pct >= 0
        let color: Color = isPositive ? .green.opacity(0.85) : .red.opacity(0.85)
        let arrow = isPositive ? "arrow.up.right" : "arrow.down.right"

        HStack(spacing: 6) {
            Image(systemName: arrow)
                .font(.caption2.weight(.semibold))
            Text(pct.formattedPercentage())
                .font(.caption.weight(.semibold).monospacedDigit())
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 10)
        .background {
            Capsule(style: .continuous)
                .fill(color.opacity(0.18))
        }
        .overlay {
            Capsule(style: .continuous)
                .strokeBorder(color.opacity(0.35))
        }
        .foregroundStyle(color)
    }
}
