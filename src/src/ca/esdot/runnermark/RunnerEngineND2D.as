package ca.esdot.runnermark
{
	import ca.esdot.stats.FastStats;
	import ca.esdot.runnermark.sprites.EnemySprite;
	import ca.esdot.runnermark.sprites.GenericSprite;
	import ca.esdot.runnermark.sprites.RunnerSprite;
	
	import com.bojinx.game.object.MovieClipAnimation;
	import com.bojinx.game.support.DynamicAtlas;
	
	import de.nulldesign.nd2d.display.Sprite2D;
	import de.nulldesign.nd2d.display.Sprite2DBatch;
	import de.nulldesign.nd2d.materials.texture.Texture2D;
	
	import flash.display.BitmapData;
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
		}
		
		override public function step(elapsed:Number):void {
			super.step(elapsed);
			FastStats.numChildren = enemyBatch.numChildren + groundBatch.numChildren + particleBatch.numChildren + 4;
		}
		
		//Using Dynamic Atlas for ND2D
		//http://docs.rsnewmedia.co.uk/display/nd2ddynatlas/Home
		override public function createChildren():void {
			
			var skyData:BitmapData = createSkyData();			
			var sprite:Sprite2D = new Sprite2D(Texture2D.textureFromBitmapData(skyData));
			sprite.pivot = new Point(-sprite.width/2, -sprite.height/2);
			sky = new GenericSprite(sprite);
			_root.addChild(sky.display);
			
			sprite = new Sprite2D(Texture2D.textureFromBitmapData(new Bg1().bitmapData));
			sprite.pivot = new Point(-sprite.width/2, -sprite.height/2);
			bgStrip1 = new GenericSprite(sprite);
			_root.addChild(bgStrip1.display);
			
			sprite = new Sprite2D(Texture2D.textureFromBitmapData(new Bg2().bitmapData));
			sprite.pivot = new Point(-sprite.width/2, -sprite.height/2);
			bgStrip2 = new GenericSprite(sprite);
			_root.addChild(bgStrip2.display);
			
			//Ground Batch
			groundBatch = new Sprite2DBatch(Texture2D.textureFromBitmapData(groundData));			
			_root.addChild(groundBatch);
			
			//Runner
			var atlas:DynamicAtlas = new DynamicAtlas();
			atlas.fromMovieClips([new swc.Runner()]);
			var spritesheet:MovieClipAnimation = new MovieClipAnimation(atlas, 60);
			runnerBatch = new Sprite2DBatch(atlas.newTexture());
			runnerBatch.setSpriteSheet(spritesheet);
			_root.addChild(runnerBatch);
			
			runner = new RunnerSprite(new Sprite2D());
			runnerBatch.addChild(runner.display as Sprite2D);
			(runner.display as Sprite2D).spriteSheet.playAnimation("swc.Runner");
			
			//Enemy Batch
			var atlas:DynamicAtlas = new DynamicAtlas();
			atlas.fromMovieClips([new swc.Enemy()]);
			var spritesheet:MovieClipAnimation = new MovieClipAnimation(atlas, 24);
			enemyBatch = new Sprite2DBatch(atlas.newTexture());
			enemyBatch.setSpriteSheet(spritesheet);
			_root.addChild(enemyBatch);
			
			//Particle Batch
			particleBatch = new Sprite2DBatch(Texture2D.textureFromBitmapData(cloudData));			
			_root.addChild(particleBatch);
		}
		
		override protected function createGroundPiece():GenericSprite {
			var s:Sprite2D = new Sprite2D();
			groundBatch.addChild(s);
			s.pivot = new Point(-s.width/2, -s.height/2);
			return new GenericSprite(s, "ground");
		}
		
		override protected function createParticle():GenericSprite {
			var s:Sprite2D = new Sprite2D();
			particleBatch.addChild(s);
			s.pivot = new Point(-s.width/2, -s.height/2);
			return new GenericSprite(s, "particle");
		}
		
		override protected function createEnemy():EnemySprite {
			var s:Sprite2D = new Sprite2D();
			enemyBatch.addChild(s);
			s.spriteSheet.playAnimation("swc.Enemy");
			return new EnemySprite(s, "enemy");
		}
		
		
		override protected function updateRunner(elapsed:Number){
			super.updateRunner(elapsed);
		}
		
		override protected function updateBg(elapsed:Number):void {
			(bgStrip1.display as Sprite2D).material.uvOffsetX += elapsed * .00002;
			(bgStrip2.display as Sprite2D).material.uvOffsetX += elapsed * .00002;
		}
		
		override protected function updateGround(elapsed:Number){
			super.updateGround(elapsed);
		}
		
		override protected function updateParticles(elapsed:Number):void {
			super.updateParticles(elapsed);
		}
	}
}