package com.bojinx.game.support
{
	import flash.utils.Dictionary;
	
	public class MovieFrameData
	{
		
		/*============================================================================*/
		/*= PRIVATE PROPERTIES                                                        */
		/*============================================================================*/
		
		private var data:Dictionary = new Dictionary();
		
		
		/*============================================================================*/
		/*= PUBLIC METHODS                                                            */
		/*============================================================================*/
		
		public final function addItem( item:TextureItemData ):void
		{
			var label:String = item.label;
			var frames:Vector.<TextureItemData> = data[ label ];
			
			if ( !frames )
				frames = data[ label ] = new Vector.<TextureItemData>();
			
			frames.push( item );
		}
		
		public function getAnimations():Dictionary
		{
			return data;
		}
	}
}
