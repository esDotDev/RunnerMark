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
	import com.genome2d.core.Genome2D;
	import com.genome2d.textures.GTexture;
	import com.genome2d.textures.GTextureAtlas;
	import com.genome2d.textures.factories.GTextureAtlasFactory;
	import com.genome2d.textures.factories.GTextureFactory;
	
	import flash.display.BitmapData;
	
	import swc.Enemy;
	import swc.Runner;

	public class RunnerEngineG2D extends RunnerEngine
	{
		//G2D Is nasty about re-creating textures with the same name, so cache statically.
		//??? How to clear existing textures?
		protected static var groundTexture:GTexture;
		protected static var cloudTexture:GTexture;
		protected static var bg1Tex:GTexture;
		protected static var bg2Tex:GTexture;
		protected static var skyTex:GTexture;

		private var enemyAtlas:GTextureAtlas;

		private var runnerAtlas:GTextureAtlas;
		
		public function RunnerEngineG2D(root:*, stageWidth:int, stageHeight:int) {
			super(root, stageWidth, stageHeight);
			
			//Need to do some hacks here because G2D uses a coordinate plane system 
			//(everthing is centered at 0,0 in the middle of the screen)
			
			//Fix Runner and Bg positions
			bgStrip1.y = (stageHeight - bgStrip1.height)/2;
			bgStrip2.y = (stageHeight - bgStrip2.height)/2;
			
			runner.x = 0;//-stageWidth * .25;
			runner.y = 0;// stageHeight/2 - stageHeight * .2;
			
			//Fix initial Ground
			lastGroundPiece = groundList[0];
			groundList[0].x -= 500;
			removeAllGround();
			addGround(6);
		}
		
		override public function createChildren():void {
			
			//Add Camera
			var cameraNode:GNode = new GNode();
			var cam:GCamera = cameraNode.addComponent(GCamera) as GCamera;
			cameraNode.transform.setPosition(stageWidth/2, stageHeight/2);
			Genome2D.getInstance().root.addChild(cameraNode);
			
			//Create Sky
			var skyData:BitmapData = createSkyData();			
			var skyNode:SizableNode = new SizableNode(null, 128, 128);
			var skySprite:GSprite = skyNode.addComponent(GSprite) as GSprite;
			if(!skyTex){
				skyTex = GTextureFactory.createFromBitmapData("sky", skyData, false); 
			}
			skySprite.setTexture(skyTex); 
			sky = new GenericSprite(skyNode, null);
			_root.addChild(skyNode);
			
			//Add Bg1
			if(!bg1Tex){
				bg1Tex = GTextureFactory.createFromBitmapData("bg1Tex", bg1Data, true);
			}
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
			if(!bg2Tex){
				bg2Tex = GTextureFactory.createFromBitmapData("bg2Tex", bg2Data, true);
			}
			bgNode = new SizableNode(null,  bg2Data.width * 2, bg2Data.height);
			
			node = new GNode();
			sprite = node.addComponent(GSprite) as GSprite;
			sprite.setTexture(bg2Tex);
			bgNode.addChild(node);
			
			node = new GNode();
			sprite = node.addComponent(GSprite) as GSprite;
			sprite.setTexture(bg2Tex);
			node.transform.
			node.transform.x = bg2Data.width;
			bgNode.addChild(node);
			
			bgStrip2 = new GenericSprite(bgNode, null);
			_root.addChild(bgNode);
			
			//Add Runner
			if(!runnerAtlas){
				runnerAtlas = GTextureAtlasFactory.createFromMovieClip("runnerAtlas", new swc.Runner());
			}
			node = new SizableNode(null, 70, 120);
			
			var clip:GMovieClip = node.addComponent(GMovieClip) as GMovieClip;
			clip.setTextureAtlas(runnerAtlas);
			clip.frames = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17];
			clip.play();
			runner = new RunnerSprite(node);
			_root.addChild(node);
		}
		
		override protected function stopEngine():void {
			(_root as GNode).disposeChildren();
		}
		
		override protected function createGroundPiece():GenericSprite {
			if(!groundTexture){
				groundTexture = GTextureFactory.createFromBitmapData("ground", groundData, false);
			}
			var node:SizableNode = new SizableNode("", groundData.width, groundData.height);
			var sprite:GSprite = node.addComponent(GSprite) as GSprite;
			sprite.setTexture(groundTexture);
			_root.addChild(node);
			_root.swapChildren(node, runner.display);
			return new GenericSprite(node);
		}
		
		override protected function addParticles(numParticles:int):void {
			for(var i:int = 0; i < numParticles; i++){
				var p:GenericSprite = createParticle(); 
				p.x = runner.x - 30;
				p.y = runner.y + runner.height * .35 + runner.height * .25 * Math.random();
				particleList.push(p);
			}
		}
		
		override protected function createParticle():GenericSprite {
			if(!cloudTexture){
				cloudTexture = GTextureFactory.createFromBitmapData("cloud", cloudData, false);
			}
			var node:SizableNode = new SizableNode("", cloudData.width, cloudData.height);
			var sprite:GSprite = node.addComponent(GSprite) as GSprite;
			sprite.setTexture(cloudTexture);
			_root.addChild(node);
			_root.swapChildren(node, runner.display);
			return new GenericSprite(node);
		}
		
		override protected function createEnemy():EnemySprite {
			if(!enemyAtlas){
				enemyAtlas = GTextureAtlasFactory.createFromMovieClip("enemyAtlas", new swc.Enemy());
			}
			var node:SizableNode = new SizableNode(null, 100, 112);
			
			var clip:GMovieClip = node.addComponent(GMovieClip) as GMovieClip;
			clip.setTextureAtlas(enemyAtlas);
			clip.frames = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17];
			clip.play();
			runner = new RunnerSprite(node);
			_root.addChild(node);
			
			return new EnemySprite(node);
		}
		
		override protected function removeEnemy(enemy:GenericSprite):void {
			super.removeEnemy(enemy);
		}
		
	}
	
	
}