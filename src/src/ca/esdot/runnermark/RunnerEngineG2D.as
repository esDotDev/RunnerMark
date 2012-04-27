package ca.esdot.runnermark
{
	import ca.esdot.runnermark.sprites.EnemySprite;
	import ca.esdot.runnermark.sprites.GenericSprite;
	import ca.esdot.runnermark.sprites.RunnerSprite;
	
	import com.genome2d.components.GCamera;
	import com.genome2d.components.renderables.GSprite;
	import com.genome2d.core.GNode;
	import com.genome2d.textures.GTexture;
	import com.genome2d.textures.GTextureAtlas;
	import com.genome2d.textures.factories.GTextureAtlasFactory;
	import com.genome2d.textures.factories.GTextureFactory;
	
	import flash.display.BitmapData;
	import flash.display.MovieClip;

	public class RunnerEngineG2D extends RunnerEngine
	{
		public function RunnerEngineG2D(root:*, stageWidth:int, stageHeight:int) {
			super(root, stageWidth, stageHeight);
		}
		
		override public function createChildren():void {
			
			//Add Camera
			var cameraNode:GNode = new GNode();
			var cam:GCamera = cameraNode.addComponent(GCamera) as GCamera;
			_root.addChild(cameraNode);
			
			//Create Sky
			var skyData:BitmapData = createSkyData();			
			var skyNode:GNode = new GNode();
			var skySprite:GSprite = skyNode.addComponent(GSprite) as GSprite;
			skySprite.setTexture(GTextureFactory.createFromBitmapData("sky", skyData, false)); 
			sky = new GenericSprite(skyNode, null, skyData.width, skyData.height);
			_root.addChild(skyNode);
			
			var bgNode:GNode = new GNode();
			var sprite:GSprite = bgNode.addComponent(GSprite) as GSprite;
			sprite.setTexture(GTextureFactory.createFromBitmapData("bg1", bg1Data, true));
			
			bgStrip1 = new GenericSprite(bgNode, null, bg1Data.width, bg1Data.height);
			_root.addChild(bgNode);
			
			//Create a TextureAtlas dynamically using the DynamicTexture plugin.
			/*
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
			bitmap2 = new Image(Texture.fromBitmap(new Bg1()));
			bitmap2.smoothing = TextureSmoothing.NONE;
			bitmap2.x = bitmap1.width;
			sprite.addChild(bitmap2);
			*/
			bgStrip1 = new GenericSprite({});
			//_root.addChild(bgStrip1.display);
			
			//BG Strip 2
			/*
			sprite = new Sprite();
			bitmap1 =  new Image(atlas.getTextures("ca.esdot.runnermark::RunnerEngine_Bg2")[0]);
			bitmap1.smoothing = TextureSmoothing.NONE;
			sprite.addChild(bitmap1);
			bitmap2 = new Image(Texture.fromBitmap(new Bg2()));
			bitmap2.smoothing = TextureSmoothing.NONE;
			bitmap2.x = bitmap1.width;
			sprite.addChild(bitmap2);
			*/
			bgStrip2 = new GenericSprite({});
			//_root.addChild(bgStrip2.display);
			
			//Runner
			/*
			var clip:MovieClip = new MovieClip(atlas.getTextures("swc::Runner"), 60);
			clip.x = stageWidth * .2;
			clip.y = stageHeight * .7;
			clip.play();
			*/
			//_root.addChild(clip);
			
			runner = new RunnerSprite({});
			//_root.addChild(runner.display);
		}
		
		override protected function stopEngine():void {
			(_root as GNode).disposeChildren();
		}
		
		override protected function createGroundPiece():GenericSprite {
			//var image:Image = new Image(atlas.getTextures("ca.esdot.runnermark::RunnerEngine_GroundTop")[0]);
			//_root.addChildAt(image, _root.getChildIndex(bgStrip2.display) + 1);
			return new GenericSprite({});
		}
		
		override protected function createParticle():GenericSprite {
			//var image:Image = new Image(atlas.getTextures("ca.esdot.runnermark::RunnerEngine_Cloud")[0]);
			//_root.addChild(image);
			return new GenericSprite({});
		}
		
		override protected function createEnemy():EnemySprite {
			//var enemy:MovieClip = new MovieClip(atlas.getTextures("swc::Enemy"), 60);
			//enemy.play();
			//_root.addChildAt(enemy, _root.getChildIndex(runner.display));
			return new EnemySprite({});
		}
		
		override protected function removeEnemy(enemy:GenericSprite):void {
			super.removeEnemy(enemy);
		}
		
	}
	
	
}