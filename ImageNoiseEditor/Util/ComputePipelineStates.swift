//
//  ComputePipelineStates.swift
//  ImageNoiseEditor
//
//  Created by Gabriel Thomson on 10/24/26.
//

import Metal

@MainActor
class ComputePipelineStates {
    
    private(set) static var addNoiseComputePipelineState: MTLComputePipelineState!
    
    static func initialize() {
        let addNoiseComputePipelineStateDescriptor = MTLComputePipelineDescriptor()
        addNoiseComputePipelineStateDescriptor.computeFunction = LIBRARY?.makeFunction(name: "addNoise")
        addNoiseComputePipelineStateDescriptor.label = "Add Noise"
            
        addNoiseComputePipelineState = try! DEVICE.makeComputePipelineState(descriptor: addNoiseComputePipelineStateDescriptor, options: []).0
    }
}
