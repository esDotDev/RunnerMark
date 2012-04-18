package com.bojinx.game.loader
{
	import flash.events.Event;
	
	public class SWFLoaderEvent extends Event
	{
		
		public function SWFLoaderEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false )
		{
			super( type, bubbles, cancelable );
		}
		
		
		/*============================================================================*/
		/*= STATIC PUBLIC PROPERTIES                                                  */
		/*============================================================================*/
		
		public static const COMPLETE:String = "complete";
	}
}
