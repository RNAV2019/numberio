//
//  ButtonCell.swift
//  numberio
//
//  Created by Ryan Navsaria on 09/12/2022.
//

import SwiftUI

struct ButtonCell: View {
    let value: String
    let image: Bool
    var body: some View {
        print(value)
        if (image) {
            return AnyView (
                ZStack {
                    Rectangle()
                        .frame(width: 110, height: 120)
                        .foregroundColor(Color(UIColor.systemOrange))
                        .cornerRadius(16)
                    Image(systemName: "arrow.backward")
                        .foregroundColor(.white)
                        .font(.system(size: 35, weight: .black))
                }
            )

        } else {
            return AnyView (
                ZStack {
                    Rectangle()
                        .frame(width: 110, height: 120)
                        .foregroundColor(Color(UIColor.systemOrange))
                        .cornerRadius(16)
                    Text(value)
                        .foregroundColor(.white)
                        .bold()
                        .font(.system(size: 55))
                }
            )
        }
    }
}
