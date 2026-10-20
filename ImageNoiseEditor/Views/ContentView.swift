//
//  ContentView.swift
//  ImageNoiseEditor
//
//  Created by Gabriel Thomson on 9/6/26.
//

import SwiftUI
import Metal

struct ContentView: View {
    @Binding var settings: SettingsStruct
    @Binding var inputImage: MTLTexture?
    
    var body: some View {
        HStack {
            PreviewView(settings: $settings, inputImage: $inputImage)
                .padding()
            SettingsView(settings: $settings, inputImage: $inputImage)
        }
    }
}
