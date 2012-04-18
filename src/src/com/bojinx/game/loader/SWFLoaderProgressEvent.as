package com.bojinx.game.loader
{
	import flash.events.Event;
	
	public class SWFLoaderProgressEvent extends Event
	{
		
		/*============================================================================*/
		/*= PUBLIC PROPERTIES                                                         */
		/*============================================================================*/
		
		private var _current:int;
		
		public function get current():int
		{
			return _current;
		}
		
		private var _total:int;
		
		public function get total():int
		{
			return _total;
		}
		
		public function SWFLoaderProgressEvent( current:int, total:int,
												bubbles:Boolean = false, cancelable:Boolean = false )
		{
			_current = current;
			_total = total;
			super( PROGRESS, bubbles, cancelable );
		}
		
		
		/*============================================================================*/
		/*= STATIC PRIVATE PROPERTIES                                                 */
		/*============================================================================*/
		
		private static const PROGRESS:String = "progress";
	}
}
