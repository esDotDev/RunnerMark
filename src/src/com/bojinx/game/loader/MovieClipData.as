package com.bojinx.game.loader
{
	import com.bojinx.game.util.getDefinitionNames;
	import flash.display.LoaderInfo;
	
	public class MovieClipData
	{
		
		/*============================================================================*/
		/*= PUBLIC PROPERTIES                                                         */
		/*============================================================================*/
		
		private var _clipdata:Array;
		
		public function get clipdata():Array
		{
			return _clipdata;
		}
		
		private var _info:LoaderInfo;
		
		public function get info():LoaderInfo
		{
			return _info;
		}
		
		public var name:Object;
		
		public function MovieClipData( info:LoaderInfo )
		{
			_info = info;
		}
		
		
		/*============================================================================*/
		/*= PUBLIC METHODS                                                            */
		/*============================================================================*/
		
		public function clipData():Array
		{
			if ( !_clipdata )
				_clipdata = getDefinitionNames( info, true );
			
			return _clipdata;
		}
		
		public function dispose():void
		{
			_info.loader.unloadAndStop();
			_info = null;
			_clipdata = null;
		}
	}
}
