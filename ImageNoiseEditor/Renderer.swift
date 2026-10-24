//
//  Renderer.swift
//  ImageNoiseEditor
//
//  Created by Gabriel Thomson on 9/6/26.
//

import MetalKit
import os

class Renderer: NSObject, MTKViewDelegate {
    var settings = DEFAULT_SETTINGS
    var inputTexture: MTLTexture?
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        
    }
    
    func draw(in view: MTKView) {
        guard view.currentDrawable != nil, view.currentRenderPassDescriptor != nil else {
            return
        }
        
        guard let commandBuffer = COMMAND_QUEUE.makeCommandBuffer() else {
            LOGGER.error("Failed to create command buffer")
            return
        }
        
        guard let inputTexture else {
            return
        }
        
        guard let renderEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: view.currentRenderPassDescriptor!) else {
            LOGGER.error("Failed to create render encoder")
            return
        }
        renderEncoder.label = "Render Encoder"
        
        renderEncoder.setSettings(settings)
        renderEncoder.setVertexBytes(Vertex.quadVerticesTopHalfWithSize(width: inputTexture.width, height: inputTexture.height), length: MemoryLayout<Vertex>.stride * 4, index: 0)
        renderEncoder.setRenderPipelineState(RenderPipelineStates.originalRenderPipelineState)
        renderEncoder.setFragmentTexture(inputTexture, index: OriginalTextPos.rawValue)
        renderEncoder.drawPrimitives(type: .triangleStrip, vertexStart: 0, vertexCount: 4)
        
        renderEncoder.endEncoding()
        
        
        commandBuffer.present(view.currentDrawable!)
        commandBuffer.commit()
        commandBuffer.waitUntilCompleted()
    }
}
