# Beer Bottle Simulation

A small 3D OpenGL toy inspired by the new GTA6 trailer: drag a beer bottle around the screen with the mouse,
throw it, watch it bounce off the walls, and shatter on the floor according to physics. Liquid
inside the bottle sloshes with bubbles, and a puddle spreads where it lands.

## Controls

| Input | Action |
|---|---|
| **Left mouse button (drag)** | Move the bottle |
| **Release** | Throw it |
| **R** | Reset the scene |

## Build

### Dependencies

- OpenGL
- GLEW
- GLFW3
- GLM
- [stb_image](https://github.com/nothings/stb) (single header, included in repo)

On Debian / Ubuntu:

bash
sudo apt install build-essential libgl1-mesa-dev libglew-dev libglfw3-dev libglm-dev

On macOS (Homebrew):

bash
brew install glew glfw glm

### Compile

bash
g++ 3D_beer_bottle_simulation.cpp -o a.out -lGLU -lGL -lGLEW -lglfw


Or with make:

bash
make
./a.out

## Assets

Place the following files next to the binary:

- beer_bottle.png — intact bottle sprite
- broken_beer_bottle.png — shattered bottle sprite

Both textures must have an alpha channel (RGBA).

## How it works

- The bottle is a textured quad rendered with a simple orthographic-ish
  perspective camera.
- Mouse drag updates (dx, dy); release captures the drag velocity and the
  bottle becomes a projectile under constant gravity.
- Wall collisions reverse the corresponding velocity component with a
  damping factor; the floor collision triggers the broken state.
- A separate mesh renders the beer inside the bottle as a wave-modulated
  cylinder, with a point-sprite particle system for the bubbles.
- On break, the intact quad is swapped for the broken texture and a static
  puddle mesh is drawn at the impact location.

## Credits

- Libraries: GLEW, GLFW, GLM, stb_image

## License

MIT — see LICENSE.
