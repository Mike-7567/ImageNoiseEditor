//
//  AddNoise.metal
//  ImageNoiseEditor
//
//  Created by Gabriel Thomson on 10/24/26.
//

#include <metal_stdlib>
using namespace metal;
#include "../Headers/Shared.h"
#include "../Headers/Metal.h"

kernel void addNoise(uint2 index [[thread_position_in_grid]], texture2d<float, access::sample> original [[texture(0)]], texture2d<float, access::write> output [[texture(1)]], constant SettingsStruct &settings [[ buffer(SettingsPos) ]]) {
    
    float4 color = original.read(index);
    
    if (settings.skipBlack && color.r == 0.0 && color.g == 0 && color.b == 0) {
        return;
    }
    
    float redRandom = goldNoise(float2(index), settings.redOffset + settings.sharedOffset) * settings.redAmplifier * settings.sharedAmplifier;
    float greenRandom = goldNoise(float2(index), settings.greenOffset + settings.sharedOffset) * settings.greenAmplifier * settings.sharedAmplifier;
    float blueRandom = goldNoise(float2(index), settings.blueOffset + settings.sharedOffset) * settings.blueAmplifier * settings.sharedAmplifier;
    
    color.r = clamp(redRandom + color.r, 0.0, 1.0);
    color.g = clamp(greenRandom + color.g, 0.0, 1.0);
    color.b = clamp(blueRandom + color.b, 0.0, 1.0);
    
    output.write(color, index);
}
