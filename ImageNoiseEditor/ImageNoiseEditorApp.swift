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

let DEFAULT_SETTINGS = SettingsStruct(redAmplifier: 0.0, greenAmplifier: 0.0, blueAmplifier: 0.0, sharedAmplifier: 0.5, redOffset: 0, greenOffset: 0, blueOffset: 0, sharedOffset: 0)

@main
struct ImageNoiseEditorApp: App {
    @State var settings = DEFAULT_SETTINGS
    @State var inputImage: MTLTexture?
    
    init() {
        RenderPipelineStates.initialize()
    }
    var body: some Scene {
        WindowGroup {
            ContentView(settings: $settings, inputImage: $inputImage)
        }
    }
}
