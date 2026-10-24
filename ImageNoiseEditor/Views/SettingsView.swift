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
    @Binding var inputImage: MTLTexture?
    
    var body: some View {
        VStack {
            Spacer()
            Button("Select png file") {
                isShowingFilePicker.toggle()
            }
            Button("Export file") {
                guard inputImage != nil else {
                    LOGGER.warning("Not loaded")
                    return
                }
                
                let doc = mtlTextureToFile(inputImage!)
                if let doc {
                    outputDoc = doc
                    isShowingFileExporter.toggle()
                }
            }
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
