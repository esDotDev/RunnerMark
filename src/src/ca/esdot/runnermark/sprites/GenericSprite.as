package ca.esdot.runnermark.sprites
{
	import flash.utils.setInterval;

	public class GenericSprite
	{
		public var display:*;
		public var type:String;
		
		public var groundY:int = 0;
		protected var gravity:Number = 1;
		protected var isJumping:Boolean = false;
		protected var velY:int;
		
		public function GenericSprite(display:*, type:String=null){
			this.display = display;
			this.type = type;
		}
		
		public function get rotation():Number { return display.rotation; }
		public function set rotation(value:Number):void {
			display.rotation = value;
		}
		
		public function get x():Number { return display.x; }
		public function set x(value:Number):void {
			display.x = value;
		}
		
		public function get y():Number { 
			return display.y; 
		}
		public function set y(value:Number):void {
			display.y = value;
		}
		
		public function get width():Number {  return display.width;  }
		public function set width(value:Number):void {
			display.width = value;
		}
		
		public function get height():Number {  return display.height;  }
		public function set height(value:Number):void {
			display.height = value;
		}
		
		public function get scaleX():Number { return display.scaleX; }
		public function set scaleX(value:Number):void {
			display.scaleX = value;
		}
		
		public function get alpha():Number { return display.alpha; }
		public function set alpha(value:Number):void {
			display.alpha = value;
		}
		
		public function get scaleY():Number { return display.scaleY; }
		public function set scaleY(value:Number):void {
			display.scaleY = value;
		}
		
		
	}
}