package
{
	import ca.esdot.runnermark.RunnerEngineG2D;
	import ca.esdot.runnermark.RunnerEngineND2D;
	
	import com.genome2d.context.GContextConfig;
	import com.genome2d.core.GNode;
	import com.genome2d.core.Genome2D;
	
	import flash.events.Event;

	public class RunnerMarkG2D extends RunnerMark
	{
		protected var initComplete:Boolean;
		protected var content:GNode;
		
		override protected function init():void {
			if(!initComplete){
				initComplete = true;
				
				// Setup a signal callback for initialization
				Genome2D.getInstance().onInitialized.addOnce(onGenomeInitialized);
				// Initialize genome with a selected renderer
				Genome2D.getInstance().init(stage, new GContextConfig);
			} else {
				createEngine();
			}
			
		}
		
		protected function onGenomeInitialized():void {
			content = new GNode("content");
			Genome2D.getInstance().root.addChild(content);
			Genome2D.getInstance().autoUpdate = true;
			createEngine();
		}
		
		protected function createEngine():void {
			engine = new RunnerEngineG2D(content, stage.stageWidth, stage.stageHeight);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			createStats();
		}
		
		override protected function createStats():void {
			//new FastStatsND2D(content);
		}
	}
}