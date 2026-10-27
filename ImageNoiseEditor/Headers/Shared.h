//
//  Shared.h
//  ImageNoiseEditor
//
//  Created by Gabriel Thomson on 9/6/26.
//

#include <simd/simd.h>

#ifndef Shared_h
#define Shared_h

struct SettingsStruct {
    float redAmplifier;
    float greenAmplifier;
    float blueAmplifier;
    float sharedAmplifier;
    uint32_t redOffset;
    uint32_t greenOffset;
    uint32_t blueOffset;
    uint32_t sharedOffset;
    uint8_t skipBlack;
    float aspectRatio;
};

enum BufferPos {
    SettingsPos = 1
};

enum VertexDescriptorAttributes {
    MyPosAttribute = 0,
    MyTexCoordAttribute = 1
};

enum TextPos {
    OriginalTextPos = 0,
    NewTextPos = 1
};

#endif /* Shared_h */
