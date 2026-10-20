//
//  MetalDefs.swift
//  ImageNoiseEditor
//
//  Created by Gabriel Thomson on 9/7/26.
//

import Metal
import MetalKit

let DEVICE = MTLCreateSystemDefaultDevice()!
let COMMAND_QUEUE = DEVICE.makeCommandQueue()!
let LIBRARY = DEVICE.makeDefaultLibrary()
let TEXTURE_LOADER = MTKTextureLoader(device: DEVICE)
