package com.bojinx.game.support
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	[ExcludeClass]
	public final class TextureItem extends Sprite
	{
		
		/*============================================================================*/
		/*= PUBLIC PROPERTIES                                                         */
		/*============================================================================*/
		
		public var data:TextureItemData;
		
		private var _graphic:BitmapData;
		
		public function get graphic():BitmapData
		{
			return _graphic;
		}
		
		public function TextureItem( graphic:BitmapData )
		{
			super();
			
			if ( graphic )
			{
				_graphic = graphic;
				
				var bm:Bitmap = new Bitmap( graphic, PixelSnapping.NEVER, true );
				addChild( bm );
			}
		}
	}
}
