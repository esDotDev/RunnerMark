package com.gskinner.zoe.utils
{
	import avmplus.getQualifiedClassName;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	/** 
	 * Really really simple class which will rip a movieClip to bitmapData, and play each frame.
	*/
	public class CachedClip extends Sprite
	{
		/* 
		Use a static cache as a simple method of sharing textures between all MovieClips of the same Type;
		*/
		public static var framesByType:Object = {};
		
		public var frames:Array;
		protected var target:MovieClip;
		protected var _currentFrame:int;
		protected var bitmap:Bitmap;
		protected var frameHeight:int;
		protected var frameWidth:int;
		
		public function CachedClip(target:Class, frameWidth:int, frameHeight:int){
			frames = [];
			
			frameWidth = frameWidth;
			frameHeight = frameHeight;
			
			//Check if object is already cached, if it is use the cache. Otherwise, create one.
			frames = framesByType[getQualifiedClassName(target)];
			if(!frames){
				trace("Rip Frames!");
				frames = [];
				framesByType[getQualifiedClassName(target)] = frames;
				
				var mc:MovieClip = new target();
				if(!mc){ throw(new Error("Target must be a MovieClip")); }
				
				for(var i:int = 0; i < mc.framesLoaded; i++){
					var bmp:BitmapData = new BitmapData(frameWidth, frameHeight, true, 0x0);
					mc.gotoAndStop(i + 1);
					bmp.draw(mc);
					frames[i] = bmp;
				}
			}
			
			bitmap = new Bitmap();
			addChild(bitmap);
			
			currentFrame = 1;
		}
		
		public function step():void {
			currentFrame += 1;
		}
		
		public function get currentFrame():int {
			return _currentFrame;
		}

		public function set currentFrame(value:int):void {
			_currentFrame = value;
			if(_currentFrame > frames.length - 1){ _currentFrame = 0; }
			bitmap.bitmapData = frames[_currentFrame];
		}

	}
}