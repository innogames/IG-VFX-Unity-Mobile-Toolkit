# InnoGames VFX Shaders / Scripts For Mobile Productions

 <br>

![VFX](https://github.com/innogames/IgVFXUnity/blob/main/Docs/Images/IntroEffect_01.gif)
<br>

Welcome to InnoGames' open-source repository of VFX shaders/scripts for mobile productions!
Our collection of custom scripts and shaders has been specifically designed to create visual effects on mobile devices.
Mobile devices have limitations such as draw calls, texture size, amount of geometry, and more. To optimize performance,
we've kept our scripts and shaders as efficient as possible for our effects productions. All of the code in this
repository is open-source, which means that you can view, modify, and contribute to it in any way you see fit. Thank you
for visiting our repository, and we hope that these VFX shaders/scripts will help you to create stunning VFX on mobile
devices!
<br>

- [Installation](#installation)
- [C# Scripts](#c-scripts)
    - [VFX Get Transform](#vfx-get-transform)
    - [VFX Link Transform](#vfx-link-transform)
    - [VFX Material Properties Animation Over Time](#vfx-material-properties-animation-over-time)
    - [VFX Render Bounds](#vfx-render-bounds)
    - [VFX Scale By Rotation](#vfx-scale-by-rotation)
- [Particle Scripts](#particle-shaders)
    - [VFX Particle Constant Position](#vfx-particle-constant-position)
    - [VFX Particle Position Sync](#vfx-particle-sync-position)
    - [VFX Particle On Off Over Duration](#vfx-particle-on-off-over-duration)
- [Shaders](#shaders)
    - [True Color Shaders](#true-color-shaders)
        - [True Color Particle Shaders](#true-color-particle-shaders)
            - [True Color Base](#true-color-base)
            - [True Color Dissolve](#true-color-dissolve)
    - [Image Shaders](#image-shaders)
        - [Cascade Shader](#cascade-shader)
        - [Glitch Shader](#glitch-shader)
        - [Desaturation Shader](#desaturation-shader)
        - [Shine Shader](#shine-shader)
    - [Particle Shaders](#particle-shaders)
        - [Fluid Shader](#fluid-shader)
        - [Multi Dynamic Shader](#multi-dynamic-shader)
    - [Multi Color Shaders](#multi-color-shaders)
        - [Multi Color Light And Motion Shader](#multi-color-light-and-motion-shader)
          <br>

## Installation

Copy the scripts and shaders into your Unity script / shader folder.
<br>

## C# Scripts

### Overview

Those C# scripts are created to control and manipulate various VFX elements, such as particle systems, animations, and
other graphical effects. They can be used to change the behavior and appearance of the VFX, making it possible to create
interactive and dynamic experiences for players.
<br>

## VFX Get Transform

### Overview

This feature involves passing the position from a GameObject to the material variable '_SetPos'.
<br>

![Example](https://github.com/innogames/IgVFXUnity/blob/main/Docs/Images/GetTransform_01.gif)

### Properties

| Properties         | Description                                                            |
|--------------------|------------------------------------------------------------------------|
| Source             | The GameObject to obtain the position from.                            |
| Target Material    | Material with a '_SetPos' variable. _SetPos should be vector variable. |

<br>

## VFX Link Transform

### Overview

This script synchronizes the target object's transform with the source object's transform.
<br>

![Example](https://github.com/innogames/IgVFXUnity/blob/main/Docs/Images/LinkTransform_01.gif)

### Properties

| Properties | Description                                       |
|------------|---------------------------------------------------|
| Source     | The GameObject to obtain the transform from.      |
| Target     | The GameObject to link with the source.           |

<br>

## VFX Material Properties Animation Over Time

### Overview

This script animates material properties in relation to the time speed.

### Source Properties

| Properties              | Description                                 |
|-------------------------|---------------------------------------------|
| Get Material From Image | Enable this to get the material from image. |

### Animation Properties

| Properties             | Description                                      |
|------------------------|--------------------------------------------------|
| Activate Animation     | Activates the animation.                         |
| Looping                | Looping the animated curves.                     |
| Time Speed             | How fast time progresses.                        |
|                        |                                                  |
| Animate Properties     |                                                  |
|                        |                                                  |
| Element                | Number of properties to animate.                 |
| Material Property Name | Enter the variable name of the property here.    |
| Time Curve X           | Animates the first index of a vector or a float. |
| Time Curve Y           | Animates the second index of a vector.           |
| Time Curve Z           | Animates the third index of a vector.            |
| Time Curve W           | Animates the fourth index of a vector.           |

<br>

## VFX Render Bounds

### Overview

Obtaining the Render Bounds of a Mesh or Skinned Mesh Renderer and passing them into the Target Material. The material
requires the following variables: '_BoundsMin, _BoundsMax, _BoundsCtr, _BoundsSize'.
<br>

![Example](https://github.com/innogames/IgVFXUnity/blob/main/Docs/Images/RenderBounds_01.gif)

### Properties

| Properties          | Description                                                |
|---------------------|------------------------------------------------------------|
| Use Skinned Mesh    | Enable this to use skinned mesh as a source.               |
| Source              | A GameObject with a mesh or skinned mesh render component. |

<br>

## VFX Scale By Rotation

### Overview

This script scales a game object based on the rotation from a another game object. Apply this script to the game object
that requires scaling.
<br>

![Example](https://github.com/innogames/IgVFXUnity/blob/main/Docs/Images/ScaleByRotation_01.gif)

### Properties

| Properties     | Description                                               |
|----------------|-----------------------------------------------------------|
| Source         | Add here the source game object to get the rotation data. |
| Angles Range X | Minimum and Maximum Rotation X Angles for scaling.        |
| Angles Range Y | Minimum and Maximum Rotation Y Angles for scaling.        |
| Angles Range Z | Minimum and Maximum Rotation Z Angles for scaling.        |
| Curve Scale X  | Uniform scale curve relative to the Angles X Range.       |
| Curve Scale Y  | Uniform scale curve relative to the Angles Y Range.       |
| Curve Scale Z  | Uniform scale curve relative to the Angles Z Range.       |

<br>

## Particle Scripts

### Overview

Those scripts are manipulating particles and particle systems.
<br>

## VFX Particle Constant Position

### Overview

The particles get aligned between two vectors and can be manipulated by a sinus curve.
<br>

![Example](https://github.com/innogames/IgVFXUnity/blob/main/Docs/Images/ConstantPosition_01.gif)
![Example](https://github.com/innogames/IgVFXUnity/blob/main/Docs/Images/ConstantPosition_02.gif)

### Properties

| Properties             | Description                                         |
|------------------------|-----------------------------------------------------|
| Target Particle System | Particles to manipulate from the particle system.   |
| End Position           | Vector of the second position.                      |
| Offset                 | Position offset.                                    |
| Phase                  | Phase of the particles' position.                   |
| Frequency              | Frequency of the particles' position.               |
| Amplitude              | Amplitude of the particles' position.               |

<br>

## VFX Particle Sync Position

### Overview

This script synchronizes the target particles' position with the source position. Apply this script on any Game Object.

### Properties

| Properties             | Description                                         |
|------------------------|-----------------------------------------------------|
| Source Particle System | Source particle system.                             |
| Target Particle System | Particle systems to sync with the source.           |
| Rate Over Time         | Value should be the same as in the source.          |
| Burst Time             | Burst time should be the same as in the source.     |
| Burst Count            | Burst count should be the same as in the source.    |
| Offset                 | Offset relative to velocity.                        |

<br>

## VFX Particle On Off Over Duration

### Overview

Deactivate one GameObject and activate another based on the duration of the particle system emitter.

### Properties

| Properties             | Description                                             |
|------------------------|---------------------------------------------------------|
| Source Particle System | Particle system that counts the duration to switch.     |
| Off Object             | Disables the game object after a duration elapses.      |
| On Object              | Enables the game object after a duration elapses.       |

<br>

## Shaders

### Overview

The shaders are vertex / pixel shaders written in CG.
<br>

> > **Note**
If you need them in HLSL, then you need to change the CG PROGRAM like here.
> <br>
Here some links:
> [Catlike Coding](https://catlikecoding.com/unity/tutorials/scriptable-render-pipeline/custom-shaders/)
> <br>
> [HLSL in Unity](https://docs.unity3d.com/Manual/SL-ShaderPrograms.html)
> <br>
> [Microsoft High-level shader language ](https://learn.microsoft.com/en-us/windows/win32/direct3dhlsl/dx-graphics-hlsl)
> <br>
> [Unity ShaderLab Code Blocks Documentation](https://docs.unity3d.com/Manual/shader-shaderlab-code-blocks.html)

<br> 

### Global Render Properties

Except for UI shaders, all other shaders share common rendering properties. The following attributes define an object's
appearance during rendering.
> **Note**
> Store vertex alpha in the second UV at index [0].
> **Note**
> Some of the listed properties might not be utilized in the shaders..

| Render Properties                | Description                                                                                    |
|----------------------------------|------------------------------------------------------------------------------------------------|
| Pre-multiplied Mode              | Black areas in the alpha will blend additively.                                                |
| Disable Vertex Alpha             | Disabling the vertex alpha which is stored in the second UV's first index (X).                 |
| Cull Mode                        | [Unity Documentation on Cull](https://docs.unity3d.com/Manual/SL-Cull.html)                    |
| Stencil Buffer                   | Configures the stencil buffer according to the given parameters.                               |
| Reference                        | [Unity Stencil Documentation](https://docs.unity3d.com/Manual/SL-Stencil.html)                 |
| Compare                          | [Unity Stencil Documentation](https://docs.unity3d.com/Manual/SL-Stencil.html)                 |
| Pass                             | [Unity Stencil Documentation](https://docs.unity3d.com/Manual/SL-Stencil.html)                 |
| Write                            | [Unity Stencil Documentation](https://docs.unity3d.com/Manual/SL-Stencil.html)                 |
| Read                             | [Unity Stencil Documentation](https://docs.unity3d.com/Manual/SL-Stencil.html)                 |
| Z Write                          | [Unity ZWrite Documentation](https://docs.unity3d.com/Manual/SL-ZWrite.html)                   |
| Z Test                           | [Unity ZTest Documentation](https://docs.unity3d.com/Manual/SL-ZTest.html)                     |
| Double Sided Global Illumination | [Material-doubleSidedGI](https://docs.unity3d.com/ScriptReference/Material-doubleSidedGI.html) |

## True Color Shaders

True color shaders perform linear interpolation between two colors, guided by a mask. Another feature is to blend
between additive and pre-multiply mode, guided by black and white values.
<br>

## True Color Particle Shaders

### Overview

All true color particle shaders use Custom Data 1 and 2.
<br>

### Setup Particle System Vertex Stream

You need to set up the vertex stream in your particle system.

| Properties                                                                                                                                                  | Description                                                                        |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------|
| ![Setup Vertex Stream in Renderer Module for meshes](https://github.com/innogames/IgVFXUnity/blob/main/Docs/Images/fx_setup_shuriken_for_true_color_01.jpg) | Set up Vertex Stream for billboards and stretch particles as shown in the picture. |
| ![Setup Vertex Stream in Renderer Module for meshes](https://github.com/innogames/IgVFXUnity/blob/main/Docs/Images/fx_setup_shuriken_for_true_color_02.jpg) | Set up Vertex Stream for mesh particles as shown in the picture.                   |
| ![Add and setup Custom Data Module](https://github.com/innogames/IgVFXUnity/blob/main/Docs/Images/fx_setup_shuriken_for_true_color_03.jpg)                  | Enable and set Custom Data 1 and 2 as vectors and colors as shown in the picture.  |

<br>

## True Color Base

### Overview

This shader includes the true color features.

### Base Properties

| Properties     | Description                                                                                          |
|----------------|------------------------------------------------------------------------------------------------------|
| Transform      | UV tiling and offset are used to repeat and shift the position of the alpha texture.                 |
| Packed Texture | It stores different masks in the channels, which are used as alpha. Only RGB channels are supported. |

<br>

## True Color Dissolve

### Overview

This shader is based on the true color particle base shader with an additional dissolve feature.

### Base Properties

| Properties     | Description                                                                                          |
|----------------|------------------------------------------------------------------------------------------------------|
| Transform      | UV tiling and offset are used to repeat and shift the position of the alpha texture.                 |
| Packed Texture | It stores different masks in the channels, which are used as alpha. Only RGB channels are supported. |

### Dissolve Properties

| Properties | Description                                                                       |
|------------|-----------------------------------------------------------------------------------|
| Invert     | Invert the ramp texture values.                                                   |
| Fall Off   | Change the values from the ramp. Higher values will give hard edge results.       |
| Transform  | UV tiling and offset are used to repeat and shift the position of the ramp map.   |
| Ramp Map   | Map with gradient information that controls the direction of the dissolve effect. |

<br>

## Image Shaders

### Overview

The image shaders are specially designed to be used by other artists, such as UI or non-technical / VFX artists. This
shader is intended to be used with a UI image.
<br>

> > **Note**
> If you are using a atlas, you might need a script that passes UV coordinates from the atlas into the shader.

<br>

## Cascade Shader

### Overview

This shader transitions the image from one state to its actual picture.
<br>

![Example](https://github.com/innogames/IgVFXUnity/blob/main/Docs/Images/ImageEffect_01.gif)

### Cascade Properties

| Properties       | Description                                                                           |
|------------------|---------------------------------------------------------------------------------------|
| Solve            | Solves the following layers in this order: color layer, thin layer, distortion layer. |
| Delay Thin Layer | Delays solving the layer relative to the state of the solve properties.               |
| Delay Distortion | Delays solving the layer relative to the state of the solve properties.               |

### Layer Properties

| Properties            | Description                                                         |
|-----------------------|---------------------------------------------------------------------|
| Color                 | Color Layer                                                         |
| Thin Strength         | Blend strength of the thin layer.                                   |
| Distortion Strength   | Distortion strength.                                                |
| Distort Alpha Channel | If enabled, the distortion will respect the alpha channel.          |

### Texture Properties

| Properties     | Description                                                                       |
|----------------|-----------------------------------------------------------------------------------|
| Ramp           | Ramp texture                                                                      |
| Color          | Color texture for the thin layer                                                  |
| Distortion Map | Map with vector information applied to the UVs for directional distortion effect. |

<br>

## Glitch Shader

### Overview

This shader creates a glitch effect, like a TV glitch. By default, it is set up with textures and a distortion map that
creates a cartoon style. For a different style, simply change the textures.
<br>

![Example](https://github.com/innogames/IgVFXUnity/blob/main/Docs/Images/ImageEffect_02.gif)

### Jitter Properties

| Properties | Description                          |
|------------|--------------------------------------|
| Amplitude  | Jitter strength value.               |
| Frequency  | Jitter frequency.                    |

### Distortion Properties

| Properties           | Description                         |
|----------------------|-------------------------------------|
| Distortion Frequency | Distortion frequency.               |
| Distortion Speed X   | Swipe value for the U axis.         |
| Distortion Speed Y   | Swipe value for the V axis.         |

### Color Properties

| Properties                   | Description                                  |
|------------------------------|----------------------------------------------|
| Enable Tint                  | Activate image tinting.                      |
| Tint Strength                | Blend strength value.                        |
| Flickering Frequency         | Flickering frequency.                        |
| Multiply or Add Tint Texture | Blend between multiplied or additive tinting |
| Desaturation Strength        | Increase or decrease image desaturation.     |

<br>

## Desaturation Shader

### Overview

This shader desaturates the original image. For performance reasons, this shader doesn't use a typical HSL function.
Instead, the shader returns each color channel individually to create a grayscale effect.

### Properties

| Properties              | Description                                         |
|-------------------------|-----------------------------------------------------|
| Strength                | Blend between the original and grayscale.           |
| Source Texture Channels | Vector specifying contribution to grayscale effect. |

<br>

## Shine Shader

### Overview

This shader generates a shine effect guide by a mask.

### Main Properties

| Properties          | Description                         |
|---------------------|-------------------------------------|
| Enable Shine        | Activate the shine effect.          |
| Enable Transparency | Alpha channel affects shine effect. |

### Shading Properties

| Properties | Description                      |
|------------|----------------------------------|
| Tint Glow  | Color for the shine effect.      |
| Blend Glow | Control shine effect visibility. |

### Animation Properties

| Properties                     | Description           |
|--------------------------------|-----------------------|
| Delay                          | Defines delay.        |
| Swipe X and Y, Set Direction Z | Frequency of jitter.  |

### Texture Properties

| Properties      | Description            |
|-----------------|------------------------|
| Glow Mask       | Jitter strength value. |
| Tiling & Offset | Jitter frequency.      |

<br>

## Particle Shaders

### Overview

The particle shaders utilize the vertex stream to control shader features.

## Fluid Shader

### Overview

This shader is mainly for fluid effects. It is based on the fusion concept. It is a concept that I created to make
simple fluid effects for mobile productions.
<br>

![Example](https://github.com/innogames/IgVFXUnity/blob/main/Docs/Images/Fusion.gif)
<br>

#### Fusion Concept!

The fusion concept essentially involves merging two grayscale ramps and subsequently subtracting the grayscale values
with another value. After this, the values are multiplied by 100 to regain sharp edges while maintaining smooth, rounded
shapes. With additional motion applied to each ramp, and this way, you can create a fluid-like animation. For good
results, the grayscale ramp should be soft.
<br>

![Example](https://github.com/innogames/IgVFXUnity/blob/main/Docs/Images/FusionConcept_01.gif)
![Example](https://github.com/innogames/IgVFXUnity/blob/main/Docs/Images/FusionConcept_02.gif)

### Main Texture Properties

| Properties                                      | Description                                                                                                 |
|-------------------------------------------------|-------------------------------------------------------------------------------------------------------------|
| Multiply to Mask                                | If this is enabled, the mask will be multiplied to the alpha, affecting the fusion effect.                  |
| Use Custom Data 2 (Z, W) For Stretch And Squash | Enabling this feature allows you to control the tiling of a texture using custom data 2's Z and W channels. |
| Blend Channels                                  | XYZ values blend the different RGB channels.                                                                |
| Tiling / Offset                                 | UV tiling and offset are used to repeat and shift the position of the texture.                              |
| Packed Texture                                  | It stores different masks in the channels, which are used as alpha. Only the RGB channels are supported.    |

### Second Texture Properties

| Properties                                      | Description                                                                                                 |
|-------------------------------------------------|-------------------------------------------------------------------------------------------------------------|
| Use Custom Data 2 (Z, W) For Stretch And Squash | Enabling this feature allows you to control the tiling of a texture using custom data 2's Z and W channels. |
| Blend Channels                                  | XYZ values blend the different RGB channels.                                                                |
| Tiling / Offset                                 | UV tiling and offset are used to repeat and shift the position of the texture.                              |
| Packed Texture                                  | It stores different masks in the channels, which are used as alpha. Only the RGB channels are supported.    |

### Mask Properties

| Properties      | Description                                                                      |
|-----------------|----------------------------------------------------------------------------------|
| Shrink Mask     | This value is applied to the mask texture.                                       |
| Tiling / Offset | UV tiling and offset are used to repeat and shift the position of the texture.   |
| Mask            | Map with grayscale information to mask the alpha.                                |

### Fusion Properties

| Properties                 | Description                                                                                                      |
|----------------------------|------------------------------------------------------------------------------------------------------------------|
| Use Standard Alpha of Life | The alpha from particles will not be multiplied into the fusion effect; it will be used as a normal alpha blend. |
| Fusion Strength            | This value controls how much will be subtracted from the alpha.                                                  |
| Alpha Blend                | Transparency strength.                                                                                           |
| Edge Blend                 | Blends the edge.                                                                                                 |
| Edge Tint                  | Tints the edge.                                                                                                  |
| Edge Brightness            | Controls the brightness of the edge.                                                                             |

### Light Properties

| Properties      | Description                                |
|-----------------|--------------------------------------------|
| Light Enable    | Enables the light source.                  |
| Light Direction | Sets the position of the light source.     |
| Shadow Color    | Sets the color value for the shadow areas. |
| Shadow Blend    | Strength of the shadow visibility.         |

<br>

## Multi Dynamic Shader

### Overview

This shader combines different dynamics and motion together, for example dissolving, distortions, UV sweeps, etc. The
dynamics are controlled by the custom data from the particle system Shuriken. You will also need meshes; the UV should
be warped in one direction (U or V).
<br>

![Example](https://github.com/innogames/IgVFXUnity/blob/main/Docs/Images/Multimotion.gif)

### Debug Properties

The shader is quite complex, and during production, you can sometimes lose the overview of what the features are doing.
For that reason, I've built these debug properties to provide a better understanding of what the shader is doing. These
properties generate a new compute shader. After you've finished debugging, don't forget to disable the 'Compute Debug
Mode', as this enables and disables all debug modes.

| Properties         | Description                              |
|--------------------|------------------------------------------|
| Compute Debug Mode | Computes all debug features.             |
| Debug Glow         | Visualizes the glow feature.             |
| Debug Color        | Visualizes the color feature.            |
| Debug Alpha        | Visualizes the alpha feature.            |
| Debug Vertex Alpha | Visualizes the vertex alpha feature.     |
| Debug Mask         | Visualizes the mask feature.             |
| Debug Dissolve     | Visualizes the dissolve feature.         |
| Debug Distortion   | Visualizes the distortion feature.       |

### Shading Properties

| Properties                | Description                                                                 |
|---------------------------|-----------------------------------------------------------------------------|
| Use Red Channel As Glow   | Blends the red channel of the texture.                                      |
| Use Green Channel As Glow | Blends the green channel of the texture.                                    |
| Use Blue Channel As Glow  | Blends the blue channel of the texture.                                     |
| Additive Tint Color       | Determines how much the tint color should be additive blend.                |
| Additive Blend            | Blends between pre-multiplied and additive mode.                            |
| Color Ramp                | A ramp relative to the U axis, blending between the first and second color. |
| Second Color              | Sets the second color value.                                                |
| Ramp Blend                | The strength of the ramp.                                                   |
| Ramp Offset               | Offsets the ramp at the U axis.                                             |
| Ramp Multiplier           | Controls the gradient of the ramp.                                          |

### Alpha Properties

| Properties           | Description                                                                                           |
|----------------------|-------------------------------------------------------------------------------------------------------|
| UV Flip U            | Flips the UV coordinates horizontally.                                                                |
| UV Flip V            | Flips the UV coordinates vertically.                                                                  |
| UV Rotate 90 Degrees | Rotates the UV coordinates by 90 degrees.                                                             |
| Invert Swirl         | Inverts the direction of the swirl.                                                                   |
| Swirl Direction U    | Sets the swirl direction.                                                                             |
| Blend Channels       | Blends the different channels' XYZ values of RGB.                                                     |
| Transform            | Uses UV tiling and offset to repeat and shift the texture's position.                                 |
| Packed Texture       | Stores different masks in the channels, which are used as alpha. Only the RGB channels are supported. |

### Mask Properties

| Properties                          | Description                                                                 |
|-------------------------------------|-----------------------------------------------------------------------------|
| UV Flip U                           | Flips the UV coordinates horizontally.                                      |
| UV Flip V                           | Flips the UV coordinates vertically.                                        |
| UV Rotate 90 Degrees                | Rotates the UV coordinates by 90 degrees.                                   |
| Overwrite Custom Data X for Stretch | If enabled, custom data X will tile the U coordinates from the mask map.    |
| Overwrite Custom Data Y for Swipe   | If enabled, custom data X will offset the U coordinates from the mask map.  |
| Transform                           | Uses UV tiling and offset to repeat and shift the position of the mask map. |
| Mask                                | Map with grayscale information to mask the alpha.                           |

### Dissolve Properties

| Properties           | Description                                                                    |
|----------------------|--------------------------------------------------------------------------------|
| UV Flip U            | Flips the UV coordinates horizontally.                                         |
| UV Flip V            | Flips the UV coordinates vertically.                                           |
| UV Rotate 90 Degrees | Rotates the UV coordinates by 90 degrees.                                      |
| Invert               | Inverts the gradients of the dissolve map.                                     |
| Fall Off             | Changes the values from the ramp; higher values will give hard edge results.   |
| Transform            | Uses UV tiling and offset to repeat and shift the position of the map.         |
| Ramp                 | Map with gradient information to control the direction of the dissolve effect. |

### Distortion Properties

| Properties          | Description                                                                               |
|---------------------|-------------------------------------------------------------------------------------------|
| Enable for Alpha    | Applies distortion to the alpha texture.                                                  |
| Enable for Dissolve | Applies distortion to the dissolve map.                                                   |
| Enable for Mask     | Applies distortion to the mask map.                                                       |
| Transform           | Uses UV tiling and offset to repeat and shift the texture's position.                     |
| Distortion Map      | Map with vector information applied to the UVs to create a directional distortion effect. |

<br>

## Multi Color Shaders

Multi-color shaders use color ramps relative to grayscale values of the texture to colorize it. The alpha of the ramp
controls the additive and pre-multiply blend.
<br>

## Multi Color Light and Motion Shader

### Overview

This shader is a multifunctional for VFX Artists, enabling the creation of diverse and dynamic visual effects through a
modular and customizable approach. It covers a broad spectrum of VFX needs, from geometry and UV manipulation, lighting
and shading, to dissolve and distortion effects.
<br>

![Example](https://github.com/innogames/IgVFXUnity/blob/main/Docs/Images/LightAndMotionShader_01.gif)
<br>
Features:
<br>

#### Geometry Manipulation:

<br>
Allows deformation of geometry with customizable amplitude, phase, and axis.
Offers Rim Multiplier and Hardness for additional effects.
Supports texture addition to computed geometry.
<br>

#### Gradient Properties:

<br>
Enables gradient color application with adjustable strength and brightness.
Provides options for computing gradients by light and UV, with settings for light source position, range, fall-off, and hardness.
<br>

#### UV Manipulation:

<br>
Offers extensive UV manipulation features, including UV ramp blending, offset, and settings.
Supports UV twisting with invert options and custom data usage.
<br>

#### Dissolve Properties:

<br>
Facilitates texture-based dissolve effects with customizable strength, fall-off, and UV tiling.
Provides options for flipping, rotating, and inverting the dissolve ramp.
<br>

#### Distortion Properties:

<br>
Allows distortion effects using texture and mask, with customizable strength and UV coordinates.
Supports distortion in alpha and dissolve, with options for world UV coordinates and mask inversion.
<br>

#### Alpha Properties:

<br>
Manages alpha blending with packed texture and customizable blending channels.
Supports alpha masking with UV tiling and offset.
<br>

#### Render Properties:

<br>
Controls rendering settings including culling mode, stencil buffer, depth buffer, and blending mode.
<br>

#### Lighting and Shading:

<br>
Incorporates light gradient computation with customizable light source properties.
Supports Look Up Table (LUT) for color grading and gradient mapping.
<br>

### Compute Properties

| Properties                   | Description                                                    |
|------------------------------|----------------------------------------------------------------|
| Compute Geometry             | Computes geometry features.                                    |
| Compute Geometry and Texture | Adds texture features to the geometry features.                |
| Compute Gradient by Uv       | Computes gradient features.                                    |
| Compute Uv Manipulate        | Computes UV transform features.                                |
| Compute Dissolve             | Computes dissolve features.                                    |
| Compute Dissolve Clip        | Adds an alpha clipping feature to the dissolve features.       |
| Compute Distortion           | Computes distortion features.                                  |

### Geometry Properties

| Properties                        | Description                                               |
|-----------------------------------|-----------------------------------------------------------|
| Rim Multiplier                    | Strength of the rim effect.                               |
| Rim Hardness                      | Controls the hardness of the fall-off from the rim.       |
| Rim Blend                         | Controls how much the rim is visible.                     |
| Deforming Frequency               | Controls the frequency of the sinus curve.                |
| Deforming Amplitude               | Controls the strength of the sinus curve.                 |
| Deformation Axis                  | Translates the geometry to deform it.                     |
| Push Axis                         | Pushes the geometry along the normals.                    |
| Geo Offset Use Custom Data 1      | Switch to control deformation strength by custom data 1.  |
| Geo Offset By CD1 Channel (0 - 3) | Sets deformation strength by custom data 1 channel.       |

### Gradient Properties

| Properties                               | Description                                                                                                              |
|------------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| Color                                    | Sets the color of the gradient.                                                                                          |
| Strength                                 | Controls the visibility of the gradient.                                                                                 |
| Brightness                               | Controls the strength of the adding effect.                                                                              |
|                                          |                                                                                                                          |
| Gradient by Light                        | NOTE: The Gradient By Light creates a Worldposition gradient from one specific position to all directions.               |
| Convert To A Light                       | When this is enabled, the gradient adopts normal light behavior.                                                         |
| Set Local Position                       | Sets the local position from asset in game play mode.                                                                    |
| Source Position                          | Position of the light relative to the object/particles.                                                                  |
| Range                                    | Controls the light's effect range.                                                                                       |
| Fall Off                                 | Controls the fall-off range.                                                                                             |
| Hardness                                 | Controls the hardness of the fall-off.                                                                                   |
|                                          |                                                                                                                          |
| Gradient by Uv                           |                                                                                                                          |
| Multiply Light Source and Light Radius   | Multiplying the ramp with the light.                                                                                     |
| Axis Blend                               | Defines on which direction the gradient should be create. X = Positive U, Y = Negative U, Z = Positive V, W = Negative V |
| Offset                                   | Translates the uv per axis.                                                                                              |
| Settings                                 | Uses UV tiling and offset to repeat and shift the texture.                                                               |

### Shading Properties

| Properties                   | Description                                                                                                                                                                                                                                                                             |
|------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Look Up Table                | Map with a color gradient from left to right. The alpha value is controlling the blending mode between additive and transparency. <br/> 100% alpha value is 100% additive, and 0% alpha is 100% transparency. <br/> Note: Premultiplied needs to be activated in the render properties. |
| Switch LUT to Color Gradient | Gradient color will replaced by the LUT.                                                                                                                                                                                                                                                |
| Multiply Particle Color      | Particle / vertex colors will be added to mesh / particles.                                                                                                                                                                                                                             |
| Disable Alpha                | The packed texture will be extracted from alpha. This is necessary when you want to disconnect the grayscale from alpha. The alpha mask can replace the alpha.                                                                                                                          |

### Alpha Properties

| Properties                      | Description                                                                                                       |
|---------------------------------|-------------------------------------------------------------------------------------------------------------------|
| Enable Alpha Mask               | Activates the alpha mask properties.                                                                              |
| Packed Texture                  | Stores different masks in the channels, which are used as alpha. <br/> NOTE: Only the RGB channels are supported. |
| Blend Packed Texture Channel    | Blends the different channels' XYZ values of RGB.                                                                 |
| Uv Tiling & Offset              | Uses UV tiling and offset to repeat and shift the texture’s position.                                             |
|                                 |                                                                                                                   |
| Alpha Mask                      |                                                                                                                   |
| Mask                            | Texture with grayscale information to define where and to what extent the visibility should be applied.           |
| Use Alpha Uv                    | Uv Tiling & Offset will used from packed textures.                                                                |
| Uv Tiling & Offset              | Uses UV tiling and offset to repeat and shift the texture’s position.                                             |
| Enable Squeeze XY and Swipe ZW  | With a value of 1, it enables the use of a custom data value for squeezing and swiping the UV.                    |
| Use Custom Data Channel (0 - 3) | Select a custom data channel from 0 to 3.                                                                         |


### Dissolve Properties

| Properties                                  | Description                                                                                           |
|---------------------------------------------|-------------------------------------------------------------------------------------------------------|
| Map                                         | Texture with grayscale information to define where and to what extent the dissolve should be applied. |
| Flip U                                      | Flips the UV coordinates horizontally.                                                                |
| Flip V                                      | Flips the UV coordinates vertically.                                                                  |
| Rotate 90 Degrees                           | Rotates the UV coordinates by 90 degrees.                                                             |
| Use Alpha Uv                                | Uv Tiling & Offset will used from packed textures.                                                    |
| Invert Ramp                                 | Inverts the gradients of the dissolve map.                                                            |
| Use Custom Data 1                           | With a value of 1, it enables the use of a custom data value for the dissolve strength.               |
| Strength By Use Custom Data Channel (0 - 3) | Select a custom data channel from 0 to 3.                                                             |
| Strength                                    | Controls the strength of the dissolve effect.                                                         |
| Uv Tiling & Offset                          | Uses UV tiling and offset to repeat and shift the texture’s position.                                 |
| Fall Off                                    | Changes the values from the map higher values will give hard edge results.                            |

### Distortion Properties

| Properties                                  | Description                                                                                             |
|---------------------------------------------|---------------------------------------------------------------------------------------------------------|
| Map                                         | Texture with vector information applied to the UVs to create a directional distortion effect.           |
| Mask                                        | Texture with grayscale information to define where and to what extent the distortion should be applied. |
| Mask Invert                                 | Distortion will be applied to the alpha texture.                                                        |
| Enable For Alpha                            | Uses UV tiling and offset to repeat and shift the position of the texture.                              |
| Enable For Dissolve                         | Distortion will be applied to the dissolve map.                                                         |
| Use Custom Data 1                           | With a value of 1, it enables the use of a custom data value for the distortion strength.               |
| Strength By Use Custom Data Channel (0 - 3) | Select a custom data channel from 0 to 3.                                                               |
| Strength                                    | Controls the strength of the distortion effect.                                                         |
| Set Uv To World Coordinates                 | Set the uv’s in to world coordinates.                                                                   |
| Uv Tiling & Offset                          | Uses UV tiling and offset to repeat and shift the texture’s position.                                   |

### UV Manipulate Properties

| Properties                        | Description                                                                                                                                           |
|-----------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------|
| Uv Alpha                          |                                                                                                                                                       |
| Enable Squeeze XY and Swipe ZW    | With a value of 1, it enables the use of a custom data value for squeezing and swiping the UV.                                                        |
| Use Custom Data 1 Channel (0 - 3) | Select a custom data channel from 0 to 3.                                                                                                             |
|                                   |                                                                                                                                                       |
| Uv Distortion                     |                                                                                                                                                       |
| Enable Squeeze XY and Swipe ZW    | With a value of 1, it enables the use of a custom data value for squeezing and swiping the UV.                                                        |
| Use Custom Data 1 Channel (0 - 3) | Select a custom data channel from 0 to 3.                                                                                                             |
|                                   |                                                                                                                                                       |
| Uv Twist                          |                                                                                                                                                       |
| Invert U                          | Is inverting the u direction.                                                                                                                         |
| Invert V                          | Is inverting the v direction.                                                                                                                         |
| Alpha Use Custom Data             | Adding the twist effect to the alpha texture.                                                                                                         |
| Dissolve Use Custom Data          | Adding the twist effect to the distortion map.                                                                                                        |
| Twist                             | Controls the strength of the twist. If the Use Custom Data is Enabled. <br/> The four values becomes a switcher to activate the custom channel usage. |
| Use Custom Data 1 Channel (0 - 3) | Select a custom data channel from 0 to 3.                                                                                                             |

<br>
