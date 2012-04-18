package com.bojinx.game.object
{
	import com.bojinx.game.support.DynamicAtlas;
	import com.bojinx.game.support.MovieFrameData;
	import com.bojinx.game.support.TextureItemData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import de.nulldesign.nd2d.materials.texture.ASpriteSheetBase;
	import de.nulldesign.nd2d.materials.texture.SpriteSheetAnimation;
	
	/**
	 * Populates the AS SpriteSheet with all the required data
	 * for a texture atlas to work.
	 *
	 * @author Wael Jammal
	 */
	public class MovieClipAnimation extends ASpriteSheetBase
	{
		
		/*============================================================================*/
		/*= PUBLIC PROPERTIES                                                         */
		/*============================================================================*/
		
		private var _dynamicAtlas:DynamicAtlas;
		
		/**
		 * The Dynamic Atlas instance that contains the
		 * animations for this sheet.
		 */
		public function get dynamicAtlas():DynamicAtlas
		{
			return _dynamicAtlas;
		}
		
		/*============================================================================*/
		/*= PRIVATE PROPERTIES                                                        */
		/*============================================================================*/
		
		private var loop:Boolean;
		
		/**
		 * Constructor takes a DynamicAtlas instance and creates a SpriteSheet
		 *
		 * @param dynamicAtlas The DynamicAtlas to that contains the animations for this sheet
		 * @param fps The frames per second
		 * @param noSpace Leave this as false, it's a feature support for the next release
		 * @param loop Look animations
		 */
		public function MovieClipAnimation( dynamicAtlas:DynamicAtlas, fps:Number,
											noSpace:Boolean = false, loop:Boolean = true )
		{
			_dynamicAtlas = dynamicAtlas;
			this.fps = fps;
			this.loop = loop;
			
			// Dynamic sheets are currently packed with 1 pixel
			this.spritesPackedWithoutSpace = noSpace;
			
			// Set size
			this._sheetWidth = dynamicAtlas.width;
			this._sheetHeight = dynamicAtlas.height;
		}
		
		
		/*============================================================================*/
		/*= PUBLIC METHODS                                                            */
		/*============================================================================*/
		
		[Deprecated( message = "This method is no longer used by the Dynamic Atlas" )]
		/**
		 * @private
		 */
		override public function addAnimation( name:String, keyFrames:Array, loop:Boolean ):void
		{
			throw new Error( "addAnimation can not be used with the Dynamic Atlas." );
		}
		
		/**
		 * @inheritDoc
		 */
		override public function clone():ASpriteSheetBase
		{
			var t:MovieClipAnimation = new MovieClipAnimation( dynamicAtlas, fps, spritesPackedWithoutSpace, loop );
			t.fill();
			
			return t;
		}
		
		/**
		 * Returns the first animation, if you are only creating 1 texture atlas
		 * per game object for instance then this serves as a quick way to get the
		 * name of that animation.
		 */
		public function getDefaultAnimation():String
		{
			return dynamicAtlas.getDefaultAnimation();
		}
		
		override public function getOffsetForFrame():Point
		{
			return offsets[ frame ];
		}
		
		/**
		 * A helper that plays the first animation in the list.
		 *
		 * @param startIndex The index to play from
		 * @param loop True to loop the animation
		 */
		public function playDefaultAnimation( startIndex:int = 0, loop:Boolean = true ):void
		{
			playAnimation( dynamicAtlas.getDefaultAnimation(), startIndex, loop );
		}
		
		/*============================================================================*/
		/*= PROTECTED METHODS                                                         */
		/*============================================================================*/
		
		/**
		 * Populates the Texture Atlas
		 */
		protected function fill():void
		{
			var data:MovieFrameData = _dynamicAtlas.frameData;
			var i:int;
			var animations:Dictionary = data.getAnimations();
			
			// Set size
			this._sheetWidth = dynamicAtlas.width;
			this._sheetHeight = dynamicAtlas.height;
			
			frames = new Vector.<Rectangle>();
			keyFramesIndices = [];
			offsets = new Vector.<Point>();
			frameNameToIndex = new Dictionary();
			
			for ( var key:String in animations )
			{
				var animData:Vector.<TextureItemData> = animations[ key ];
				var keyFramesIndices:Array = [];
				var item:TextureItemData;
				
				for ( i = 0; i < animData.length; i++ )
				{
					item = animData[ i ];
					
					frames.push( item.region );
					keyFramesIndices.push( frames.length - 1 );
					offsets.push( item.offSet );
					frameNameToIndex[ item.frameIndex ] = frames.length - 1;
				}
				
				animationMap[ key ] = new SpriteSheetAnimation( keyFramesIndices, loop );
			}
			
			uvRects = new Vector.<Rectangle>( frames.length, true );
			
			this.frame = 0;
		}
	}
}
