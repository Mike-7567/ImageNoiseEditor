//
//  PreviewView.swift
//  ImageNoiseEditor
//
//  Created by Gabriel Thomson on 9/6/26.
//

import SwiftUI
import MetalKit

struct PreviewView: NSViewRepresentable {
    @State var renderer = Renderer()
    
    @Binding var settings: SettingsStruct
    @Binding var inputImage: MTLTexture?
    @Binding var outputImage: MTLTexture?
    
    func makeNSView(context: Context) -> some NSView {
        let view = MTKView()
        
        view.device = DEVICE
        view.delegate = renderer
        view.preferredFramesPerSecond = 60
        view.colorPixelFormat = Preferences.mainPixelFormat
        
        return view
    }
    
    func updateNSView(_ nsView: NSViewType, context: Context) {
        renderer.settings = settings
        renderer.inputTexture = inputImage
        renderer.outputTexture = outputImage
    }
}
