//
//  SegmentedPicker.swift
//  PizzaTimeNYCII
//
//  Created by ASTROID on 3/9/26.
//

import SwiftUI

struct CustomSegmentedPicker<T: CaseIterable & Identifiable & RawRepresentable>: View where T.RawValue == String {
    @Binding var selection: T
    let cases: [T]

    var body: some View {
        HStack(spacing: 0) {
            ForEach(cases, id: \.id) { option in
                Text(option.rawValue.capitalized)
                    .font(.custom("Rubik-Regular", size: 16))
                    .foregroundColor(selection.id == option.id ? .ptnColorYellow : .ptnColorRed)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .background(
                            RoundedRectangle(cornerRadius: 60)
                                .fill(selection.id == option.id ? Color.ptnColorRed : Color.clear)
                        )
                    .overlay(
                            RoundedRectangle(cornerRadius: 60)
                                .stroke(.ptnColorRed, lineWidth: 1)
                        )
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            selection = option
                        }
                    }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 60))
    }
}

#Preview {
    FeedbackPage()
        .environmentObject(MusicState())
        .environmentObject(NavigationManager())
}
