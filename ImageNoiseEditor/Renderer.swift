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
    var outputTexture: MTLTexture?
    
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
        
        guard let outputTexture else {
            return
        }
        
        guard let computeEncoder = commandBuffer.makeComputeCommandEncoder() else {
            LOGGER.error("Failed to create compute encoder")
            return
        }
        computeEncoder.label = "Add noise kernel"
        computeEncoder.setComputePipelineState(ComputePipelineStates.addNoiseComputePipelineState)
        computeEncoder.setTexture(inputTexture, index: 0)
        computeEncoder.setTexture(outputTexture, index: 1)
        computeEncoder.setSettings(settings)
        computeEncoder.dispatchThreadgroups(MTLSize(width: inputTexture.width, height: inputTexture.height, depth: 1), threadsPerThreadgroup: MTLSize(width: 1, height: 1, depth: 1))
        computeEncoder.endEncoding()
        
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
        
        renderEncoder.setVertexBytes(Vertex.quadVerticesBottemHalfWithSize(width: outputTexture.width, height: outputTexture.height), length: MemoryLayout<Vertex>.stride * 4, index: 0)
        renderEncoder.setRenderPipelineState(RenderPipelineStates.originalRenderPipelineState)
        renderEncoder.setFragmentTexture(outputTexture, index: OriginalTextPos.rawValue)
        renderEncoder.drawPrimitives(type: .triangleStrip, vertexStart: 0, vertexCount: 4)
        
        renderEncoder.endEncoding()
        
        
        commandBuffer.present(view.currentDrawable!)
        commandBuffer.commit()
        commandBuffer.waitUntilCompleted()
    }
}
