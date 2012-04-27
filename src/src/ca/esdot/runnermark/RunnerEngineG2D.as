package ca.esdot.runnermark
{
	import ca.esdot.runnermark.sprites.EnemySprite;
	import ca.esdot.runnermark.sprites.GenericSprite;
	import ca.esdot.runnermark.sprites.RunnerSprite;
	import ca.esdot.runnermark.sprites.SizableNode;
	
	import com.genome2d.components.GCamera;
	import com.genome2d.components.renderables.GMovieClip;
	import com.genome2d.components.renderables.GSprite;
	import com.genome2d.core.GNode;
	import com.genome2d.textures.GTexture;
	import com.genome2d.textures.GTextureAtlas;
	import com.genome2d.textures.factories.GTextureAtlasFactory;
	import com.genome2d.textures.factories.GTextureFactory;
	
	import flash.display.BitmapData;
	
	import swc.Runner;

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
			var skyNode:SizableNode = new SizableNode(null, 128, 128);
			var skySprite:GSprite = skyNode.addComponent(GSprite) as GSprite;
			skySprite.setTexture(GTextureFactory.createFromBitmapData("sky", skyData, false)); 
			sky = new GenericSprite(skyNode, null);
			_root.addChild(skyNode);
			
			//Add Bg1
			var bg1Tex:GTexture = GTextureFactory.createFromBitmapData("bg1Tex", bg1Data, true);
			var bgNode:SizableNode = new SizableNode(null,  bg1Data.width * 2, bg1Data.height);
			var node:GNode = new GNode();
			var sprite:GSprite = node.addComponent(GSprite) as GSprite;
			sprite.setTexture(bg1Tex);
			bgNode.addChild(node);
			
			node = new GNode();
			sprite = node.addComponent(GSprite) as GSprite;
			sprite.setTexture(bg1Tex);
			node.transform.x = bg1Data.width;
			bgNode.addChild(node);
			
			bgStrip1 = new GenericSprite(bgNode, null);
			_root.addChild(bgNode);
			
			//Add Bg2
			var bg2Tex:GTexture = GTextureFactory.createFromBitmapData("bg2Tex", bg2Data, true);
			bgNode = new SizableNode(null,  bg2Data.width * 2, bg2Data.height);
			node = new GNode();
			sprite = node.addComponent(GSprite) as GSprite;
			sprite.setTexture(bg2Tex);
			bgNode.addChild(node);
			
			node = new GNode();
			sprite = node.addComponent(GSprite) as GSprite;
			sprite.setTexture(bg2Tex);
			node.transform.x = bg2Data.width;
			bgNode.addChild(node);
			
			bgStrip2 = new GenericSprite(bgNode, null);
			_root.addChild(bgNode);
			
			//Add Runner
			var atlas:GTextureAtlas = GTextureAtlasFactory.createFromMovieClip("runnerAtlas", new swc.Runner());
			node = new SizableNode(null, 70, 120);
			
			var clip:GMovieClip = node.addComponent(GMovieClip) as GMovieClip;
			clip.setTextureAtlas(atlas);
			clip.play();
			
			runner = new RunnerSprite(node);
			_root.addChild(node);
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