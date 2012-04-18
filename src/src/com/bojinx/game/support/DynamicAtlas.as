package com.bojinx.game.support
{
	import com.bojinx.game.util.Packer;
	import com.bojinx.game.util.getDefinitionNames;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getQualifiedClassName;
	import de.nulldesign.nd2d.materials.texture.Texture2D;
	
	/**
	 * Takes an array of MovieClip objects and creates a sprite sheet along with
	 * data required by ND2D to function.
	 *
	 * @example
	 * // Create your Atlas
	 * var data:DynamicAtlas = new DynamicAtlas();
	 * data.fromMovieClipArray( movieClips, 1, 1 );
	 *
	 * // Create your sprite sheet
	 * spriteSheet = new MovieClipAnimation( cached.dynamicAtlasData, m.frameRate );
	 *
	 * // Play an animation
	 * spriteSheet.playAnimation( "Run", 0, true );
	 *
	 * You can now set your sprite sheet on a Sprite2DBatch like normal.
	 * var s:Sprite2DBatch = new Sprite2DBatch( texture );
	 * s.setSpriteSheet( spriteSheet );
	 * addChild( s );
	 *
	 * And create sprite 2d children for each animation if you want more than 1.
	 *
	 * TODO
	 * - Filter support
	 * - Color Transformations
	 * - Support movie clips that dont use Linkages
	 *
	 * @author Wael Jammal
	 * @version 0.8
	 */
	public final class DynamicAtlas
	{
		
		/*============================================================================*/
		/*= PUBLIC PROPERTIES                                                         */
		/*============================================================================*/
		
		private var _frameData:MovieFrameData;
		
		/**
		 * Stores the result of the processed movie clips
		 */
		public function get frameData():MovieFrameData
		{
			return _frameData;
		}
		
		private var _height:Number;
		
		/**
		 * Returns the height of the sprite sheet.
		 */
		public function get height():Number
		{
			return _height;
		}
		
		private var _maxCanvasHeight:Number = 2048;
		
		public function get maxCanvasHeight():Number
		{
			return _maxCanvasHeight;
		}
		
		public function set maxCanvasHeight( value:Number ):void
		{
			_maxCanvasHeight = value;
		}
		
		private var _maxCanvasWidth:Number = 2048;
		
		/**
		 * The maximum size for the canvas's width.
		 *
		 * @default 2048
		 */
		public function get maxCanvasWidth():Number
		{
			return _maxCanvasWidth;
		}
		
		/**
		 * @private
		 */
		public function set maxCanvasWidth( value:Number ):void
		{
			_maxCanvasWidth = value;
		}
		
		private var _spriteSheetData:BitmapData;
		
		/**
		 * Returns the Sprite Sheet bitmap data.
		 */
		public function get spriteSheetData():BitmapData
		{
			return _spriteSheetData;
		}
		
		private var _width:Number;
		
		/**
		 * Returns the width of the sprite sheet.
		 */
		public function get width():Number
		{
			return _width;
		}
		
		/*============================================================================*/
		/*= PROTECTED PROPERTIES                                                      */
		/*============================================================================*/
		
		protected var _bData:BitmapData;
		
		protected var _bounds:Rectangle;
		
		protected var _canvas:Sprite;
		
		protected var _preserveColor:Boolean = true;
		
		/*============================================================================*/
		/*= PRIVATE PROPERTIES                                                        */
		/*============================================================================*/
		
		private var anim:Array;
		
		private var defaultAnimation:String;
		
		private var definitions:Array;
		
		private var frameCnt:int = -1;
		
		private var matrix:Matrix = new Matrix();
		
		private var maxHeight:Number = 0;
		
		private var maxWidth:Number = 0;
		
		private var offsetX:Number;
		
		private var offsetY:Number;
		
		private var pack:Packer;
		
		public function DynamicAtlas()
		{
		
		}
		
		
		/*============================================================================*/
		/*= PUBLIC METHODS                                                            */
		/*============================================================================*/
		
		[Deprecated( message = "Use fromMovieClips instead", replacement = "fromMovieClips", since = "0.9" )]
		/**
		 * @private
		 */
		public function fromMovieClipArray( data:Array, sx:Number = 1, sy:Number = 1,
											useLinkages:Boolean = false ):BitmapData
		{
			return fromMovieClips( data, sx, sy, useLinkages );
		}
		
		/**
		 * Creates a sprite sheet from an array of MovieClip objects that
		 * were loaded using a Loader, in order for this to work your movie
		 * clip's loaderInfo must not be null.
		 *
		 * @param data Array of movie clips.
		 * @param sx Scale X factor
		 * @param sy Scale Y factor
		 */
		public function fromMovieClipInfos( data:Array, sx:Number = 1, sy:Number = 1 ):BitmapData
		{
			for each ( var clipData:MovieClip in data )
			{
				fromMovieClipData( clipData );
			}
			
			// Create the sheet
			createSpriteSheet();
			
			return _spriteSheetData;
		}
		
		/**
		 * Creates a sprite sheet from an array of MovieClip objects.
		 *
		 * @param data Array of movie clips.
		 * @param sx Scale X factor
		 * @param sy Scale Y factor
		 */
		public function fromMovieClips( data:Array, sx:Number = 1, sy:Number = 1,
										useLinkages:Boolean = false ):BitmapData
		{
			var name:String;
			var totalFrames:int;
			var i:int;
			var mc:MovieClip;
			
			initDefaults();
			
			for each ( mc in data )
			{
				if ( mc.loaderInfo && useLinkages )
				{
					fromMovieClipData( mc, sx, sy );
					continue;
				}
				
				// Reverted this to use Linkage name for public release
				// the version in the Bojinx Engine still lets you have custom
				// animation names and groups. This is easy to implement yourself
				// just pass an array of configuration objects instead of an array
				// of movie clips and use that object to supply things like name, animation etc.
				name = getQualifiedClassName( mc ).replace( "::", "." );
				
				if ( !defaultAnimation )
					defaultAnimation = name;
				
				// Total frames of current clip
				totalFrames = mc.totalFrames;
				
				// Pre-Scale
				mc.scaleX = sx;
				mc.scaleY = sy;
				
				var label:String;
				
				for ( i = 1; i <= totalFrames; ++i )
				{
					// Move Frame
					mc.gotoAndStop( i );
					
					// Current label
					label = mc.currentLabel ? mc.currentLabel : name;
					
					// Create a frame
					createFrame( mc, i, frameCnt, sx, sy, label );
					
					// Total frame count accross all clips
					frameCnt++;
				}
			}
			
			// Create the sheet
			createSpriteSheet();
			
			return _spriteSheetData;
		}
		
		/**
		 * Returns the name of the default animation.
		 */
		public function getDefaultAnimation():String
		{
			return defaultAnimation;
		}
		
		public function getFullBounds( displayObject:DisplayObject ):Rectangle
		{
			var bounds:Rectangle = displayObject.getBounds( displayObject.parent );
			bounds.x = Math.floor( bounds.x );
			bounds.y = Math.floor( bounds.y );
			bounds.height = Math.ceil( bounds.height );
			bounds.width = Math.ceil( bounds.width );
			
			return bounds;
		}
		
		/**
		 * Creates a Texture2D object
		 */
		public function newTexture():Texture2D
		{
			return Texture2D.textureFromBitmapData( spriteSheetData );
		}
		
		/**
		 * Sets the value for the default animation.
		 */
		public function setDefaultAnimation( value:String ):void
		{
			defaultAnimation = value;
		}
		
		/*============================================================================*/
		/*= PROTECTED METHODS                                                         */
		/*============================================================================*/
		
		protected function createFrame( clip:flash.display.MovieClip, frameNumber:int,
										length:int, sx:Number, sy:Number, label:String ):void
		{
			var hasStopped:Boolean = false;
			
			makeAllChildrenGoToFrame( clip, frameNumber );
			
			var colorTransform:* = clip.transform.colorTransform;
			var bd:BitmapData;
			
			// Ignore movie clips with no size!
			if ( clip.width == 0 || clip.height == 0 )
				return;
			
			var gap:int = 1;
			
			// Real
			var bounds:Rectangle = getFullBounds( clip );
			bounds.width *= sx;
			bounds.height *= sy;
			bounds.x *= sx;
			bounds.y *= sy;
			
			// Full Bounds
			_bounds = new Rectangle( 0, 0, bounds.width, bounds.height );
			_bounds.offset( bounds.x, bounds.y );
			_bounds.width = Math.max( _bounds.width, maxWidth );
			_bounds.height = Math.max( _bounds.height, maxHeight );
			
			// Create bitmap using the full bounds
			bd = new BitmapData( _bounds.width, _bounds.height, true, 0XFF0000 );
			
			// Transform
			matrix = clip.transform.matrix;
			matrix.translate( -_bounds.x, -_bounds.y );
			
			bd.draw( clip, matrix, null );
			
			// Pivot
			var pivotX:Number = -_bounds.x;
			var pivotY:Number = -_bounds.y;
			
			// Calculate offsets
			offsetX = ( _bounds.width * .5 ) - pivotX;
			offsetY = ( _bounds.height * .5 ) - pivotY;
			
			// Frame Data
			var newLength:String = intToString( length );
			var item:TextureItem = new TextureItem( bd );
			var data:TextureItemData = new TextureItemData();
			data.animation = label + "_" + newLength;
			data.frameIndex = label + "_" + newLength;
			data.source = new Point( maxWidth, maxHeight );
			data.pivot = new Point( pivotX + gap, pivotY + gap );
			data.offSet = new Point( offsetX + gap, offsetY + gap );
			data.label = label;
			data.index = length;
			item.data = data;
			
			_canvas.addChild( item );
			
			var rect:Rectangle = pack.insert( item.width + gap * 2, item.height + gap * 2, Packer.METHOD_RECT_BEST_AREA_FIT );
			
			item.x = rect.x + gap;
			item.y = rect.y + gap;
			
			data.region = rect;
			
			_frameData.addItem( data );
		}
		
		/**
		 * Sync's all children with the current frame.
		 */
		protected function makeAllChildrenGoToFrame( m:MovieClip, f:int ):void
		{
			for ( var i:int = 0; i < m.numChildren; i++ )
			{
				var c:MovieClip = m.getChildAt( i ) as MovieClip;
				
				if ( c )
				{
					makeAllChildrenGoToFrame( c, f );
					c.gotoAndStop( f );
				}
			}
		}
		
		/*============================================================================*/
		/*= PRIVATE METHODS                                                           */
		/*============================================================================*/
		
		private function calculateMaxDimensions( mc:MovieClip, sx:Number, sy:Number ):void
		{
			for ( var i:int = 1; i <= mc.totalFrames; i++ )
			{
				mc.gotoAndStop( i );
				
				var bounds:Rectangle = getFullBounds( mc );
				bounds.width *= sx;
				bounds.height *= sy;
				bounds.x *= sx;
				bounds.y *= sy;
				
				if ( bounds.width > maxWidth )
					maxWidth = bounds.width;
				
				if ( bounds.height > maxHeight )
					maxHeight = bounds.height;
			}
		}
		
		private function createSpriteSheet():void
		{
			// Draw the sprite sheet
			_spriteSheetData = new BitmapData( _canvas.width, _canvas.height, true, 0X000000 );
			_spriteSheetData.draw( _canvas );
			
			_width = _spriteSheetData.width;
			_height = _spriteSheetData.height;
		}
		
		/**
		 * Creates a sprite sheet from a MovieClip object that contains loaderInfo.
		 *
		 * @param data Array of movie clips.
		 * @param sx Scale X factor
		 * @param sy Scale Y factor
		 */
		private function fromMovieClipData( clip:MovieClip, sx:Number = 1, sy:Number = 1 ):void
		{
			initDefaults();
			
			var totalFrames:int;
			var i:int;
			var label:String;
			
			definitions = getDefinitionNames( clip.loaderInfo, true );
			
			for each ( var linkage:String in definitions )
			{
				var clazz:Class =
					clip.loaderInfo.applicationDomain.getDefinition( linkage ) as Class;
				
				var mc:MovieClip = new clazz();
				
				// Total frames of current clip
				totalFrames = mc.totalFrames;
				
				// Pre-Scale
				mc.scaleX = sx;
				mc.scaleY = sy;
				
				calculateMaxDimensions( mc, sx, sy );
				
				for ( i = 1; i <= totalFrames; ++i )
				{
					// Move Frame
					mc.gotoAndStop( i );
					
					// Current label
					label = linkage;
					
					// Create a frame
					createFrame( mc, i, frameCnt, sx, sy, label );
					
					// Total frame count accross all clips
					frameCnt++;
				}
			}
		}
		
		private function initDefaults():void
		{
			if ( !_frameData )
				_frameData = new MovieFrameData();
			
			if ( !pack )
				pack = new Packer( maxCanvasWidth, maxCanvasHeight );
			
			if ( !_canvas )
				_canvas = new Sprite();
			
			if ( frameCnt == -1 )
				frameCnt = 0;
		}
		
		private function intToString( num:int, count:int = 3 ):String
		{
			var numToString:String = num.toString();
			var result:String = "";
			
			for ( var i:int = 0; i < count - numToString.length; i++ )
			{
				result += "0";
			}
			
			return result + numToString;
		}
	}
}

