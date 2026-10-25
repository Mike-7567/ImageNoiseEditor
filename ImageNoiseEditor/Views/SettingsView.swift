//
//  SettingsView.swift
//  ImageNoiseEditor
//
//  Created by Gabriel Thomson on 9/6/26.
//

import SwiftUI
import MetalKit
internal import UniformTypeIdentifiers
import os

struct SettingsView: View {
    @State private var isShowingFilePicker: Bool = false
    @State private var isShowingFileExporter: Bool = false
    @State private var outputDoc: PNGDocument?
    
    @Binding var settings: SettingsStruct
    @State var skipBlackBool: Bool = true
    @Binding var inputImage: MTLTexture?
    @Binding var outputImage: MTLTexture?
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Button("Select png file") {
                    isShowingFilePicker.toggle()
                }
                Button("Export file") {
                    guard outputImage != nil else {
                        LOGGER.warning("Not loaded")
                        return
                    }
                    
                    let doc = mtlTextureToFile(outputImage!)
                    if let doc {
                        outputDoc = doc
                        isShowingFileExporter.toggle()
                    }
                }
                Toggle("Skip Black", isOn: $skipBlackBool).onChange(of: skipBlackBool) {
                    settings.skipBlack = skipBlackBool ? 1 : 0
                }
            }
            
            Slider(value: $settings.sharedAmplifier, in: 0...1) {
                Text("Shared Amplifier \(settings.sharedAmplifier)")
            }
            Slider(value: $settings.redAmplifier, in: 0...1) {
                Text("Red Amplifier \(settings.redAmplifier)")
            }
            Slider(value: $settings.greenAmplifier, in: 0...1) {
                Text("Green Amplifier \(settings.greenAmplifier)")
            }
            Slider(value: $settings.blueAmplifier, in: 0...1) {
                Text("Blue Amplifier \(settings.blueAmplifier)")
            }
            NumberInputView(title: "Shared Offset", number: $settings.sharedOffset)
            NumberInputView(title: "Red Offset", number: $settings.redOffset)
            NumberInputView(title: "Green Offset", number: $settings.greenOffset)
            NumberInputView(title: "Blue Offset", number: $settings.blueOffset)
            
            Spacer()
        }.fileImporter(isPresented: $isShowingFilePicker, allowedContentTypes: [.png]) { result in
            switch result {
            case .success(let url):
                guard url.startAccessingSecurityScopedResource() else {
                    LOGGER.error("Could not access file")
                    return
                }
                self.inputImage = try? TEXTURE_LOADER.newTexture(URL: url, options: [.SRGB: false, .textureStorageMode: MTLStorageMode.shared.rawValue, .textureUsage: MTLTextureUsage.shaderRead.rawValue])
                url.stopAccessingSecurityScopedResource()
                
                let descriptor = MTLTextureDescriptor()
                descriptor.pixelFormat = Preferences.mainPixelFormat
                descriptor.width = inputImage?.width ?? 16
                descriptor.height = inputImage?.height ?? 16
                descriptor.usage = [.shaderWrite, .shaderRead]
                
                outputImage = DEVICE.makeTexture(descriptor: descriptor)
            case .failure:
                break
            }
        }.fileExporter(isPresented: $isShowingFileExporter, document: outputDoc, contentType: .png) { result in
            switch result {
                case .success(let url):
                LOGGER.info("Saved to \(url)")
            case .failure(let error):
                LOGGER.error("\(error.localizedDescription)")
            }
        }.padding()
            .border(.bar)
    }
}
