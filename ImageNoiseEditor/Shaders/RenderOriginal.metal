//
//  RenderOriginal.metal
//  ImageNoiseEditor
//
//  Created by Gabriel Thomson on 9/7/26.
//

#include <metal_stdlib>
using namespace metal;
#include "../Headers/Shared.h"

//MARK: Logger

constant os_log logger(/*subsystem=*/"NoiseImageEditor", /*category=*/"Shaders");

//MARK: Structs

struct Vertex {
    float3 position [[ attribute(MyPosAttribute) ]];
    float2 texcoords [[ attribute(MyTexCoordAttribute) ]];
};

struct RasterizerData {
    float4 position [[ position ]];
    float2 texcoords;
};

//MARK: Functions
vertex RasterizerData originalVertex(Vertex vertIn [[ stage_in ]]) {
    RasterizerData rd;
    
    rd.position = float4(vertIn.position, 1.0);
    rd.texcoords = vertIn.texcoords;
    
    return rd;
}

fragment half4 originalFragment(RasterizerData rd [[ stage_in ]], texture2d<float, access::read> text [[ texture(OriginalTextPos) ]]) {
    float4 color = text.read(uint2(rd.texcoords));
    logger.log("%f %f", rd.texcoords.x, rd.texcoords.y);
    //color = float4(1.0);
    return half4(color);
}

