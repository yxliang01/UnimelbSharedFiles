Graphics and Interactions
=====

Terminology
=====

- Computer graphics
    + concerns numerical algorithms for **transforming geometric models into pixelated images**
    + Application: Games, CAD, Simulation, VR, AR, GUI
- Computer vision
    + concerns the **transformation of images into models (reverse of computer graphics)**
    + Application: face and body (skeleton) recognition, robotic perception
- Image processing
    + concerns the **transforming images into other images** (typically used as adjunct to graphics or vision)
    + Application: smoothing, sharpening, segmenting, automatically texturing images, photographic editing
- Polygonal categories
    + ![Polygonal Categories](https://github.com/yxliang01/UnimelbSharedFiles/raw/master/Graphics%20and%20Interaction/Summary_files/PolygonalCategory.png)
    
Perspective Geometry
=====

- An abstraction of pin-hole camera

Perspective Projection
=====

The image plane may be thought of either behind a focal point or in between the a vanishing point and the object

One-point, two-point and three-point projection variants arise according to how many times the viewplane cuts the axis

One Point
![one point perspective projection](https://github.com/yxliang01/UnimelbSharedFiles/raw/master/Graphics%20and%20Interaction/Summary_files/onePointPerspectiveProjection.png)

Two Point
![Two point perspective projection](https://github.com/yxliang01/UnimelbSharedFiles/raw/master/Graphics%20and%20Interaction/Summary_files/twoPointPerspectiveProjection.png)

Three Point
![Three point perspective projection](https://github.com/yxliang01/UnimelbSharedFiles/raw/master/Graphics%20and%20Interaction/Summary_files/threePointPerspectiveProjection.png)


Perspective Formula
-----

only apply for camera-centered coordinates(the camera is at the origin)

$ \frac{x}{f} = \frac{X}{Z} $
$ \frac{y}{f} = \frac{Y}{Z} $
$ OR $
$ x = \frac{Xf}{Z} $
$ y = \frac{Yf}{Z} $

Vanishing point
-----

- In 3D, *parallel lines meet only at infinity*, so the *vanishing point can be thought of as the projection of a point at infinity*
- If the set of lines is *parallel to one of the three principal axes*, the vanishing point is called an *axis vanishing point*
- There are an infinity of vanishing points, one for each of the infinity of directions in which a line can be oriented

Perspectives
-----

### human eye

- Spherical project
- Human eye doesn't exactly match perspective projection
- perspective is basically the right projection for putting a 3D scene onto a float surface for human viewing

![Class of Projection](https://github.com/yxliang01/UnimelbSharedFiles/raw/master/Graphics%20and%20Interaction/Summary_files/classOfProjection.png)

Orthographic (parallel) projection
=====

$$ x = X $$
$$ y = Y $$

so it just drops Z coordinate


Polygons
=====

- useful to represent **two-dimensional shapes** and **three-dimensional objects**
- convex polygon has *no internal angle* is greater than 180 degrees
- concave polygon there is *at least an internal angle* is greater than 180 degrees
- concave polygon can be represented as a conjunction of convex polygon(convex polygons are easier to handle)
- Vertex collapse/spit method
    + number of Polygons can be reduced by collapsing vertices
    + if the result is not satisfactory, it will be spitted again
- Representation
    + Line segments
    + Ordered sequence of vertices using absolute or relative coordinates
    + Walking order convention (???)
        * anti-clockwise for outer
        * clockwise for inner
    + Polygon mesh
        * Vertex list
        * Edge list
            - polygon clipping and scan-line filling operations easier
    + Polygon types
        * Convex
            - no internal angle is greater than 180 degrees
            - have certain properties that simplify geometric operations and tessellations
        * Non-simple
        * Star
        * Concave
            - internal angles can be greater than 180 degrees
            - can be represented as a conjunction of convex polygons
        * Multiple-boundary
    + Vertex spit method
        * we can collapse vertex to reduce the number of polygons to increase performance
        * by split, increase the details but slower
    + 

Camera
=====

Defined via view parameters `EYE`, `AT` and `UP`, measured in *world space*.
It's located at `EYE`, *pointing at `AT`*, with upward-orientation of roughly `UP`.

In camera space, *camera is located at origin*, *pointing at the opposite of `AT`*, with upward-orientation of roughly `UP`

![Camera Space and World Space](https://github.com/yxliang01/UnimelbSharedFiles/raw/master/Graphics%20and%20Interaction/Summary_files/CameraSpaceAndWorldSpace.png)

$$ aspect = width/height $$

D3D Pipelining
=====

Everything is made up of triangles.
We mainly use triangle lists to represent objects

![DirectX11 Rendering Pipeline](https://github.com/yxliang01/UnimelbSharedFiles/raw/master/Graphics%20and%20Interaction/Summary_files/DirectX-11-Rendering-Pipeline.png)

Input Assembler
-----

- reads data from our buffers into a primitive format that can be used by the other stages of the pipeline
- mainly use triangle lists

Vertex Shader
-----

- performs operations on *individual vertices* received from the Input Assembler stage
- typically include transformations
- may include per-vertex lighting

#### Vertex Shader Transformations

Convert objects that are created in their local spaces into the common world space via *translation*, *scaling* and *rotation*.
And, convert to camera space

Tessellation stages
-----

- Optional stages added with Direct3D 11
- Allows to generate additional vertices within the GPU
- Can take a lower detail model and render in higher detail
- Can perform level of detail scaling

Geometry Shader
-----

- Optional stage added with Direct3D 10
- Can perform operation on an entire primitive
- Can perform a number of algorithms


Stream Output Stage
-----

- Allow to receive data (vertices or primitives) from the *geometry shader* or *vertex shader* and feed back into pipeline for processing by another set of shaders
- Useful e.g. Particle System

Rasterizer Stage
-----

- Convert objects into pixels
- *Interpolates* data between vertices to produce per-pixel data
- Performs culling
- ![View Frustum](https://github.com/yxliang01/UnimelbSharedFiles/raw/master/Graphics%20and%20Interaction/Summary_files/View%20Frustum.png)

Culling
-----

- Avoid rendering vertices that will not be displayed in the final image
- Triangle facing away from the camera will be culled and not rendered
- by default, DirectX performs ***Counter-clockwise culling (vertices in a counter-clockwise order are not rendered)***
- order of vertices is therefore important
- Unity using Left Hand Rule
- Blender using Right Hand Rule

Pixel(Fragment) shader
-----

- Produces color values for each interpolated pixel fragment
- Per-pixel lighting can be performed
- Can also produce depth values for depth-buffering


Output-Merger Stage
-----

- When objects are overlapping, it will only render the pixels having the lowest depth value(except alpha-blending (transparency))
- **Combines pixel shader output values to produce final image**
- May perform depth buffering

Double buffering
-----

- Don't want to draw objects directly to the screen
- Screen can update before a new frame has been completely drawn
- Now, draw next frame to a buffer and swap buffers when complete
This can avoid tearing
- Avoid tearing


CG/HLSL
=====

- `SubShader`
    + different Subshaders are for different platform
- `Pass`
    + a subshader can be split into multiple passes, rendering the geometry more than once
- `CGPROGRAM`
    + here we specify the code for different levels of the pipeline
    + we need at least vertex shader and pixel shader to render the geometry
- `#pragma target SM_VERSION`
    + the SM(Shader Model) that we are using
    + `2.0` is the minimal setting
- Datatype examples
    + `bool`
        * `bool2`
    + `int`
    + `half`
    + `float`
        * `float2x2`
        * `float3x3`
        * `float3`
    + `double`
    + `Vector`
- function examples
    + `cos(x)`
    + `sin(x)`
    + `cross(a, b)`
    + `dot(a, b)`
    + `normalize(v)`


2D Geometry
=====

- Representation of points
    + Absolution position
        * Cartesian coordinates $ (x,y) $
        * polar coordinates $ (p, \theta) $
            - convert to Cartesian coordinates
            - $\begin{bmatrix} p\cos(\theta) \\\\ p\sin(\theta) \end{bmatrix}$
    + Relative displacement
        * Vector
            - can have vector addition, subtraction, scalar product(dot product), norm(magnitude)
- Representation of curves
    + explicit functional form
        * $ y = F(x) $
    + implicit equational form
        * $ G(x,y) = 0 $
    + parametric form
        * $ x = x(t) $
          $ y = y(t) $ 
- Geometric Transformations
    + General geometric transformations concern object points rather than transformation of the entire coordinate frame
    + translations
    + linear transformations
        * such as *scaling*, *shear*, *rotation*, *reflection*
    + two conventions
        * vectors as columns
            - matrices are multiply on the left
        * vectors as rows
            - matrices are multiply on the right
    + Rigid body transformation
        * *Rotation*, *Translation* and *Reflection* preserve distances
    ![Trigo formulas](https://github.com/yxliang01/UnimelbSharedFiles/raw/master/Graphics%20and%20Interaction/Summary_files/Trigo%20Formulas.png)
    + Rotation
        * affine
        * rotation matrix
        $$ \begin{bmatrix} 
        \cos(\theta) & -sin(\theta) \\\\
        sin(\theta) & cos(\theta) 
        \end{bmatrix} $$
        * rotation around an arbitrary 2D point can be done by translating the point to the origin -> rotate -> translate back to the original position
        * ![Rotation around an arbitrary 2D point in homogeneous coordinate](https://github.com/yxliang01/UnimelbSharedFiles/raw/master/Graphics%20and%20Interaction/Summary_files/RotationAboutArbitraryPoint.png)
    + Reflection
        * affine
        * in the x-axis
            - $ x' = x, y' = -y $
        * in the y-axis
            - $ x' = -x, y' = y $
        * in the line $ y = x $
            - $ x' = y, y' = x $
    + Homogeneous coordinates
        * introduces a third dummy coordinate $ w $ represented as $ (x,y,w) $
        * the overall scale is unimportant -> $ (x,y,1) = (ax,ay,a) $
        * translation can be done by multiplication
            - combining translation and rotation is therefore easier
            - ![Translation in homogeneous coordinates](https://github.com/yxliang01/UnimelbSharedFiles/raw/master/Graphics%20and%20Interaction/Summary_files/translationInHomogeneousCoordinates.png)
        * rotation
            - $ R = \begin{bmatrix} \cos(\theta) & -\sin(\theta) & 0 \\\\ \sin(\theta) & \cos(\theta) & 0 \\\\ 0 & 0 & 1 \end{bmatrix} $
            - Inverse rotation $ R^{-1} = R^{T} $
    + Affine transformations
        * preserves
            - collinearity between points
                + i.e. three points which lie on a line continue to be collinear after the transformation
            - ratios of distances between any two points
        * translation, rotation, scaling and shear are affine transformations
    + Scaling
        * not affine
        * known as dilation, magnification, shrinking
        * $ x' = x_{s}x, y' = y_{s}y $
        * homogeneous coordinate
            - $ \begin{bmatrix} x_{s} & 0 & 0 \\\\ 0 & y_{s} & 0 \\\\ 0 & 0 & 1 \end{bmatrix} $
        * if $ x_{s} = y_{s} $ -> get isotropic scaling
        * invert by using reciprocals of scale factors $ 1/x_{s} $ and $ 1/y_{s} $
    + Shear
        * not affine
        * horizontal shear
            - $ x' = x + x_{h}y, y' = y $
            - everything keeps its vertical position, but is dragged sideways in proportion to its vertical position
            - homogeneous coordinate
                + $ \begin{bmatrix} 1 & x_{h} & 0 \\\\ 0 & 1 & 0 \\\\ 0 & 0 & 1 \end{bmatrix} \begin{bmatrix} x \\\\ y \\\\ 1 \end{bmatrix} = \begin{bmatrix} (x+x_{h}*y) \\\\ (y) \\\\ 1 \end{bmatrix}$
        * vertical shear
            - refer to horizontal shear
            - homogeneous coordinate
                + $ \begin{bmatrix} 1 & 0 & 0 \\\\ y_{h} & 1 & 0 \\\\ 0 & 0 & 1 \end{bmatrix} \begin{bmatrix} x \\\\ y \\\\ 1 \end{bmatrix} = \begin{bmatrix} (x) \\\\ (y_{h}*x + y) \\\\ 1 \end{bmatrix} $
                + 
    + Translation
        * affine
        * homogeneous coordinate
            - $ \begin{bmatrix} 1 & 0 & x_{t} \\\\ 0 & 1 & y_{t} \\\\ 0 & 0 & 1 \end{bmatrix} $
    + Commutivity of transformation matrices
        * Normally they are not commutable
        * However, commutivity holds for $ M_1, M_2 $ (such that $ M_1 M_2 = M_2 M_1 $) when

        |          $ M_1 $          |  $ M_2 $  |
        |---------------------------|-----------|
        | Translate                 | Translate |
        | Scale                     | Scale     |
        | Rotate                    | Rotate    |
        | Scale(with $ S_x = S_y $) | Rotate    |

    + Drawing circle can be done by
        * draw points such that each point is the rotated version of the previous point
        * then connect all the points
        * now, we get a circle!
    + Drawing a ellipse
        * draw a circle first
        * for all points, multiply by a **scaling** matrix then multiply by a **rotation** $ R_{\theta} $ to orient the point along the path of the ellipse 

Rendering
=====

Shading model versus illumination model
-----

- the illumination model captures how light sources interacts with object surfaces
- the shading model determines how to render the faces of each polygon in the scene
- the shading model depends on illumination model
    + for example
        * 1.
            - some shading models invoke an illumination model for every pixel (such as ray tracing)
            - others only use the illumination model for some pixels and the shade the remaining pixels by interpolation (such as Gouraud shading)
        * 2.
            - the illumination model is about determining how light sources interacts with object surfaces
            - whereas shading is about how to interpolate over the faces of polygons, given the illumination
- shading affected by
    + surface material properties
        * surface types
            - self-luminous
                + e.g. jelly fish that glow in dark or radioactive isotopes
            - transparent refractive
                + e.g. glass or water
            - transparent translucent
                + light interacts in more complex way
                + e.g. scatter
            - reflective
                + diffuse
                    * e.g. carpet
                + specular
                    * e.g. polished steel
            - textured
        * isotropic surfaces
            - relationship between the incoming and outgoing direction of light is the same over the whole surface (otherwise anisotropic)
            - illumination models generally most often consider isotropic surfaces 
    + orientation of surfaces
    + nature and direction of light sources
    + view direction
    + shadows
- choice of illumination model is a compromise between modeling the physics fully, and the computational cost
    + simple illumination models do not consider shadows, reflections or photon-based effects
    + in full ray tracing one consider all rays of light and their recursive interaction between each object -> very computationally complex
    + in limit can't model exactly, so have to make decision about model limitations no matter what
- Ambient illumination
    + simplest kind of shading
    + ambient illumination -> light that comes uniformly from all directions
    + radiated light intensity $ I = I_a k_a $ at a point on a surface depends on
        1. the intensity of the illumination $ I_a $ 
        2. the reflectivity $ K_a $(or albedo) of the surface -> the fraction of the incoming light which the object reflects, near zero for black objects, near one for white objects
    + it's actually mathematically an extended form of Lambertian reflection, integrating contributions from an infinite number of infinitesimal point light sources in all directions, instead of a single point light source
    + ambient shading assume that light comes uniformly from all directions
- Lambertian reflection
    + for a given surface, the brightness depends only on the angle $ \theta $ between the direction $ L $ to the light source and the surface normal $ N $
    + In Lambertian reflection light is re-radiated uniformly in all directions
    + $ I = I_p K_d \cos(\theta) = I_p K_d (\vec{N} \cdot \vec{L}) $
    + It's independent from surface orientation
        * TODO
    + independence of distance of viewer from surface
        * the intensity of light falls off as an inverse-square law in distance
        * In the meantime, the amount of surface included grows in proportion to the square of the distance
        * These two compensates
    + dependence of distance of light souce from surface
        * the intensity of the incoming light does depend on the distance of the surface from the light source
        * however, if this is used in rendering, the intensity will drop unrealistically fast
        * Therefore, many systems use a factor of the form $ \frac{1}{C+U} $
        * If the light source is sufficiently distant, then all parts of the object can be regarded as equally far from the light source
        * The effect of distance is the same for all points, so can essentially be absorbed into the light-source intensity factor $ I_p $
- Specular reflection
    + when a ray of light hits a surface, some fraction of it is also reflected immediately at the outer boundary of the surface -> specular reflection
    + leads to highlights and glossiness
    + It the surface were a perfect mirror, then the reflection would follow the law of perfect reflection
        * angle of incidence = angle of reflection
    + For most glossy surfaces, the reflected light is spread out. However, the reflection is strongest in the direction of perfect reflection and becomes weaker for directions away from this
    + if the angle from the surface to the viewer is $ \alpha $, the reflected intensity will be multiplied with the factor $ (\cos(\alpha))^n $ (1 is its maximum).
    + the exponent $ n $ is the specular reflection exponent and controls the degree of spread
        * higher value of $ n $ lead to a rapid fall-off and sharp highlights corresponding to a very glossy surface
        * lower value lead to a slow fall-off and spread-out, more diffuse highlights, a more matte surface appearance
    + it's independent of material color
        * because it doesn't involve interaction with the body of the material
        * color of specular reflection depends on the color of the incoming light, not on the color of the material
- Phong illumination model and specular reflection
    + formula
        * $$ I_\lambda = I_{\alpha\lambda} k_\alpha O_{d\lambda} + f_{att} I_{p\lambda}[k_d O_{d\lambda} \cos(\theta) + W(\theta) \cos^n(\alpha)] $$
        * $ I_{\alpha\lambda} $ is the ambient light, as a function of wavelength
        * $ I_{p\lambda} $ is the point light source
        * $ O_{d\lambda} $ is objects diffuse color
        * $ W(\theta) $ is the fraction of specularly reflected light
        * $ k_d $ is the diffuse-reflection coefficient
        * $ k_s $ is the specular reflection coefficient
        * $ n $ is the specular-reflection exponent
        * $ f_{att} $ is the light source attenuation factor (a function of distance)
        * the next one is a faster implementation. It's faster since computing dot products is significantly faster than computing trigonometric functions
        * $$ I_\lambda = I_{\alpha\lambda} k_\alpha O_{d\lambda} + f_{att} I_{p\lambda}[k_d O_{d\lambda}(\vec{N}\cdot\vec{L}) + k_s(\vec{R}\cdot\vec{V})^n] $$
        * $ W(\theta) = k_s $ which ranges between 0 and 1
        * assures a maximum specular reflection occurs when $ \alpha $ is zero and falls off sharply as $ \alpha $ increases
        * need to first identify that amount of incident light specularly reflected depends on the angle of incidence $ \theta $
        * the direction of reflection $ \vec{R} $ and the viewpoint direction $ \vec{V} $ are normalized -> $ \cos(\alpha) = \vec{R} \cdot \vec{V} $
        * ![Surface Illumination](https://github.com/yxliang01/UnimelbSharedFiles/raw/master/Graphics%20and%20Interaction/Summary_files/SurfaceIllumination.png)
    + for multiple light sources, just simply add them together resulting in less any shadowing
    + in certain circumstances TODO

Shading techniques
=====

flat shading vs full shading
-----
- in flat shading, compute the shading at some representative points(vertex or the centroid of the face) of each polygon face, then use this computed value to fill the whole polygon
    + same value is used to render the entire polygon
    + misses out on shading variations
    + realistic only for distant viewer and distant light source
- in full shading, do the complete shading calculation at *each pixel* as the polygon is displayed

Gouraud shading and Phong shading
-----
- if the polyhedron is intended as an approximation to a curved object, flat shading and full shading are not appropriate. The discontinuities in surface normal where the face meet will lead to artefactual discontinuities
- two cures for this: Gouraud shading and Phong shading
- they both compute an average surface normal at each visible vertex by averaging the normals of the faces that meet there
- Phong shading requires calculation of the illumination model at **each pixel** while Gouraud shading only at **each vertex**

### Gouraud shading (intensity interpolated shading)
- The normal is calculated by calculating cross of two adjacent vectors of the surface 
- ![Gouraud Shading Normal Calculation](https://github.com/yxliang01/UnimelbSharedFiles/raw/master/Graphics%20and%20Interaction/Summary_files/GouraudShadingCalculateNormal.png)
- it's dependent of orientation
- it has perspective distortion when you have a polygon with vertex 1 more distant than vertex 2 -> polygonal silhouettes and edges can look weird

### Phong shading
- similar to Gouraud shading, except interpolate the surface normals and do full shading calculation at every pixel using these interpolated normals
- intensity interpolation (Gouraud shading) can be used with specular reflection buy get less pronounced highlights


3D Transformation
=====

Homogeneous version
----

we define coordinates $ (X,Y,Z,W) $ corresponds to the Cartesian point (X/W, Y/W, Z/W) for $ W \ne 0 $

Translation
-----

$$ \begin{bmatrix} x' \\\\ y' \\\\ z' \\\\ 1 \end{bmatrix} = \begin{bmatrix} 1 & 0 & 0 & x_t\\\\0&1&0&y_t\\\\0&0&1&z_t\\\\0&0&0&1\end{bmatrix} \begin{bmatrix}x\\\\y\\\\z\\\\1\end{bmatrix} $$

Scaling
-----

$$ \begin{bmatrix} x' \\\\ y' \\\\ z' \\\\ 1 \end{bmatrix} = \begin{bmatrix} x_s&0&0&0\\\\0&y_s&0&0\\\\0&0&z_t&0\\\\0&0&0&1\end{bmatrix} \begin{bmatrix}x\\\\y\\\\z\\\\1\end{bmatrix} $$

Rotation
-----
- convention: clockwise looking along axis of rotation is positive using right-hand rule for coordinates which is consistent with ordinary 2D anti-clockwise convention
- rotation about an arbitrary axis
    + two rotations about coordinate axes to line up axis of rotation with one of the coordinate axes -> one rotation around this last axis, two rotations to undo the first two, and put the axis of rotation back where it was
    + if the axis doesn't pass through the origin, we need appropriate translation and its inverse around all this

Matrix for rotation about Z axis
$$ \begin{bmatrix} x' \\\\ y' \\\\ z' \\\\ 1 \end{bmatrix} = \begin{bmatrix} \cos(\theta)&-\sin(\theta)&0&0\\\\sin(\theta)&\cos(\theta)&0&0\\\\0&0&1&0\\\\0&0&0&1\end{bmatrix} \begin{bmatrix}x\\\\y\\\\z\\\\1\end{bmatrix} $$

Matrix for rotation about Y axis
$$ \begin{bmatrix} x' \\\\ y' \\\\ z' \\\\ 1 \end{bmatrix} = \begin{bmatrix} \cos(\theta)&0&\sin(\theta)&0\\\\0&1&0&0\\\\-sin(\theta)&0&\cos(\theta)&0\\\\0&0&0&1\end{bmatrix} \begin{bmatrix}x\\\\y\\\\z\\\\1\end{bmatrix} $$

Matrix for rotation about X axis
$$ \begin{bmatrix} x' \\\\ y' \\\\ z' \\\\ 1 \end{bmatrix} = \begin{bmatrix} 1&0&0&0\\\\0&\cos(\theta)&-\sin(\theta)&0\\\\0&\sin(\theta)&\cos(\theta)&0\\\\0&0&0&1\end{bmatrix} \begin{bmatrix}x\\\\y\\\\z\\\\1\end{bmatrix} $$

- Gimbal Lock
    + a case where we can only perform rotation in 2 dimensions
    + in order to unlock, we have to perform a rotation 
    + if we combine rotation matrices as $ R = R_x(\phi)\cdot R_y(\theta)\cdot R_z(\alpha) $ we have 
    ![Gimbal Lock Matrix](https://github.com/yxliang01/UnimelbSharedFiles/raw/master/Graphics%20and%20Interaction/Summary_files/GimbalLockMatrix.png)
    As you can see, it's now a 2D rotation matrix.
    So, Gimbal lock will happen when the $ \theta $ here is $ 0 $.
    
- Quaternion
    + advantage
        * can avoid Gimbal lock
        * more efficient to calculate
        * not dependant on axis rotation order
        * easy to interpolate rotations
    + is an extension on complex numbers of the form $ q = s + v_1 i + v_2 j + v_3 k $ where $ i,j,k $ are imaginary orthogonal unit vectors
    + rules
        * $ i^2 = j^2 = k^2 = ijk = -1 $
        * $ ij = k, ji = -k $
        * $ jk = i, kj = -i $
        * $ ki = j, ik = -j $
        * $ |q| = \sqrt{s^2+v^2} $
        * $ q_1 q_2 = (s_1 s_2 - v_1\cdot v_2, s_1 v_2 + s_2 v_1 + v_1 * v_2) $ 
    + Quaternion multiplication is not **commutative**
    + conjucate of a quaternion $ q = (s,v) $ is $ q* = (s,-v) $ 
    + the inverse of $ q $ is $ q^{-1} = \frac{q*}{|q|^2} $
    + rotate a point $ (x,y,z) $ by angle $ \theta $ counterclockwise around an arbitrary axis defined by unit vector $ u $ we compute $ P' = qPq^{-1} $ where $ P = (0,x,y,z) $ is a quaternion that represents the point 
    $$ q = (\cos(\frac{\theta}{2}), \sin(\frac{\theta}{2})U) $$ 
    $$ q^-1 = (\cos(\frac{\theta}{2}), -\sin(\frac{\theta}{2})U) $$
    ![Combine multiple Quaternion rotation](https://github.com/yxliang01/UnimelbSharedFiles/raw/master/Graphics%20and%20Interaction/Summary_files/QuaternionMultiplication.png)
- Arbitrary camera orientation
    + An objects' position must be transformed into camera-centered coordinates before a projection can be done which needs
        * a translation (to put cameras optical center at origin)
        * a three-dimensional rotation to line up Z-axis with optical axis (requires two coordinate axis rotations)
        * another rotation around Z-axis to line up X and Y axes
    + perspective projection can be expressed as a matrix operation in homogeneous coordinates, where the point $ (X,Y,Z) $ is represented by the homogeneous coordinates $ (wX, wY, wZ, w) $ where $ w \ne 0 $ and is typically $ 1 $
- ![Perspective Project 3D to 2D homogeneous](https://github.com/yxliang01/UnimelbSharedFiles/raw/master/Graphics%20and%20Interaction/Summary_files/PerspectiveProject3DTo2DHomogeneous.png)
- pseudo-depth
    + make perspective projection into an **invertible affine transformation**
    + it stores unused Z dimension in two-dimensions until you need it to go back to three-dimensions again