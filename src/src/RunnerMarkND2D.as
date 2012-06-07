package
{
	import ca.esdot.runnermark.RunnerEngine;
	import ca.esdot.runnermark.RunnerEngineND2D;
	import ca.esdot.stats.FastStatsND2D;
	
	import de.nulldesign.nd2d.display.Node2D;
	import de.nulldesign.nd2d.display.Quad2D;
	import de.nulldesign.nd2d.display.Scene2D;
	import de.nulldesign.nd2d.display.Sprite2D;
	import de.nulldesign.nd2d.display.World2D;
	import de.nulldesign.nd2d.materials.texture.Texture2D;
	
	import flash.display3D.Context3DRenderMode;
	import flash.events.Event;
	import flash.utils.flash_proxy;
	import flash.utils.setTimeout;

	[SWF(width="1024", height="768")]
	public class RunnerMarkND2D extends RunnerMark
	{
		protected var world:World2D;
		protected var scene2d:Scene2D;
		
		protected var initComplete:Boolean;
		
		override protected function init():void {
			if(!initComplete){
				initComplete = true;
				world = new World2D(Context3DRenderMode.AUTO, 60);
				scene2d = new Scene2D();
				
				addChild(world);
				world.setActiveScene(scene2d); 
				world.start();
			} 
			engine = new RunnerEngineND2D(scene2d, stage.stageWidth, stage.stageHeight);
			createStats();
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		override protected function createStats():void {
			new FastStatsND2D(scene2d);
		}
	}
}