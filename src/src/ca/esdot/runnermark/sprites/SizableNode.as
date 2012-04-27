package ca.esdot.runnermark.sprites
{
	import com.genome2d.components.GComponent;
	import com.genome2d.components.renderables.GSprite;
	import com.genome2d.core.GNode;
	import com.genome2d.textures.GTexture;
	
	import flash.geom.Rectangle;
	
	public class SizableNode extends GNode
	{
		protected var _oHeight:int;
		protected var _oWidth:int;
		
		public function SizableNode(p_id:String="", width:int = 0, height:int = 0){
			super(p_id);
			_oWidth = width;
			_oHeight = height;
		}
		
		public function get width():int { return _oWidth * scaleX; }
		public function set width(value:int):void {
			transform.scaleX = value / _oWidth;
		}
		
		public function get height():int { return _oHeight * scaleY; }
		public function set height(value:int):void {
			transform.scaleY = value / _oHeight;
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
		
		public function get scaleX():Number { return transform.scaleX; }
		public function set scaleX(value:Number):void {
			transform.scaleX = value;
		}
		
		public function get alpha():Number { return transform.alpha; }
		public function set alpha(value:Number):void {
			transform.alpha = value;
		}
		
		public function get scaleY():Number { return transform.scaleY; }
		public function set scaleY(value:Number):void {
			transform.scaleY = value;
		}
		
	}
}