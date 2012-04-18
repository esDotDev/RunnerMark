package com.bojinx.game.loader
{
	import com.bojinx.game.support.DynamicAtlas;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.Dictionary;
	
	[Event( name = "complete", type = "com.bojinx.game.loader.SWFLoaderEvent" )]
	[Event( name = "ioError", type = "flash.events.IOErrorEvent" )]
	[Event( name = "progress", type = "com.bojinx.game.loader.SWFLoaderProgressEvent" )]
	public class SWFLoader extends EventDispatcher
	{
		
		/*============================================================================*/
		/*= PUBLIC PROPERTIES                                                         */
		/*============================================================================*/
		
		private var _current:int = 0;
		
		public function get current():int
		{
			return _current;
		}
		
		private var _total:int = 0;
		
		public function get total():int
		{
			return _total;
		}
		
		/*============================================================================*/
		/*= PRIVATE PROPERTIES                                                        */
		/*============================================================================*/
		
		private var clipData:Dictionary;
		
		private var loaders:Dictionary;
		
		private var pending:Dictionary;
		
		public function SWFLoader()
		{
			super();
		}
		
		
		/*============================================================================*/
		/*= PUBLIC METHODS                                                            */
		/*============================================================================*/
		
		public function add( url:String, name:String, domain:ApplicationDomain = null ):void
		{
			if ( !pending )
				pending = new Dictionary();
			
			if ( !clipData )
				clipData = new Dictionary();
			
			if ( !loaders )
				loaders = new Dictionary();
			
			if ( pending[ name ])
				throw new Error( "A SWF with name " + name + " already exists" );
			
			pending[ name ] = { url: url, domain: domain, name: name };
			_total++;
		}
		
		public function getByName( name:String ):MovieClip
		{
			return ( clipData[ name ] as MovieClipData ).info.content as MovieClip;
		}
		
		public function load():void
		{
			for ( var i:String in pending )
			{
				var domain:ApplicationDomain = pending[ i ].domain;
				var url:String = pending[ i ].url;
				var loader:Loader = new Loader();
				var context:LoaderContext = new LoaderContext( false, domain );
				var request:URLRequest = new URLRequest( url );
				
				loaders[ loader.contentLoaderInfo ] = pending[ i ];
				addListerers( loader );
				loader.load( request, context );
			}
		}
		
		public function newAtlas( names:Array, sx:Number = 1, sy:Number = 1, useLinkage:Boolean = false ):DynamicAtlas
		{
			var clips:Array = [];
			
			for each ( var i:String in names )
			{
				if ( clipData[ i ] is MovieClipData )
				{
					clips.push(( clipData[ i ] as MovieClipData ).info.content );
				}
			}
			
			var atlas:DynamicAtlas = new DynamicAtlas();
			atlas.fromMovieClips( clips, sx, sy, useLinkage );
			
			return atlas;
		}
		
		public function unloadByName( name:String ):Boolean
		{
			if ( clipData[ name ])
			{
				( clipData[ name ] as MovieClipData ).dispose();
				delete( clipData[ name ]);
				
				return true;
			}
			
			return false;
		}
		
		/*============================================================================*/
		/*= PRIVATE METHODS                                                           */
		/*============================================================================*/
		
		private function addListerers( loader:Loader ):void
		{
			loader.contentLoaderInfo.addEventListener( Event.COMPLETE, onComplete );
			loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, onIoError );
		}
		
		private function checkForCompletion():void
		{
			if ( current == total )
				dispatchEvent( new SWFLoaderEvent( SWFLoaderEvent.COMPLETE ));
		}
		
		private function onComplete( event:Event ):void
		{
			_current++;
			
			var info:LoaderInfo = event.currentTarget as LoaderInfo;
			var data:Object = loaders[ info ];
			
			delete( pending[ data.name ]);
			
			removeListerers( info );
			parseClip( info );
			dispatchEvent( new SWFLoaderProgressEvent( current, total ));
			checkForCompletion();
		}
		
		private function onIoError( event:IOErrorEvent ):void
		{
			delete( clipData[ event.currentTarget.loader ]);
			dispatchEvent( event.clone());
		}
		
		private function parseClip( info:LoaderInfo ):void
		{
			var data:Object = loaders[ info ];
			var item:MovieClipData = new MovieClipData( info );
			item.name = data.name;
			
			clipData[ data.name ] = item;
			
			delete( loaders[ info ]);
		}
		
		private function removeListerers( loader:LoaderInfo ):void
		{
			loader.removeEventListener( Event.COMPLETE, onComplete );
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onIoError );
		}
	}
}
