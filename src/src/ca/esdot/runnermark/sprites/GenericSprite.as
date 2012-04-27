package ca.esdot.runnermark.sprites
{
	import com.genome2d.components.GTransform;
	import com.genome2d.components.renderables.GSprite;
	import com.genome2d.core.GNode;
	
	import flash.utils.setInterval;

	public class GenericSprite
	{
		public var display:Object;
		public var type:String;
		
		public var groundY:int = 0;
		protected var gravity:Number = 1;
		protected var isJumping:Boolean = false;
		protected var velY:int;
		protected var origW:int;
		protected var origH:int;
		
		protected var transform:*;
		
		public function GenericSprite(display:Object, type:String=null, w:int = 0, h:int = 0){
			this.origW = w;
			this.origH = h;
			this.display = display;
			this.type = type;
			
			transform = display;
			if(display is GNode){
				transform = transform.transform;
			}
		}
		
		public function get rotation():Number { return transform.rotation; }
		public function set rotation(value:Number):void {
			transform.rotation = value;
		}
		
		public function get x():Number { return transform.x; }
		public function set x(value:Number):void {
			transform.x = value;
		}
		
		public function get y():Number { return transform.y; }
		public function set y(value:Number):void {
			transform.y = value;
		}
		
		public function get width():Number { 
			if(transform is GTransform){
				return transform.scaleX * origW;
			}
			return transform.width; 
		}
		public function set width(value:Number):void {
			if(transform is GTransform){
				scaleX = value / origW;
				return;
			}
			transform.width = value;
		}
		
		public function get height():Number { 
			if(transform is GTransform){
				return transform.scaleY * origH;
			}
			return transform.height; 
			
		}
		public function set height(value:Number):void {
			if(transform is GTransform){
				scaleY = value / origH;
				return;
			}
			transform.height = value;
		}
		
		public function get scaleX():Number { return transform.scaleX; }
		public function set scaleX(value:Number):void {
			transform.scaleX = value;
		}
		
		public function get scaleY():Number { return transform.scaleY; }
		public function set scaleY(value:Number):void {
			transform.scaleY = value;
		}
		
		public function get alpha():Number { return transform.alpha; }
		public function set alpha(value:Number):void {
			transform.alpha = value;
		}
	}
}