#show link: underline
#show link: set text(fill: blue)

#let official = "http://wiki.libsdl.org/"

// custom heading
#show heading.where(level: 2): it => block(width: 100%)[
  #set align(center)
  #set text(13pt, weight: "bold")
  #linebreak()
  #it.body
]

#align(center, image("image/logo.png", width: 20%))

= Hello SDL
SDL(Simple Direct Media Layer) is a cross-platform library that provide low
level access to audio, keyboard, mouse, joystick, and graphic hardware via
OpenGL and Direct3D. With it, we can code games in SDL and compile is to what
ever platform it supports.

= Tutorial

== Window
Here is a program that creates a window.
```cpp
// include header files

// Screen dimension constants
const int SCREEN_WIDTH = 640;
const int SCREEN_HEIGHT = 480;

int main() {
  // The window we'll be rendering to
  SDL_Window *window = NULL;
  // The surface contained by the window
  SDL_Surface *screenSurface = NULL;
  // Initialize SDL
  if (SDL_Init(SDL_INIT_VIDEO) < 0) {
    printf("SDL could not Initialize! SDL_Error: %s\n", SDL_GetError());
  } else {
    // Create window
    window = SDL_CreateWindow("SDL Tutorial", SDL_WINDOWPOS_UNDEFINED,
                              SDL_WINDOWPOS_UNDEFINED, SCREEN_WIDTH,
                              SCREEN_HEIGHT, SDL_WINDOW_SHOWN);
    if (window == NULL)
      printf("Window could not be created! SDL_Error: %s\n", SDL_GetError());
    else {
      // Get window surface
      screenSurface = SDL_GetWindowSurface(window);
      // Fill the surface white
      SDL_FillRect(screenSurface, NULL,
                   SDL_MapRGB(screenSurface->format, 0xFF, 0xFF, 0xFF));
      // Update the surface
      SDL_UpdateWindowSurface(window);
      // Hack to get window to stay up, and omitted here
    }
  // Destroy window
  SDL_DestroyWindow(window);
  // Quit SDL subsystems
  SDL_Quit();
  return 0;
  }
}
```

The SDL require us to init it first. To make a window display on the screen, we
need to create a window, and a surface in the window. Then, draw on the surface
(we simply put a white rectangle here) and update it. The window will exists
only for a short time, so we need some ways to keep it alive. Finally, we
destroy the window and quit SDL to finish the program.

#align(center, image("image/window.png", width: 30%))

== Image
To display an image on the window, we need to load it from file. Here are the
codes to initialize it.
```cpp
SDL_Surface *gKuromi = NULL;

gKuromi = SDL_LoadBMP("kuromi.bmp");
if (gKuromi == NULL) {
  printf("Unable to load image %s! SDL Error: %s\n", "kuromi.bmp",
          SDL_GetError());
```

Then we use `SDL_BlitSurface` function to apply the image to the surface, and
don't forget to update the window.
```cpp
SDL_BlitSurface(gKuromi, NULL, gScreenSurface, NULL);
SDL_UpdateWindowSurface(gWindow);
```

#align(center, image("image/image.png", width: 20%))

== Event
SDL receive events like key press, mouse motion, joy button press, etc. And we
can get these events by `SDL_PollEvent(SDL_Event *)` which polls an event from
the event queue.

=== Key presses
By these codes, we read the event and do different things respectively.
```cpp
SDL_Event e;

while (SDL_PollEvent(&e)) {
  if (e.type == SDL_QUIT) {
    // DEFAULT
  } else if (e.type == SDL_KEYDOWN) {
    switch (e.key.keysym.sym) {
    case SDLK_UP:
      // A
      break;
    case SDLK_DOWN:
      // B
      break;
    case SDLK_LEFT:
      // C
      break;
    case SDLK_RIGHT:
      // D
      break;
    case SDLK_q:
      // QUIT
    default:
      // DEFAULT
      break;
    }

    SDL_BlitSurface(gCurrentSurface, NULL, gScreenSurface, NULL);
    SDL_UpdateWindowSurface(gWindow);
  }
}
```

We use `e.key.keysym.sym` to know what kind of key is pressed exactly. To
explain it, inside of the #link(official + "SDL_Event")[SDL Event] is an
#link(official + "SDL_KeyboardEvent")[SDL keyboard event] which contains the
information for the key event. Inside of that is a #link(official + "SDL_Keysym")
[SDL Keysym] which contains the information about the key that was
pressed. That Keysym contains the #link(official + "SDL_Keycode")[SDL Keycode]
which identifies the key that was pressed.

== Optimized Surface Loading and Soft Stretching
When we are making a game, blitting row images causes needless slow down, so we
need to convert them to an optimized format to speed them up. Luckily, SDL2
allows us to blit an image scaled to a different size.

That's easy, simply call `SDL_ConvertSurface`. It avoid converts every time a
24bit bitmap is displayed onto a 32bit image. Since the function returns a copy
of the original in a new format, don't forget to free the original image.
```cpp
optimizedSurface = SDL_ConvertSurface(loadedSurface, gScreenSurface->format, 0);
SDL_FreeSurface(loadedSurface);
```

And we can stretch the image conveniently using `SDL_BlitScaled` function.
```cpp
SDL_Rect stretchRect;
stretchRect.x = 0;
stretchRect.y = 0;
stretchRect.w = SCREEN_WIDTH;
stretchRect.h = SCREEN_HEIGHT;
SDL_BlitScaled(gCurrentSurface, NULL, gScreenSurface, &stretchRect);
```

