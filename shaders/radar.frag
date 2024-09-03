#version 460 core
precision mediump float;

#include <flutter/runtime_effect.glsl>

uniform vec2 iResolution;
uniform float iTime;
uniform float second;
uniform vec3 u_color;  

out vec4 fragColor;

#define PI 3.1415926535897932384626433832795

float LineToPointDistance2D(vec2 a, vec2 b, vec2 p)
{
    vec2 pa = p - a;
    vec2 ba = b - a;
    float h = clamp(dot(pa,ba)/dot(ba,ba), 0.0, 1.0);
    return length(pa - ba*h);
}

vec2 rotatePoint(vec2 center, float angle, vec2 p)
{
    float s = sin(angle);
    float c = cos(angle);
    p -= center;
    vec2 rotated = vec2(p.x * c - p.y * s, p.x * s + p.y * c);
    return rotated + center;
}

void getBlips(float radius, out vec2[1] blipsOut)
{	
    vec2 cen = iResolution.xy/2.0;
    float sec = second;
    float mdl = mod(sec, 10.0);
    
    float cstepRot = ((sec-mdl)/10.0)+1.0;
    float factorRot = cstepRot/6.0;
    
    float factorLen = sin(factorRot)/2.0;
    float len = radius*factorLen;
    vec2 targetP = vec2(cen.x, cen.y+len);	
    float ang = PI*factorRot*2.0;
    targetP = rotatePoint(cen, ang, targetP);
    
    blipsOut[0] = targetP;		
}

float angleVec(vec2 a_, vec2 b_) 
{
    vec3 a = vec3(a_, 0);
    vec3 b = vec3(b_, 0);
    float dotProd = dot(a,b); 
    vec3 crossprod = cross(a,b);
    float crossprod_l = length(crossprod);
    float lenProd = length(a)*length(b);
    float cosa = dotProd/lenProd;
    float sina = crossprod_l/lenProd;
    float angle = atan(sina, cosa);
    
    if(dot(vec3(0,0,1), crossprod) < 0.0) 
        angle = 90.0;
    return (angle * (180.0 / PI));
}

void main()
{
    vec2 fragCoord = FlutterFragCoord().xy;
    vec2 center = iResolution.xy/2.0;
    float minRes = min(center.x, center.y);
    float radius = minRes - minRes*0.1;
    float lineWidth = radius*0.016;
    float angleStela = 180.0;	
    vec2 lineEnd = vec2(center.x, center.y+radius);
    float intensity = 0.0;
    
    float distanceToCenter = distance(center, fragCoord.xy);	
                            
    // Rotate Line
    float angle = (-iTime*1.2);
    lineEnd = rotatePoint(center, angle, lineEnd);
    
    // Draw Line	
    float distPointToLine = LineToPointDistance2D(center, lineEnd, fragCoord.xy);
    if (distPointToLine < lineWidth)
    { 
        float val = 1.0 - distPointToLine/lineWidth;
        intensity = max(intensity, val);
    }
    
    // Draw Stela
    float angleStelaToApply = angleVec(normalize(lineEnd-center), normalize(fragCoord.xy-center));
    if (angleStelaToApply < angleStela && distanceToCenter < radius-1.0)
    {
        float factorAngle = 1.0 - angleStelaToApply/angleStela;
        float finalFactorAngle = (factorAngle*0.5) - 0.15;
        intensity = max(intensity, finalFactorAngle);
        
        // Draw Blips
        vec2 blips[1];
        getBlips(radius, blips);
        float distToBlip = distance(fragCoord.xy, blips[0]);
            
        if (distToBlip < 15.0)
        {
            float blipFactor = 1.0 - distToBlip/15.0;
            float toSubtract = 1.0 - factorAngle;
            float final = blipFactor - toSubtract;
            intensity = max(intensity, final);
        }			
    }
    
    // Apply the uniform color with intensity-based alpha
    vec3 finalColor = u_color * intensity;
    fragColor = vec4(finalColor, intensity);
}