// Author: Jake Nelson
// License: MIT

#include <metal_stdlib>
#include "MTIShaderLib.h"
#include "MTTransitionLib.h"

using namespace metalpetal;

fragment float4 WipeLeftFragment(VertexOut vertexIn [[ stage_in ]],
                               texture2d<float, access::sample> fromTexture [[ texture(0) ]],
                               texture2d<float, access::sample> toTexture [[ texture(1) ]],
                               constant float & ratio [[ buffer(0) ]],
                               constant float & progress [[ buffer(1) ]],
                               sampler textureSampler [[ sampler(0) ]])
{
    float2 uv = vertexIn.textureCoordinate;
    float _fromR = fromTexture.get_width()/fromTexture.get_height();
    float _toR = toTexture.get_width()/toTexture.get_height();

    float2 p = uv.xy/float2(1.0).xy;
    float4 a = getFromColor(uv, fromTexture, ratio, _fromR);
    float4 b = getToColor(uv, toTexture, ratio, _toR);
    return mix(a, b, step(1.0 - p.x, progress));
}