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
    @Binding var outputImage: MTLTexture?
    
    var body: some View {
        HSplitView {
            PreviewView(settings: $settings, inputImage: $inputImage, outputImage: $outputImage)
                .aspectRatio(0.5, contentMode: .fit)
                .border(.quaternary)
                
            SettingsView(settings: $settings, inputImage: $inputImage, outputImage: $outputImage)
        }
    }
}
