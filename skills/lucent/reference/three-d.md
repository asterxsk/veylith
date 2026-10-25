# 3D

Two paths. Decide which one *before* installing anything, because they are not interchangeable.

| | Spline | react-three-fiber |
|---|---|---|
| Authored by | Designer, in a GUI | Engineer, in code |
| Agent can build it from scratch | **No** — needs a supplied scene | Yes |
| Reacts to app data | Only via editor-defined variables | Fully |
| Time to integrate a supplied scene | Minutes | Hours |
| Bundle | Runtime + scene | three + fiber, ~600 KB min before compression |
| Right when | Art is done, integration is the job | The 3D is the product logic |

Default to **Spline** when the user supplies an authored scene. Default to **react-three-fiber**
when the 3D must respond to data, state, or scroll programmatically, or when there is no scene
and no designer.

**Neither** when a rendered image, a pre-baked turntable, or a video would do. A static product
shot costs no bundle, no context, and no runtime.

## react-three-fiber

[pmndrs/react-three-fiber](https://github.com/pmndrs/react-three-fiber) — React renderer for
three.js. Pair the fiber major to the React major: React 18 → fiber `^8` + drei `^9`; React 19 →
fiber `^9` + drei `^10`. drei v10 requires React 19. `@react-three/fiber@10` is alpha.

### Rules that actually bite

- **`<Canvas>` owns the render loop.** Never write your own `requestAnimationFrame` around it.
  Mutate refs in `useFrame`; never `setState` per frame.
- **Sizing is a resolved height.** `<Canvas>` fills its parent, and a flex child with no
  intrinsic height gives a 0×0 canvas. This is the most common "nothing appears."
- **SSR:** every three/R3F import touches `window` at import time. In Next App Router the canvas
  must be a client component *and* dynamically imported with `ssr: false` from inside a
  `'use client'` wrapper. Add `transpilePackages: ['three']` or the build fails on add-ons.
- **Cap DPR:** `dpr={[1, 1.5]}` for hero and product canvases. Never full retina on mobile.
- **`frameloop="demand"`** renders only on change — right for static or interaction-driven
  scenes. Call `invalidate()` after mutations React cannot see.
- **Lazy-mount.** A canvas below the fold should not build a GL context on page load.
- **Reuse geometry and materials** — every unique material is GPU state. `<Instances>` for
  anything repeated at scale.
- **`args` arrays must be hoisted.** An inline `args={[1, 2, 3]}` is a new array each render and
  reconstructs the object.
- **Adapt to the device:** `<PerformanceMonitor>` with `dpr`, or `useDetectGPU` to serve a static
  poster on weak GPUs.
- **Do not ship drei's `Environment preset`** — its docs say presets fetch from a CDN and are not
  for production. Ship an `.hdr`/`.exr` via `files`.
- **`<PresentationControls>` over `<OrbitControls>`** for a product: the user cannot lose the
  object and the camera never moves. Orbit only when exploring *is* the task.
- **One canvas per page.** Browsers cap live WebGL contexts around 8–16.
- **Never ship `leva` panels.**
- **Reduced motion:** render one composed frame and stop — freeze `useFrame`, `speed={0}` on
  `<Float>`, switch to `frameloop="demand"`.
- **Cleanup:** R3F disposes what it created. Anything you created globally is yours. A leaked
  renderer exhausts the context limit and kills every canvas on the page.

### Scroll-driven 3D

`<ScrollControls>` installs its own scroll container, which fights native scroll, sticky, and
especially Lenis. Use it only when the sequence *is* the page. For "animate this as the section
scrolls past", mount the canvas in a normal div and drive `useFrame` from an `IntersectionObserver`
or a passive scroll listener.

### drei shortlist

`Environment` (image-based lighting, the highest-impact helper) · `Float` · `ContactShadows` ·
`PresentationControls` · `useTexture` · `Html` (DOM labels anchored to 3D points) ·
`MeshTransmissionMaterial` (real glass; keep `samples` ~6 and `resolution` 256) · `useGLTF` +
`Preload` + `useProgress` · `Text` · `Instances` · `Bounds` · `Center` · `Stage`.

## Spline

[spline.design](https://spline.design) · runtime: `@splinetool/react-spline`, vanilla:
`@splinetool/runtime`.

**The agent cannot author a scene.** The `.splinecode` is produced in the editor by a person, and
its object names, events, and variables are defined there. Step one is always: ask for the scene
URL or file. If there is no scene and no designer, Spline is the wrong choice — say so and use
react-three-fiber with primitives, or skip the 3D.

- Import from `@splinetool/react-spline/next` in Next — that variant server-renders a blurred
  placeholder so the first paint is not empty.
- **`renderOnDemand` (default `true`) is the point** — it renders only on change instead of 60fps
  forever. Keep it on.
- **`pointer-events`:** the canvas swallows wheel and drag. On a marketing page where scrolling
  matters more than the scene, set `pointer-events: none` and enable it on hover or click.
  Otherwise the scene hijacks the scroll and the page feels broken.
- **Self-host the `.splinecode`** — the export CDN is a third-party origin and can CORS-block.
- **Treat object names, event names, and variables as an external API.** They are the contract
  with the designer; renaming one breaks the page.
- The scene's own looping animation is authored, not scripted here. `renderOnDemand` stops idle
  rendering; it does not stop that. On reduced motion, show the poster frame.
- The free plan adds a Spline watermark. Tell the user if it appears.

Driving it: `app.emitEvent(type, 'ObjectName')` into the scene, `addEventListener` (or `onSpline*`
props) out of it, `findObjectByName` for direct mutation, and scene variables for reacting to
app state. Reactivity stops where the editor's variables stop — that is the boundary against
react-three-fiber.

## Shared contract

- **Fallback:** a static poster in the server HTML, canvas mounted over it. First paint, no-JS,
  and no-WebGL all get a composed frame.
- **Sizing:** resolved height, always.
- **Motion:** one static composed frame under `prefers-reduced-motion`.
- **Off-screen and hidden:** stop the loop.
- **Cleanup:** dispose the renderer, textures, geometries, listeners. One leak kills every canvas.
- **Accessibility:** decorative canvas is `aria-hidden="true"`; anything meaningful needs a text
  alternative in the DOM. **Nothing interactive may exist only inside a canvas** — a Spline
  scene's buttons are not keyboard reachable, so never put the only call to action inside one.

## Assets to ask for

- **Spline:** the scene URL or `.splinecode`, plus the object names, events, and variables the
  page may drive.
- **react-three-fiber:** models (`.glb`/`.gltf`), textures, environment maps. Without them, use
  primitives and say so.
