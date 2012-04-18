package 
{
	import com.genome2d.context.GContextConfig;
	import com.genome2d.core.Genome2D;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;
	import ca.esdot.runnermark.RunnerEngine;

	public class RunnerMarkG2DNativeRenderer extends RunnerMark
	{
		override protected function init():void {
			Genome2D.getInstance().onInitialized.addOnce(onGenomeComplete);
			Genome2D.getInstance().init(stage, new GContextConfig());		
		}
		
		protected function onGenomeComplete():void {
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			prevTime = getTimer();
			
			var s:Sprite = new Sprite();
			s.visible = false;
			addChild(s);
			
			//Tell Genome2D to render this sprite, and all it's children on the Stage.
			Genome2D.getInstance().initNativeRenderer(this);
			
			engine = new RunnerEngine(s, stage.stageWidth, stage.stageHeight);
			createStats();
			stats.visible = false;
		}
	}
}