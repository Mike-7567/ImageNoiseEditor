//
//  PipelineStates.swift
//  FluidSimulation
//
//  Created by Gabriel Thomson on 12/15/24.
//

import Metal

@MainActor
class RenderPipelineStates {
    
    private(set) static var originalRenderPipelineState: MTLRenderPipelineState!
    
    static func initialize() {
        let originalRenderPipelineDescriptor = MTLRenderPipelineDescriptor()
        originalRenderPipelineDescriptor.vertexFunction = LIBRARY!.makeFunction(name: "originalVertex")
        originalRenderPipelineDescriptor.fragmentFunction = LIBRARY!.makeFunction(name: "originalFragment")
        originalRenderPipelineDescriptor.colorAttachments[0].pixelFormat = Preferences.mainPixelFormat
        originalRenderPipelineDescriptor.vertexDescriptor = Vertex.VERTEX_DESCRIPTOR
        originalRenderPipelineDescriptor.label = "OriginalPipelineState"
        
        originalRenderPipelineState = try! DEVICE.makeRenderPipelineState(descriptor: originalRenderPipelineDescriptor)
    }
}
