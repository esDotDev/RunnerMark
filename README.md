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

Scoring System
==============
RunnerMark awards 580pts for rendering the basic scene at a solid 580 FPS. Then 1 additional point for each animated Enemy added to the scene. 

As an example, a score of 650 would indicate the basic scene @ 58fps + 70 animated Enemies. A score of 400, indicates the basic scene was only able to render at 40fps, and no Enemy's were added at all. 

Results
=======

* [Results-04-24-2012.txt](https://github.com/esDotDev/RunnerMark/blob/master/results/Results-04-24-2012.txt)

Binaries
===============
Android binaries are available for download so you can test immediately:

* [GPU Mode](https://github.com/esDotDev/RunnerMark/blob/master/bin/RunnerMark-GPU.apk?raw=true)
* [Starling](https://github.com/esDotDev/RunnerMark/blob/master/bin/RunnerMark-Starling.apk?raw=true)
* [ND2D](https://github.com/esDotDev/RunnerMark/blob/master/bin/RunnerMark-ND2D.apk?raw=true)
* [Genome2D](https://github.com/esDotDev/RunnerMark/blob/master/bin/RunnerMark-G2DNativeRenderer.apk?raw=true)


iOS binaries must be compiled manually in order to specify the correct provisioning files for your device.