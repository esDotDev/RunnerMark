RunnerMark
==========

A performance benchmark for Adobe AIR in the style of an Endless Runner game.

Runner Mark is designed to compare rendering performance of GPU Render Mode, and the various Stage3D 2D Frameworks such as *ND2D*, *Starling* and *Genome2D*.

* <a href="http://vimeo.com/41065357" target="_blank">Watch a video of it in action...</a>

Runner Mark aims to simulate multiple types of simultaneous load, similar to what you would see in a typical game.

Specifically, RunnerMark includes the following elements:

* 1 Main character with a run animation
* Enemies with a “Chomp” animation
* 1 stationary background image (sky)
* 2 Parallax scrolling backgrounds
* Scrolling Ground Tiles
* Scrolling Platforms
* ~30 small dust sprites as your character runs, to simulate some level of a particles
* Rudimentary AI and hit detection for all characters


Scoring System
==============
RunnerMark awards 580pts for rendering the basic scene at a solid 580 FPS. 
Then 1 additional point for each animated Enemy added to the scene. 

As an example, a score of 650 would indicate the basic scene @ 58fps + 70 animated Enemies. A score of 400, indicates the basic scene was only able to render at 40fps, and no Enemy's were added at all. 

Results
=======

* [Results-04-24-2012.txt](https://github.com/esDotDev/RunnerMark/blob/master/results/Results-04-24-2012.txt)

Implementation
==============
Each benchmark is designed to be fully optimized for each framework in terms of rendering performance. 

* [Starling Implementation](https://github.com/esDotDev/RunnerMark/blob/master/src/src/ca/esdot/runnermark/RunnerEngineStarling.as)
All images are based off a single shared TextureAtlas.

* [ND2D Implementation](https://github.com/esDotDev/RunnerMark/blob/master/src/src/ca/esdot/runnermark/RunnerEngineND2D.as)
Rendered using a handful of Sprite2DBatch's, one for Enemies, one for Particles, one for Ground etc...

* [Core Engine](https://github.com/esDotDev/RunnerMark/blob/master/src/src/ca/esdot/runnermark/RunnerEngine.as)
Basic GPU Render Mode, uses simple Bitmaps() with shared bitmapData's. 


Binaries
===============
Check the [bin folder](https://github.com/esDotDev/RunnerMark/tree/master/bin) for some Android binaries.

iOS binaries must be compiled manually in order to specify the correct provisioning files for your device.