Graphics and Interactions
=====

[TOC]

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
- Gouraud shading
    + per-vertex lighting
- aliasing
    + sampling error when mapping texture images to screen
- Degree of freedom in mechanics
    + the number of independent parameters that defines its configuration
    

Perspective Projection
=====

Perspective Geometry
-----
- An abstraction of pin-hole camera
- Basically, objects that are nearer will be larger in the view than objects that are further
- we can **zoom by adjusting the focal length**

The image plane may be thought of either behind a focal point or in between the a vanishing point and the object

Vanishing point
-----
- In 3D, *parallel lines meet only at infinity*, so the *vanishing point can be thought of as the projection of a point at infinity*
- If the set of lines is *parallel to one of the three principal axes*, the vanishing point is called an *axis vanishing point*
- There are an infinity of possible vanishing points, one for each of the infinity of directions in which a line can be oriented One-point, two-point and three-point projection variants arise according to how many times the view plane cuts the axis

### One Point

![one point perspective projection](https://github.com/yxliang01/UnimelbSharedFiles/raw/master/Graphics%20and%20Interaction/Summary_files/onePointPerspectiveProjection.png)
![One point centered perspective projection example](https://github.com/yxliang01/UnimelbSharedFiles/raw/master/Graphics%20and%20Interaction/Summary_files/onePointPerspectiveProjection.png)

- Polygonal arcs (polylines)
- Polygonal boundaries (closed polylines)
- filled polygons

### Two Point
![Two point perspective projection](https://github.com/yxliang01/UnimelbSharedFiles/raw/master/Graphics%20and%20Interaction/Summary_files/twoPointPerspectiveProjection.png)

### Three Point
![Three point perspective projection](https://github.com/yxliang01/UnimelbSharedFiles/raw/master/Graphics%20and%20Interaction/Summary_files/threePointPerspectiveProjection.png)


Perspective Formula
-----

**only apply for camera-centered coordinates(the camera is at the origin)**
 
$ \frac{x}{f} = \frac{X}{Z} $
$ \frac{y}{f} = \frac{Y}{Z} $
$ OR $
$ x = \frac{Xf}{Z} $
$ y = \frac{Yf}{Z} $

Parallel Projection
-----

Basically, center of projection is at infinity.
This is sometimes useful in engineering purpose.
You want the object shown reflects to its actual size.

### Orthographic projection

$$ x = X $$
$$ y = Y $$

so it just drops Z coordinate

Human Eye
-----
- Spherical project
- Human eye doesn't exactly match perspective projection
    + retina is curved
    + projection center isn't at center of the eyeball
    + only a problem for very wide fields of view 
- perspective is basically the right projection for *putting a 3D scene onto a flat surface* for human viewing

![Classes of Projection](https://github.com/yxliang01/UnimelbSharedFiles/raw/master/Graphics%20and%20Interaction/Summary_files/classOfProjection.png)



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
    + Walking order convention
        * the sequence of defining vertices matters
        * anti-clockwise for outer
        * clockwise for inner
    + Polygon mesh representations
        * As vertex list
        * As edge list
            - polygon clipping and scan-line filling operations easier
    + Vertex spit method
        * we can **collapse** vertex to reduce the number of polygons to increase performance
        * by **split**, increase the details but slower
- Polygon types
    + Convex
        * **no internal angle is greater than 180 degrees**
        * have certain properties that simplify geometric operations and tessellations
    + Non-simple
    + Star
    + Concave
        * internal angles **can be greater than 180 degrees**
        * can be represented as a conjunction of convex polygons
    + Multiple-boundary

Camera
=====

Defined via view parameters `EYE`, `AT` and `UP`, measured in *world space*.
It's located at `EYE`, *pointing at `AT`*, with upward-orientation of roughly `UP`.

In camera space, *camera is located at origin*, *pointing at the opposite of `AT`*, with upward-orientation of roughly `UP`

![Camera Space and World Space](https://github.com/yxliang01/UnimelbSharedFiles/raw/master/Graphics%20and%20Interaction/Summary_files/CameraSpaceAndWorldSpace.png)

$$ aspect = width/height $$

Direct3D Pipelining
=====

Everything is rendered using triangles.
We mainly use triangle lists to represent objects

![DirectX11 Rendering Pipeline](https://github.com/yxliang01/UnimelbSharedFiles/raw/master/Graphics%20and%20Interaction/Summary_files/DirectX-11-Rendering-Pipeline.png)

Input Assembler
-----

- reads data from our buffers into a primitive format that can be used by the other stages of the pipeline
- mainly use triangle lists

Vertex Shader
-----
- performs operations on *individual vertices* received from the **Input Assembler** stage
- typically include transformations
- may include per-vertex lighting

#### Vertex Shader Transformations

Convert objects that are created in their local spaces into the common world space via *translation*, *scaling* and *rotation*.
Then, convert to camera space

Tessellation stages
----- 
- Optional stages added with Direct3D 11
- Allows to generate additional vertices within the GPU
- Can take a lower detail model and render in higher detail
- Can perform level of detail scaling

Geometry Shader
-----
- Optional stage added with Direct3D 10
- Can perform operation **on an entire primitive**
- Can perform a number of algorithms
    + can dynamically calculating normals
    + particle systems
    + shadow volume generation


Stream Output Stage
-----
- Allow to receive data (vertices or primitives) from the *geometry shader* or *vertex shader* and **feed back into pipeline for processing by another set of shaders**
- Useful e.g. Particle System

Rasterizer Stage
-----
- Convert objects into pixels
- *Interpolates* data between vertices to produce per-pixel data
- Clips primitives into view frustum
- Performs culling
- ![View Frustum](https://github.com/yxliang01/UnimelbSharedFiles/raw/master/Graphics%20and%20Interaction/Summary_files/View%20Frustum.png)
- steps
    + determines the pixels covered by a primitive
    + interpolates the output parameters of the vertex shader for each covered pixel
    + give output parameters of the vertex shader to the fragment shader using barycentric coordinate system
- two additional operations
    + visibility
    + anti-aliasing

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
- **Can also produce depth values** for depth-buffering


Output-Merger Stage
-----
- When objects are overlapping, it will only render the pixels having the lowest depth value(except alpha-blending (transparency))
- **Combines pixel shader output values to produce final image**
- May perform depth buffering

Double buffering
-----
- Don't want to draw objects directly to the screen
- **Screen can update before a new frame has been completely drawn**
- Now, draw next frame to a buffer and swap buffers when complete
- **Avoid tearing**


CG/HLSL (Not Examinable)
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

Rasterization
=====
- pixel-based interpolation schemes have problems including
    + orientation dependence
    + perspective distortion
    + unrepresentative surface normals
- Rasterization is the stage
    + first determines the pixels covered by a primitive and **interpolates the output parameters** of the vertex shader for each covered pixel
    + interpolated output parameters pass to the fragment shader **using barycentric coordinate system**
    
Barycentric coordinate
=====
For a triangle, there are three vertices, $ V_1, V_2, V_3 $. For $ a_1 = \frac{\Delta P V_2 V_3}{\Delta Triangle}, a_2 = \frac{\Delta P V_1 V_3}{\Delta Triangle}, a_3 = \frac{\Delta P V_1 V_2}{\Delta Triangle} $. Let say the outputs of some value are $ f_1, f_2, f_3 $ corresponding to each of the vertices. Then the value at point $ P $ will be $ f_p = a_1 f_1 + a_2 f_2 + a_3 f_3 $. 

Therefore, the vertex that is closer to point $ P $ will have a greater impact on the value of point $ P $.  



General Geometry
=====

Transformation
-----
- Reflection
    + **reverses** handedness
- Rotation
    + **preserves** handedness
- Translation
    + **preserves** handedness
- Scaling
    + if $ x_{s} = y_{s} $ -> get isotropic scaling
    + invert by using reciprocals of scale factors $ 1/x_{s} $ and $ 1/y_{s} $
    + using scale factors of 1 gives an identity transformation
- Shear
    + rotations can be decomposed into shears and used for producing fast method of rotating, without need for using trigonometric function calls
- Affine transformations
    + preserves
        * collinearity between points
            - i.e. three points which lie on a line continue to be collinear after the transformation
        * ratios of distances between any two points
    + translation, rotation, scaling and shear are affine transformations
- Rigid body transformation
    + by doing *Rotation*, *Translation* and *Reflection*, distances between arbitrary two points on the body are preserved


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
        * $ x = x(t), y = y(t) $
    + e.g Straight lines
        * $ y = mx + b $ (explicit functional form)
        * $ ax + by + c = 0 $ (implicit equational form)
        * $ x \cos(\theta) + y \sin(\theta) = p $ (implicit equational form)
        * $ x = x_0 + x_1 p(t), y = y_0 + y_1 p(t) $ (parametric form) 
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
    ![Trigo formulas](https://github.com/yxliang01/UnimelbSharedFiles/raw/master/Graphics%20and%20Interaction/Summary_files/Trigo%20Formulas.png)
    + Rotation
        * rotation matrix
        $$ \begin{bmatrix} 
        \cos(\theta) & -\sin(\theta) \\\\
        \sin(\theta) & \cos(\theta) 
        \end{bmatrix} $$
        * rotation around an arbitrary 2D point can be done by translating the point to the origin -> rotate -> translate back to the original position
        * ![Rotation around an arbitrary 2D point in homogeneous coordinate](https://github.com/yxliang01/UnimelbSharedFiles/raw/master/Graphics%20and%20Interaction/Summary_files/RotationAboutArbitraryPoint.png)
    + Reflection
        * **move point to position at equal distance on opposite side of the line**
        * reflect in the x-axis
            - $ x' = x, y' = -y $
        * reflect in the y-axis
            - $ x' = -x, y' = y $
        * reflect in the line $ y = x $
            - $ x' = y, y' = x $
    + Homogeneous coordinates
        * introduces a third dummy coordinate $ w $ represented as $ (x,y,w) $
        * the overall scale is unimportant -> $ (x,y,1) = (ax,ay,a) $
            - the last dimension is just like the scaling factor, the original coordinate correspond to the value when the $ w = 1 $
            - trying to get the original coordinate is called homogenize
        * translation can be done by multiplication (the main purpose of using homogeneous)
            - combining translation and rotation is therefore possible
            - ![Translation in homogeneous coordinates](https://github.com/yxliang01/UnimelbSharedFiles/raw/master/Graphics%20and%20Interaction/Summary_files/translationInHomogeneousCoordinates.png)
        * rotation
            - $ R = \begin{bmatrix} \cos(\theta) & -\sin(\theta) & 0 \\\\ \sin(\theta) & \cos(\theta) & 0 \\\\ 0 & 0 & 1 \end{bmatrix} $
            - Inverse rotation $ R^{-1} = R^{T} $
    + Scaling
        * known as **dilation**, **magnification**, **shrinking**
        * $ x' = x_{s}x, y' = y_{s}y $
        * homogeneous coordinate
            - $ \begin{bmatrix} x_{s} & 0 & 0 \\\\ 0 & y_{s} & 0 \\\\ 0 & 0 & 1 \end{bmatrix} $
        * ***Not*** Rigid body transformation
    + Shear
        * horizontal shear(change in horizontal direction)
            - $ x' = x + x_{h}y, y' = y $
            - everything keeps its vertical position, but is **dragged sideways in proportion to its vertical position**
            - homogeneous coordinate
                + $ \begin{bmatrix} 1 & x_{h} & 0 \\\\ 0 & 1 & 0 \\\\ 0 & 0 & 1 \end{bmatrix} \begin{bmatrix} x \\\\ y \\\\ 1 \end{bmatrix} = \begin{bmatrix} (x+x_{h}*y) \\\\ (y) \\\\ 1 \end{bmatrix}$
        * vertical shear(change in vertical direction)
            - refer to horizontal shear
            - homogeneous coordinate
                + $ \begin{bmatrix} 1 & 0 & 0 \\\\ y_{h} & 1 & 0 \\\\ 0 & 0 & 1 \end{bmatrix} \begin{bmatrix} x \\\\ y \\\\ 1 \end{bmatrix} = \begin{bmatrix} (x) \\\\ (y_{h}*x + y) \\\\ 1 \end{bmatrix} $
        * ***Not*** Rigid body transformation
    + Translation
        * homogeneous coordinate
            - $ \begin{bmatrix} 1 & 0 & x_{t} \\\\ 0 & 1 & y_{t} \\\\ 0 & 0 & 1 \end{bmatrix} $
    + Commutativity of transformation matrices
        * Normally they are not commutable i.e. $ M_1 * M_2 \ne M_2 * M_1 $
        * ***However, commutativity holds for $ M_1, M_2 $ (such that $ M_1 M_2 = M_2 M_1 $) when***

        |          $ M_1 $          |  $ M_2 $  |
        |---------------------------|-----------|
        | Translate                 | Translate |
        | Scale                     | Scale     |
        | Rotate                    | Rotate    |
        | Scale(with $ S_x = S_y $) | Rotate    |
        
        P.S. scaling when $ S_x = S_y $ is called isotropic scaling

    + Drawing circle can be done by
        * draw points such that each point is the rotated version of the previous point
        * then connect all the points
        * now, we get a circle!
    + Drawing a ellipse
        * draw a circle first
        * for all points, multiply by a **scaling** matrix then multiply by a **rotation** $ R_{\theta} $ to orient the point along the path of the ellipse
        * When generating the ellipse, we can have a point on the ellipse then get the next point on the ellipse by applying $ E = (SR_{\theta})^{-1} R_{\phi} (SR_{\theta}) $
            - the good thing is that $ E $ just needed to be computed once  

Color Vision
=====

light is electromagnetic radiation in the wavelength range of 400 nm (blue) to 700 nm (red).

Based on tri-stimulus theory 

Values Systems
-----
- RGB Model
- HSB Model
    + Hue
    + Saturation
    + Brightness
    + Closely related to human preprocessing of light

Texture
=====

Mappings
-----
- parametric texture mapping
    + scan textures from the world or paint them
    + store texture in a 2D image
    + map the image onto the surface by a function which maps $ (u, v) $ coordinates of our parametric surface onto $ (x, y) $ image coordinates
    + when shading a surface point, we look up the appropriate pixel from the 2D image, and use that to affect the final color
    + some objects have natural parameterizations
        * Sphere: use spherical coordinates $ (\phi , \theta ) = (2 \pi u, \pi v) $
        * Cylinder: use cylindrical coordinates $ (u, \theta) = (u, 2 \pi v) $
        * Parametric surface(e.g. B-spline or Bezier): use patch parameters $ (u, v) $
            - $ u = u_{min} + \frac{S - S_{min}}{S_{max} - S_{min}} (u_{max} - u_{min}) $
            - $ v = v_{min} + \frac{t - t_{min}}{t_{max} - t_{min}} (v_{max} - v_{min}) $
    + For arbitrary polygonal objects
        * steps
            - to a canonical shape
            - project normals from object
- Bump mapping
    + for making a surface look rough without actually changing the polygon
    + change the surface normal to achieve the effect of roughness
    + basically, use a map to indicate the normal vector for each pixel
    + normal map
    + height map
- Displacement mapping
    + displace each point in the direction of normal

Interpolation
=====
- How do we estimate $ f(x) $ for arbitrary $ x $
    + if $ x $ within range of $ x_i $, use interpolation
    + if $ x $ outside range of $ x_i $, use extrapolation 
- most common functional form used are polynomials
    + alternative will be e.g. rational functions, trigonometric functions
- We can make coordinates in different directions as a function of time
    + ![Two joined 2D parametric curve segments](https://github.com/yxliang01/UnimelbSharedFiles/raw/master/Graphics%20and%20Interaction/Summary_files/Two%20joined%202D%20parametric%20curve%20segments.PNG)
- parametric continuity
    + if the direction and magnitude of the $ \frac{d^n}{dt^n} [Q(t)] $ through the $ n $th derivative are equal at the join point, the curve is called $ c^n $ continuous
- Bezier curve
    + defined by the starting ($ \vec{P_1P_2} $) and ending vectors($ \vec{P_3P_4} $) of a curve
    + 4 control points
    + The curve starts from $ P_1 $ and ends at $ P_4 $
    + the curve itself not necessary to touch $ P_2 and P_3 $ 
- B-Splines
    + spline has second-order continuity
    + $ C^0 $, $ C^1 $ and $ C^2 $ continuous cubic polynomial that interpolates the control points
    + splines have one more degree of continuity than Bezier -> splines are smoother
    + in addition to control points, there are knots as well which are the points that the curve must go through
    + patch = segment
    + TODO
 
Kinematics
=====

As a robot

Forward Kinematics
-----
- you know how you should act before you move
- apply a behavior to my robot arm 
    + e.g. rotate one of my arms by pre-determined angles for each joint (degree of freedom)
- apply a steering behavior to my robot body
- ![Kinematics Joints Example](https://github.com/yxliang01/UnimelbSharedFiles/raw/master/Graphics%20and%20Interaction/Summary_files/Kinematics_Joints.PNG)
- Only requires matrix multiplication

Inverse Kinematics
-----
- You have the objective but you don't know how to/whether you can achieve it
- Questions like
    + how do I configure my robot arm to reach it?
        * have to determine all angles for my joints
    + Can my robot arm reach that object?
    + Is the object reachable from where I am?
- Aim to find out the transformation parameters
- Problems can arise in solving it e.g.
    + the existence of multiple solutions (joint configurations)
    + the possible non-existence of any solution (unreachable)
    + singularities of matrix equations
- Solving techniques
    + algebraic algorithms
        * for solving linear simultaneous questions using numerical methods
        * One way can use determinant to calculate the inverse matrix
            - check if $ | A | \ne 0 $  first to make sure inverse exists
            - $$ Ax = b \text{ where } A^{-1} = \frac{1}{det(A)} adj(A) $$
            - Well, you need to do $ n^3 x (multiplications + additions) $
            - Therefore, worse case complexity is $ O(n^3) $
            - Generally, calculating determinants directly(e.g. using cofactors) has complexity $ O(n!) $ !
                + $$ |A| = \sum_{i=1}^k a_{ij} C_{ij} \text{ where } C_{ij} \equiv (-1)^{i+j} M_{ij} $$
    + iterative algorithms
        * work by calculating an approximate solution which converges to the exact solution
        * typically be used for solving non-linear simultaneous questions or when numerical stability is paramount important


Rendering
=====

Shading model and illumination model
-----

- ***the illumination model captures how light sources interacts with object surfaces***
- ***the shading model determines how to render the faces of each polygon in the scene***
- **the shading model depends on illumination model(use illumination then shading)**
    + for example
        * 1.
            - some shading models invoke an illumination model for every pixel (such as ray tracing)
            - others only use the illumination model for some pixels and the shade of the remaining pixels by interpolation (such as Gouraud shading)
        * 2.
            - the illumination model is about determining how light sources interacts with object surfaces
            - whereas shading is about how to interpolate over the faces of polygons, given the illumination
- shading affected by
    + **illumination model**
    + **surface material properties**
        * in order to simulate the realistic effect, we often treat the surface as a mixture of different types
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
            - relationship between the **incoming and outgoing direction of light is the same over the whole surface** (otherwise anisotropic)
            - illumination models generally most often consider isotropic surfaces 
    + **orientation of surfaces**
    + **nature and direction of light sources**
    + **view direction**
    + **shadows**
- choice of illumination model is a compromise between **modeling the physics fully**, and the **computational cost**
    + simple illumination models do not consider shadows, reflections or photon-based effects
    + in full ray tracing one consider all rays of light and their recursive interaction between each object -> very computationally complex
    + in limit can't model exactly, so have to make decision about model limitations no matter what
- Ambient illumination
    + simplest kind of shading
    + ambient illumination -> **light that comes uniformly from all directions**
    + radiated light intensity $ I = I_a k_a $ at a point on a surface depends on
        1. the intensity of the illumination $ I_a $ 
        2. the reflectivity $ K_a $(or **albedo**) of the surface -> the fraction of the incoming light which the object reflects, near zero for black objects, near one for white objects
    + it's actually mathematically an extended form of Lambertian reflection, integrating contributions from an infinite number of infinitesimal point light sources in all directions, instead of a single point light source
    + ambient shading assumes that light comes uniformly from all directions
- Lambertian reflection
    + We *assume that the light source is a point*
    + for a given surface, the **brightness depends only on the angle $ \theta $ between the direction $ L $ to the light source and the surface normal $ N $**
    + In Lambertian reflection light is ***re-radiated uniformly in all directions***
    + $ I = I_p K_d \cos(\theta) = I_p K_d (\vec{N} \cdot \vec{L}) $
        * $ \vec{N} and \vec{L} $ are unit vectors representing direction of normal and direction of light source respectively
    + ***independence of surface orientation with respect to the viewer***
        * Although, the amount of light radiated towards the viewer is greatest when the surface normal is pointing straight at the viewer
        * However, as the visual angle subtended at the viewer, more radiated light can be received by the viewer due to the fact that the viewable area of the surface is larger (based on assumption that the surface is large enough)
        * And, those two effects compensate comes out that the lambertian reflection intensity is independent of surface orientation with respect to the viewer
        * ![lambertian reflection intensity is independent of surface orientation](https://github.com/yxliang01/UnimelbSharedFiles/raw/master/Graphics%20and%20Interaction/Summary_files/lambertian%20reflection%20intensity%20is%20independent%20of%20surface%20orientation.PNG)
    + ***independence of distance of viewer from surface***
        * the** intensity of light falls off as an inverse-square law in distance**
        * In the meantime, the **amount of surface included grows in proportion to the square of the distance** (based on assumption that the surface is large enough)
        * These two compensates
    + ***dependence of distance of light source from surface***
        * the intensity of the incoming light does depend on the distance of the surface from the light source
        * however, if this is used in rendering, the intensity will drop unrealistically fast since in real life, most light sourcecs are not a single point source
        * Therefore, many systems use a factor of the form $ \frac{1}{C+U} $ which gives reasonable result
        * If the light source is sufficiently distant, then all parts of the object can be regarded as equally far from the light source -> Can use the same $ C $ value
- Specular reflection
    + when a ray of light hits a surface, some fraction of it is also reflected immediately at the outer boundary of the surface -> specular reflection
    + leads to highlights and glossiness
    + It the surface were a perfect mirror, then the reflection would follow the law of perfect reflection
        * $ \theta_{incidence} = \theta_{reflection} $
    + *For most glossy surfaces, the reflected light is spread out*. However, the reflection is strongest in the direction of perfect reflection and becomes weaker for directions away from this
    + if the angle from the surface to the viewer is $ \alpha $, the reflected intensity will be multiplied with the factor $ (\cos(\alpha))^n $ (1 is its maximum).
        * the exponent $ n $ is the specular reflection exponent and controls the degree of spread
            - **higher value** of $ n $ lead to a **rapid fall-off** and **sharp highlights corresponding to a very glossy surface**
            - **lower value** lead to a **slow fall-off** and **spread-out**, **more diffuse highlights**, a more matte surface appearance
    + it's independent of material color
        * because it doesn't involve interaction with the body of the material
        * **color of specular reflection depends on the color of the incoming light, not on the color of the material**
- Phong illumination model and specular reflection
    + equations **for each color channel!!**
        * $$ I_\lambda = I_{\alpha\lambda} k_\alpha O_{d\lambda} + f_{att} I_{p\lambda}[k_d O_{d\lambda} \cos(\theta) + W(\theta) \cos^n(\alpha)] $$
        * $ I_{\alpha\lambda} $ is intensity of the ambient light, as a function of wavelength
        * $ I_{p\lambda} $ is intensity of the point light source
        * $ O_{d\lambda} $ is object's intensity of diffuse color at the corresponding color channel
        * $ W(\theta) $ is the fraction of specularly reflected light = the specular reflection coefficient = $ k_s $
        * $ k_d $ is the diffuse-reflection coefficient
        * $ n $ is the specular-reflection exponent
        * $ f_{att} $ is the light source attenuation factor (a function of distance)
        * the equation without trigonometric functions is a faster implementation. It's faster since computing dot products is significantly faster than computing trigonometric functions
        * $$ I_\lambda = I_{\alpha\lambda} k_\alpha O_{d\lambda} + f_{att} I_{p\lambda}[k_d O_{d\lambda}(\vec{N}\cdot\vec{L}) + k_s(\vec{R}\cdot\vec{V})^n] $$
        * $ W(\theta) = k_s $ which ranges between 0 and 1
        * assures a maximum specular reflection occurs when $ \alpha $ is zero and falls off sharply as $ \alpha $ increases
        * need to first identify that amount of incident light specularly reflected depends on the angle of incidence $ \theta $
        * the direction of reflection $ \vec{R} $ and the viewpoint direction $ \vec{V} $ are normalized -> $ \cos(\alpha) = \vec{R} \cdot \vec{V} $
        * ![Surface Illumination](https://github.com/yxliang01/UnimelbSharedFiles/raw/master/Graphics%20and%20Interaction/Summary_files/SurfaceIllumination.png)
    + for multiple light sources, just simply add them together resulting in less any shadowing

Shading techniques
-----

### flat shading vs full shading
- in flat shading, ***compute the shading at some representative points***(vertex or the centroid of the face) of each polygon face, then use this computed value to fill the whole polygon
    + same value is used to render the entire polygon
    + *misses out on shading variations*
    + therefore, ***realistic only for distant viewer and distant light source*** because when far away, viewer can't realize those small details and distant light source can be treated as a point and the shading variation between points is thus smaller
- in full shading, do the complete shading calculation at ***each pixel*** as the polygon is displayed

### Gouraud shading and Phong shading
- if the polyhedron is intended as an approximation to a curved object, **flat shading and full shading are not appropriate**. The discontinuities in surface normal where the face meet will lead to artefactual discontinuities
- two cures for this: Gouraud shading and Phong shading
- they both compute an average surface normal at each visible vertex by averaging the normals of the faces that meet there
- Phong shading requires *calculation of the illumination model* at **each pixel** while Gouraud shading only at **each vertex**

#### Gouraud shading (intensity interpolated shading)
- The **normal is calculated by calculating cross product of two vectors on the surface** 
- ![Gouraud Shading Normal Calculation](https://github.com/yxliang01/UnimelbSharedFiles/raw/master/Graphics%20and%20Interaction/Summary_files/GouraudShadingCalculateNormal.png)
- it's **dependent of the projected polygons position (therefore, and, orientation)**
- it has **perspective distortion** when you have a polygon with vertex 1 more distant than vertex 2 -> polygonal silhouettes and edges can look weird
- can be used with specular reflection but get less pronounced highlights since only the highlights on the vertices will be generated and those highlights will be spread out due to the interpolation of the reflection light intensity

#### Phong shading
- similar to Gouraud shading, except **interpolate the surface normals** and **do full shading calculation at every pixel using these interpolated normals**
- intensity interpolation (Gouraud shading) can be used with specular reflection buy get less pronounced highlights
- However, the actual surface normal on pixels might not be able to retrieve by interpolation (e.g. rock surfaces)
    + normal map can be used to solve this

Ray Tracing (Ray Casting)
=====
- Technique for generating an image by tracing the path of light through pixels in an image plane and simulating the effects of its encounters with virtual objects
- This is an alternative technique to rendering pipeline 
- The size of the ray tracing problem is determined by the number of pixels in the image or viewport, as opposed to the number of polygons in the scene as in the rendering pipeline approach. Also, the maximum depth of recursive rays traced.
- Accelerating techniques
    + pre-baking (pre-compute the lighting and store as texture)
    + bounding volumes (e.g. Binary space partition trees (BSPs))

Refraction
=====
- When going from one medium to another, a ray of light will be bent at the intermediate surface. 
- The bending is governed by Snell's Law $ \frac{\sin{\theta i}}{\sin{\theta t}} = \frac{\eta_{t\lambda}}{\eta_{i\lambda}} $

Transparency
-----
- $ T = te^{-ad} $
    + $ a $ is a parameter
    + $ d $ is the distance traveled within the material but $ \ne $ the thickness of the material because light may take an oblique path

Shadow volume
=====
- A technique to create shadows without the need to do full ray tracing
- Perform with stencil buffer


3D Transformation
=====

| Axis of rotation | Direction of positive rotation |
|------------------|--------------------------------|
| x                | y to z                         |
| y                | z to x                         |
| z                | x to y                         |

***Actually when the axis of rotation is facing to your eye, you will find that the direction of positive rotation is always anti-clockwise***

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
- Each rotation can only change coordinates in two directions (one axis must be fixed) 
- rotation about an arbitrary axis
    + if the axis doesn't pass through the origin, we need appropriate translation and its inverse around all this

### Rotation matrices for rotating counterclockwise using right-handed coordinate system

Matrix for rotation about Z axis
$$ \begin{bmatrix} x' \\\\ y' \\\\ z' \\\\ 1 \end{bmatrix} = \begin{bmatrix} \cos(\theta)&-\sin(\theta)&0&0\\\\sin(\theta)&\cos(\theta)&0&0\\\\0&0&1&0\\\\0&0&0&1\end{bmatrix} \begin{bmatrix}x\\\\y\\\\z\\\\1\end{bmatrix} $$

Matrix for rotation about Y axis
$$ \begin{bmatrix} x' \\\\ y' \\\\ z' \\\\ 1 \end{bmatrix} = \begin{bmatrix} \cos(\theta)&0&\sin(\theta)&0\\\\0&1&0&0\\\\-sin(\theta)&0&\cos(\theta)&0\\\\0&0&0&1\end{bmatrix} \begin{bmatrix}x\\\\y\\\\z\\\\1\end{bmatrix} $$

Matrix for rotation about X axis
$$ \begin{bmatrix} x' \\\\ y' \\\\ z' \\\\ 1 \end{bmatrix} = \begin{bmatrix} 1&0&0&0\\\\0&\cos(\theta)&-\sin(\theta)&0\\\\0&\sin(\theta)&\cos(\theta)&0\\\\0&0&0&1\end{bmatrix} \begin{bmatrix}x\\\\y\\\\z\\\\1\end{bmatrix} $$

Actually if you rotation about an axis $ A $, you don't want the coordinate on $ A $ changes and you don't want $ A $ affect values on other directions as well.

- Gimbal Lock (TODO)
    + a case where we can only perform rotation about two axes at a time in 3D space instead of three
        * in order to perform rotation about three axes, you have to apply rotation matrix at least twice
    + in order to unlock, we have to perform a rotation
    + it's always the problem with the most outer gimbal and the most inner gimbal
        * the reason why it will not append with adjacent gimbals is because their rotation directions must be perpendicular to each other
    + if we combine rotation matrices as $ R = R_x(\phi)\cdot R_y(\theta)\cdot R_z(\alpha) $ we have
    ![Gimbal Lock Matrix](https://github.com/yxliang01/UnimelbSharedFiles/raw/master/Graphics%20and%20Interaction/Summary_files/GimbalLockMatrix.png)
    As you can see, it's now a rotation matrix about only two axes instead of the original three axes.
    So, Gimbal lock will happen when the $ \theta $ here is $ 0 $.
    
- Quaternion
    + advantage
        * can avoid Gimbal lock
        * more efficient to calculate
        * not dependent on axis rotation order
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
        * a translation (to **put cameras optical center at origin**)
        * a three-dimensional rotation to line up Z-axis with optical axis (requires two coordinate axis rotations, they are x and y)
        * another rotation around Z-axis to line up X and Y axes
    + perspective projection can be expressed as a matrix operation in homogeneous coordinates, where the point $ (X,Y,Z) $ is represented by the homogeneous coordinates $ (wX, wY, wZ, w) $ where $ w \ne 0 $ and is typically $ 1 $
- ![Perspective Project 3D to 2D homogeneous](https://github.com/yxliang01/UnimelbSharedFiles/raw/master/Graphics%20and%20Interaction/Summary_files/PerspectiveProject3DTo2DHomogeneous.png)
- pseudo-depth
    + make perspective projection into an **invertible affine transformation**
    + it stores unused Z dimension in two-dimensions until you need it to **go back to three-dimensions again**

Exam Notes
=====
- For transformation type of questions
    + 2D
        * Rotation
            1. translate the point rotating about to origin
            2. rotate about the origin
            3. translate back to the original position
        * Scaling
            - *method is same as the rotation*
        * Shearing
            - *method is same as the rotation*
    + 3D
        * Rotation
            1. align the axis of rotation with one of the coordinate axes by doing 2 rotations (up to)
            2. translation to make the rotating axis pass through origin
            3. rotate about the axis
            4. Reverse the rotation done in Step 1 and 2
        * 