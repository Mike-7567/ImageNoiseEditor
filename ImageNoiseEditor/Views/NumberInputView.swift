//
//  NumberInputView.swift
//  ImageNoiseEditor
//
//  Created by Gabriel Thomson on 10/24/26.
//


import SwiftUI

struct NumberInputView: View {
    var title: String
    @State private var numberText = ""
    @Binding var number: UInt32
    
    var body: some View {
        VStack(spacing: 20) {
            TextField(title, text: $numberText)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
                .onSubmit {
                    let filtered = numberText.filter { "0123456789".contains($0) }
                    if filtered != numberText {
                        self.numberText = ""
                    } else {
                        number = UInt32(numberText)!
                    }
                }
        }
    }
}
