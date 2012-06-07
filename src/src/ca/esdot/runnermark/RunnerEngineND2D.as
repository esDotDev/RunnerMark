package ca.esdot.runnermark
{
	import ca.esdot.runnermark.sprites.EnemySprite;
	import ca.esdot.runnermark.sprites.GenericSprite;
	import ca.esdot.runnermark.sprites.RunnerSprite;
	import ca.esdot.stats.FastStats;
	
	import com.bojinx.game.object.MovieClipAnimation;
	import com.bojinx.game.support.DynamicAtlas;
	
	import de.nulldesign.nd2d.display.Sprite2D;
	import de.nulldesign.nd2d.display.Sprite2DBatch;
	import de.nulldesign.nd2d.materials.texture.Texture2D;
	import de.nulldesign.nd2d.materials.texture.TextureOption;
	import de.nulldesign.nd2d.materials.texture.parser.TexturePackerParser;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.utils.flash_proxy;
	
	import swc.Enemy;
	import swc.Runner;

	public class RunnerEngineND2D extends RunnerEngine
	{
		public var groundTexture:Texture2D;
		public var cloudTexture:Texture2D;
		
		public var runnerBatch:Sprite2DBatch;
		public var enemyBatch:Sprite2DBatch;
		public var groundBatch:Sprite2DBatch;
		public var particleBatch:Sprite2DBatch;
		
		public function RunnerEngineND2D(root:*, stageWidth:int, stageHeight:int){
			super(root, stageWidth, stageHeight);
			
			//runner.x = runner.y = 0;
			//runner.y -= 100;
		}
		
		override public function step(elapsed:Number):void {
			super.step(elapsed);
		}
		
		//Using Dynamic Atlas for ND2D
		//http://docs.rsnewmedia.co.uk/display/nd2ddynatlas/Home
		override public function createChildren():void {
			
			var sprite:Sprite2D = new Sprite2D(Texture2D.textureFromBitmapData(createSkyData()));
			sprite.texture.textureOptions = TextureOption.MIPMAP_DISABLE | TextureOption.FILTERING_NEAREST | TextureOption.REPEAT_NORMAL;
			sprite.pivot = new Point(-sprite.width/2, -sprite.height/2);
			//_root.addChild(sprite);
			sky = new GenericSprite(sprite);
			
			sprite = new Sprite2D(Texture2D.textureFromBitmapData(bg1Data));
			sprite.texture.textureOptions = TextureOption.MIPMAP_DISABLE | TextureOption.FILTERING_NEAREST | TextureOption.REPEAT_NORMAL;
			sprite.pivot = new Point(-sprite.width/2, -sprite.height/2);
			//_root.addChild(sprite);
			bgStrip1 = new GenericSprite(sprite);
			
			sprite = new Sprite2D(Texture2D.textureFromBitmapData(bg2Data));
			sprite.texture.textureOptions = TextureOption.MIPMAP_DISABLE | TextureOption.FILTERING_NEAREST | TextureOption.REPEAT_NORMAL;
			sprite.pivot = new Point(-sprite.width/2, -sprite.height/2);
			//_root.addChild(sprite);
			bgStrip2 = new GenericSprite(sprite);
			
			
			//Create texture atlas for all foreground elements
			var atlas:DynamicAtlas = new DynamicAtlas();
			
			var cloudMc:MovieClip = new MovieClip();
			cloudMc.name = "cloud";
			cloudMc.addChild(new Bitmap(cloudData));
			
			var groundMc:MovieClip = new MovieClip();
			groundMc.name = "ground";
			groundMc.addChild(new Bitmap(groundData));
			
			//Build Atlas
			atlas.fromMovieClips([new swc.Runner(), new swc.Enemy(), cloudMc, groundMc]);
			var texture:Texture2D = atlas.newTexture();
			texture.textureOptions = TextureOption.MIPMAP_DISABLE | TextureOption.FILTERING_NEAREST | TextureOption.REPEAT_NORMAL;
			var spritesheet:MovieClipAnimation = new MovieClipAnimation(atlas, 60, true);
			
			runnerBatch = new Sprite2DBatch(texture);
			runnerBatch.setSpriteSheet(spritesheet);
			_root.addChild(runnerBatch);
			
			var rSprite:Sprite2D = new Sprite2D();
			runner = new RunnerSprite(rSprite);
			runnerBatch.addChild(rSprite);
			rSprite.spriteSheet.playAnimation("swc.Runner");
			rSprite.updateSize();
		}
		
		override protected function createGroundPiece():GenericSprite {
			var s:Sprite2D = new Sprite2D();
			runnerBatch.addChildAt(s, 0);
			s.spriteSheet.playAnimation("ground");
			s.spriteSheet.stopCurrentAnimation();
			s.updateSize();
			return new GenericSprite(s, "ground");
		}
		
		override protected function createParticle():GenericSprite {
			var s:Sprite2D = new Sprite2D();
			runnerBatch.addChild(s);
			//s.spriteSheet.setFrameByAnimationName("cloud");
			s.spriteSheet.playAnimation("cloud");
			s.spriteSheet.stopCurrentAnimation();
			
			//s.pivot = new Point(-s.width/2, -s.height/2);
			return new GenericSprite(s, "particle");
		}
		
		override protected function createEnemy():EnemySprite {
			var s:Sprite2D = new Sprite2D();
			runnerBatch.addChild(s);
			s.spriteSheet.playAnimation("swc.Enemy");
			return new EnemySprite(s, "enemy");
		}
		
		override protected function updateBg(elapsed:Number):void {
			(bgStrip1.display as Sprite2D).material.uvOffsetX += elapsed * .00002;
			(bgStrip2.display as Sprite2D).material.uvOffsetX += elapsed * .00002;
		}
		
	}
}