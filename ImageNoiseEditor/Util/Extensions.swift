//
//  Extentions.swift
//  MetalSimulations
//
//  Created by Gabriel Thomson on 11/29/24.
//

import Foundation
import simd
import Metal

extension simd_float4 {
    static let black = simd_float4(0, 0, 0, 0)
    static let red = simd_float4(1, 0, 0, 1)
    static let green = simd_float4(0, 1, 0, 1)
    static let blue = simd_float4(0, 0, 1, 1)
    static let yellow = simd_float4(1, 1, 0, 1)
    static let white = simd_float4(1, 1, 1, 1)
}

extension CGFloat {
    static let one = CGFloat(1)
    
    func float() -> Float {
        return Float(self)
    }
}

extension Int {
    func float() -> Float {
        return Float(self)
    }
}

extension MTLRenderCommandEncoder {
    func setFragmentBytes(_ bytes: UnsafeRawPointer, length: Int, index: UInt32) {
        self.setFragmentBytes(bytes, length: length, index: Int(index))
    }
    
    func setVertexBuffer(_ buffer: (any MTLBuffer)?, offset: Int, index: UInt32) {
        self.setVertexBuffer(buffer, offset: offset, index: Int(index))
    }
    
    func setFragmentBuffer(_ buffer: (any MTLBuffer)?, offset: Int, index: UInt32) {
        self.setFragmentBuffer(buffer, offset: offset, index: Int(index))
    }
    
    func setVertexBytes(_ bytes: UnsafeRawPointer, length: Int, index: UInt32) {
        self.setVertexBytes(bytes, length: length, index: Int(index))
    }
    
    func setFragmentTexture(_ texture: MTLTexture?, index: UInt32) {
        self.setFragmentTexture(texture, index: Int(index))
    }
    
    func setSettings(_ settings: SettingsStruct) {
        var constants = settings
        self.setVertexBytes(&constants, length: MemoryLayout<SettingsStruct>.stride, index: SettingsPos.rawValue)
        self.setFragmentBytes(&constants, length: MemoryLayout<SettingsStruct>.stride, index: SettingsPos.rawValue)
    }
}

extension MTLComputeCommandEncoder {
    func setSettings(_ settings: SettingsStruct) {
        var constants = settings
        self.setBytes(&constants, length: MemoryLayout<SettingsStruct>.stride, index: SettingsPos.rawValue)
    }
    
    func setBytes(_ bytes: UnsafeRawPointer, length: Int, index: UInt32) {
        self.setBytes(bytes, length: length, index: Int(index))
    }
}

extension MTLVertexAttributeDescriptorArray {
    subscript(index: UInt32) -> MTLVertexAttributeDescriptor! {
        return self[Int(index)]
    }
}
