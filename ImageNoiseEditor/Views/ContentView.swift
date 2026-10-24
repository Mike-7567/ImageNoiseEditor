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
        HSplitView {
            PreviewView(settings: $settings, inputImage: $inputImage).aspectRatio(1, contentMode: .fit)
                
            SettingsView(settings: $settings, inputImage: $inputImage)
        }
    }
}
