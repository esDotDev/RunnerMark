package ca.esdot.runnermark
{
	import ca.esdot.runnermark.sprites.EnemySprite;
	import ca.esdot.runnermark.sprites.GenericSprite;
	import ca.esdot.runnermark.sprites.RunnerSprite;
	
	import com.emibap.textureAtlas.DynamicAtlas;
	import com.gskinner.zoe.utils.CachedClip;
	
	import flash.display.BitmapData;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.textures.TextureSmoothing;
	
	import swc.Enemy;
	import swc.Runner;

	public class RunnerEngineStarling extends RunnerEngine
	{
		public var groundTexture:Texture;
		public var cloudTexture:Texture;
		public var enemyTextures:Vector.<Texture>;
		
		public var atlas:TextureAtlas;
		public var playerAtlas:TextureAtlas;
		
		public function RunnerEngineStarling(root:*, stageWidth:int, stageHeight:int) {
			super(root, stageWidth, stageHeight);
		}
		
		override public function createChildren():void {
			
			var skyData:BitmapData = createSkyData();			
			sky = new GenericSprite(new Image(Texture.fromBitmapData(skyData)));
			_root.addChild(sky.display);
			
			//Create a TextureAtlas dynamically using the DynamicTexture plugin.
			atlas = DynamicAtlas.fromClassVector(new <Class>[
				swc.Enemy, 
				swc.Runner, 
				Cloud, 
				Bg1, 
				Bg2,
				GroundTop
			]);
			
			var bitmap1:Image, bitmap2:Image;
			var sprite:Sprite = new Sprite();
			
			//BG Strip 1
			bitmap1 =  new Image(atlas.getTextures("ca.esdot.runnermark::RunnerEngine_Bg1")[0]);
			bitmap1.smoothing = TextureSmoothing.NONE;
			sprite.addChild(bitmap1);
			bitmap2 = new Image(atlas.getTextures("ca.esdot.runnermark::RunnerEngine_Bg1")[0]);
			bitmap2.smoothing = TextureSmoothing.NONE;
			bitmap2.x = bitmap1.width;
			sprite.addChild(bitmap2);
			bgStrip1 = new GenericSprite(sprite);
			_root.addChild(bgStrip1.display);
			
			//BG Strip 2
			sprite = new Sprite();
			bitmap1 =  new Image(atlas.getTextures("ca.esdot.runnermark::RunnerEngine_Bg2")[0]);
			bitmap1.smoothing = TextureSmoothing.NONE;
			sprite.addChild(bitmap1);
			bitmap2 = new Image(atlas.getTextures("ca.esdot.runnermark::RunnerEngine_Bg2")[0]);
			bitmap2.smoothing = TextureSmoothing.NONE;
			bitmap2.x = bitmap1.width;
			sprite.addChild(bitmap2);
			bgStrip2 = new GenericSprite(sprite);
			_root.addChild(bgStrip2.display);
			
			//Runner
			var clip:MovieClip = new MovieClip(atlas.getTextures("swc::Runner"), 60);
			clip.smoothing = TextureSmoothing.NONE;
			clip.x = stageWidth * .2;
			clip.y = stageHeight * .7;
			clip.play();
			_root.addChild(clip);
			Starling.juggler.add(clip);
			
			runner = new RunnerSprite(clip);
			_root.addChild(runner.display);
			
			//GroundTop
			groundTexture = atlas.getTextures("ca.esdot.runnermark::RunnerEngine_GroundTop")[0];
			//Cloud
			cloudTexture = atlas.getTextures("ca.esdot.runnermark::RunnerEngine_Cloud")[0];
			//Enemy
			enemyTextures = atlas.getTextures("swc::Enemy")
		}
		
		override protected function createGroundPiece():GenericSprite {
			var image:Image = new Image(groundTexture);
			_root.addChildAt(image, _root.getChildIndex(bgStrip2.display) + 1);
			return new GenericSprite(image);
		}
		
		override protected function createParticle():GenericSprite {
			var image:Image = new Image(cloudTexture);
			_root.addChild(image);
			return new GenericSprite(image);
		}
		
		override protected function createEnemy():EnemySprite {
			var enemy:MovieClip = new MovieClip(enemyTextures, 60);
			enemy.play();
			_root.addChildAt(enemy, _root.getChildIndex(runner.display));
			Starling.juggler.add(enemy);
			return new EnemySprite(enemy);
		}
		
		override protected function removeEnemy(enemy:GenericSprite):void {
			super.removeEnemy(enemy);
			Starling.juggler.remove(enemy.display as MovieClip);
		}
		
	}
	
	
}