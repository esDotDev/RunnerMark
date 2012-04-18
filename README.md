RunnerMark
==========

A performance benchmark for Adobe AIR in the style of an Endless Runner game.

Runner Mark is designed to compare rendering performance of GPU Render Mode, and the various Stage3D 2D Frameworks such as ND2D, Starling and Genome2D.

Unlike other benchmarks, which tend to test just one aspect of a rendering system, Runner Mark aims to simulate multiple types of load, similar to what you would see in a typical game.

Specifically, RunnerMark includes the following features:

* 1 Main character with a run animation
* Enemies with a “Chomp” animation
* 1 stationary background image (sky)
* 2 Parallax scrolling backgrounds
* Scrolling Ground Tiles
* Scrolling Platforms
* ~30 small dust sprites as your character runs, to simulate some level of a particles

Initially the scene will open start with no enemies, to add enemies simply press down with your finger and they will begin pouring on to the stage.

Using this, you can quickly compare rendering performance across target devices, to get a good "real world" idea of what type of rendering load can be handled, and also choose the rendering engine that will best suite your needs.

Testing Methods
===============
We’re going to look at the following rendering methods:

* GPU Render Mode - Uses the simple “bitmapData cache” method.
* Starling - Dynamic Texture Atlas
* ND2D - Sprite2DBatch
* Genome2D - G2NativeRenderer

Binaries
===============
Android binaries are available for download so you can test immediately:

* [GPU Mode](https://github.com/esDotDev/RunnerMark/blob/master/bin/RunnerMark-GPU.apk?raw=true)
* [Starling](https://github.com/esDotDev/RunnerMark/blob/master/bin/RunnerMark-Starling.apk?raw=true)
* [ND2D](https://github.com/esDotDev/RunnerMark/blob/master/bin/RunnerMark-ND2D.apk?raw=true)
* [Genome2D](https://github.com/esDotDev/RunnerMark/blob/master/bin/RunnerMark-G2DNativeRenderer.apk?raw=true)


iOS binaries must be compiled manually in order to specify the correct provisioning files for your device.