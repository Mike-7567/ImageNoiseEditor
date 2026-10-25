//
//  Vertex.swift
//  MetalSimulations
//
//  Created by Gabriel Thomson on 11/28/24.
//

import MetalKit

@MainActor
struct Vertex {
    let position: SIMD3<Float>
    let texcoords: SIMD2<Float>
    
    init(position: SIMD3<Float>, texcoords: SIMD2<Float>) {
        self.position = position
        self.texcoords = texcoords
    }
    
    static func quadVerticesTopHalfWithSize(width: Int, height: Int) -> [Vertex] {
        return [
            Vertex(position: simd_float3(1, 1, 1), texcoords: simd_float2(Float(width), Float(height))),
            Vertex(position: simd_float3(1, 0, 1), texcoords: simd_float2(Float(width), 0)),
            Vertex(position: simd_float3(-1, 1, 1), texcoords: simd_float2(0, Float(height))),
            Vertex(position: simd_float3(-1, 0, 1), texcoords: simd_float2(0, 0))
        ]
    }
    
    static func quadVerticesBottemHalfWithSize(width: Int, height: Int) -> [Vertex] {
        return [
            Vertex(position: simd_float3(1, 0, 1), texcoords: simd_float2(Float(width), Float(height))),
            Vertex(position: simd_float3(1, -1, 1), texcoords: simd_float2(Float(width), 0)),
            Vertex(position: simd_float3(-1, 0, 1), texcoords: simd_float2(0, Float(height))),
            Vertex(position: simd_float3(-1, -1, 1), texcoords: simd_float2(0, 0))
        ]
    }

    static let quadVerticesBottemHalf: [Vertex] = [
        
    ]
    
    static let VERTEX_DESCRIPTOR: MTLVertexDescriptor = Vertex.makeVertexDescriptor()
    
    static func makeVertexDescriptor() -> MTLVertexDescriptor {
        let descriptor = MTLVertexDescriptor()
        descriptor.attributes[MyPosAttribute.rawValue].format = .float3
        descriptor.attributes[MyPosAttribute.rawValue].bufferIndex = 0
        descriptor.attributes[MyPosAttribute.rawValue].offset = 0
        
        descriptor.attributes[MyTexCoordAttribute.rawValue].format = .float2
        descriptor.attributes[MyTexCoordAttribute.rawValue].bufferIndex = 0
        descriptor.attributes[MyTexCoordAttribute.rawValue].offset = MemoryLayout<Vertex>.offset(of: \.texcoords)!
        
        descriptor.layouts[0].stride = MemoryLayout<Vertex>.stride
        
        return descriptor
    }
}