== Extension Libraries and Loading Other Image Formats
With SDL extension libraries, we can load image files besides BMP, render TTF
fonts, and play music. We can set up SDL_image to load PNG files, which can
save a lot of disk space.

=== Loading PNGs with SDL_image
After installing SDL_image, we can include it with `#include <SDL_image.h>`, so
do for SDL_ttf, or SDL_mixer.

First, we initialize SDL_image.
```cpp
int imgFlags = IMG_INIT_PNG;
if (!(IMG_Init(imgFlags) & imgFlags)) {
  printf("SDL_image could not initialize! SDL_image Error: %s\n",
          IMG_GetError());
  return false;
}
```

Here we want to initialize SDL_image with PNG loading, so we pass in the PNG
loading flags into IMG_Init. It returns the flags that loaded successfully. If
the flags that are returned do not contain the flags we requested, that means
there's an error.
After that, we can load PNGs by replacing `SDL_LoadBMP` with `IMG_Load`.

== Texture Loading and Rendering
The texture rendering API gives us fast, flexible hardware based rendering.

To use it, we need these lines in `init()` function.
```cpp
// Create renderer for window
gRenderer = SDL_CreateRenderer(gWindow, -1, SDL_RENDERER_ACCELERATED);
// Initialize renderer color
SDL_SetRenderDrawColor(gRenderer, 0xFF, 0xFF, 0xFF, 0xFF);
```

Then, We can load a texture from an image and get the pointer.
#strike(```cpp
SDL_Texture *loadTexture(std::string path) {
  SDL_Texture *newTexture = NULL;
  SDL_Surface *loadedSurface = IMG_Load(path.c_str());
  newTexture = SDL_CreateTextureFromSurface(gRenderer, loadedSurface);
  SDL_FreeSurface(loadedSurface);
  return newTexture;
}
```)
Use `SDL_Texture *IMG_LoadTexture(gRenderer, path.c_str())` instead.

Finally, display the texture above the `gRenderer`.
```cpp
// Clear screen (fill the screen with the color in SDL_SetRenderDrawColor)
SDL_RenderClear(gRenderer);

// Render texture to screen
SDL_RenderCopy(gRenderer, gTexture, NULL, NULL);

// Update screen
SDL_RenderPresent(gRenderer);
```

== Geometry Rendering
SDL has new primitive rendering calls as part of its
#link("http://wiki.libsdl.org/CategoryRender")[rendering API], with which we
can render some basic shapes without creating additional graphics for them.

Here, for example, we draw a filled red rectangle, a outlined green
rectangle, and a line and a dotted line.
```cpp
// Clear screen with white 0xFFFFFFFF
SDL_SetRenderDrawColor(gRenderer, 0xFF, 0xFF, 0xFF, 0xFF);
SDL_RenderClear(gRenderer);

// Render red filled quad 0xFF0000FF
SDL_Rect fillRect = {SCREEN_WIDTH / 4, SCREEN_HEIGHT / 4, SCREEN_WIDTH / 2,
                      SCREEN_HEIGHT / 2};
SDL_SetRenderDrawColor(gRenderer, 0xFF, 0x00, 0x00, 0xFF);
SDL_RenderFillRect(gRenderer, &fillRect);

// Render green outlined quad 0x00FF00FF
SDL_Rect outlineRect = {SCREEN_WIDTH / 6, SCREEN_HEIGHT / 6,
                        SCREEN_WIDTH * 2 / 3, SCREEN_HEIGHT * 2 / 3};
SDL_SetRenderDrawColor(gRenderer, 0x00, 0xFF, 0x00, 0xFF);
SDL_RenderDrawRect(gRenderer, &outlineRect);

// Render blue horizontal line 0x0000FFFF
SDL_SetRenderDrawColor(gRenderer, 0x00, 0x00, 0xFF, 0xFF);
SDL_RenderDrawLine(gRenderer, 0, SCREEN_HEIGHT / 2, SCREEN_WIDTH,
                    SCREEN_HEIGHT / 2);

// Draw vertical line of yellow dots 0xFFFF00FF
SDL_SetRenderDrawColor(gRenderer, 0xFF, 0xFF, 0x00, 0xFF);
for (int i = 0; i < SCREEN_HEIGHT; i += 4) {
  SDL_RenderDrawPoint(gRenderer, SCREEN_WIDTH / 2, i);
}

// Update screen
SDL_RenderPresent(gRenderer);
```
#align(center, image("image/geometry.png", width: 20%))

== The Viewport
Some times we only want to render part of the screen for things like minimaps.
Using the Viewport we can control where we render on the screen. And it's easy
to use simply by calling `SDL_RenderSetViewport` function.
```cpp
// Clear screen
SDL_RenderClear(gRenderer);

// Render texture to screen
SDL_RenderCopy(gRenderer, gTexture, NULL, NULL);

// Top left corner viewport
SDL_Rect topLeftViewport = {0, 0, SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2};
SDL_RenderSetViewport(gRenderer, &topLeftViewport);

// Update screen
SDL_RenderPresent(gRenderer);
```
#align(center, image("image/viewport.png", width: 20%))

== Color Keying
When rendering multiple images on the screen, having images with transparent
backgrounds is usually necessary. Fortunately SDL provides an easy way to do
this using color keying.
