//
//  ImageNoiseEditorApp.swift
//  ImageNoiseEditor
//
//  Created by Gabriel Thomson on 9/6/26.
//

import SwiftUI
import Metal
import os

let LOGGER = Logger(subsystem: "com.gabriel.ImageNoiseEditor", category: "main")

let DEFAULT_SETTINGS = SettingsStruct(redAmplifier: 1.0, greenAmplifier: 1.0, blueAmplifier: 1.0, sharedAmplifier: 0.5, redOffset: 0, greenOffset: 0, blueOffset: 0, sharedOffset: 0, skipBlack: 1)

@main
struct ImageNoiseEditorApp: App {
    @State var settings = DEFAULT_SETTINGS
    @State var inputImage: MTLTexture?
    @State var outputImage: MTLTexture?
    
    init() {
        RenderPipelineStates.initialize()
        ComputePipelineStates.initialize()
    }
    var body: some Scene {
        WindowGroup {
            ContentView(settings: $settings, inputImage: $inputImage, outputImage: $outputImage)
        }
    }
}
