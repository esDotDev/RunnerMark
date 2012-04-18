package 
{
	import ca.esdot.runnermark.RunnerEngineStarling;
	import ca.esdot.stats.FastStatsStarling;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	
	import starling.core.Starling;
	import starling.events.Event;
	
	
	public class RunnerMarkStarling extends RunnerMark
	{
		protected var _starling:Starling;
		
		override protected function init():void {
			_starling = new Starling(StarlingScene, stage);
			_starling.start();
			_starling.addEventListener(starling.events.Event.CONTEXT3D_CREATE, onContextReady);
		}
		
		protected function onContextReady(event:starling.events.Event):void {
			addEventListener(flash.events.Event.ENTER_FRAME, onEnterFrame);
			prevTime = getTimer();
			
			engine = new RunnerEngineStarling(StarlingScene.instance, stage.stageWidth, stage.stageHeight);
			createStats();
		}
		
		override protected function createStats():void {
			new FastStatsStarling(StarlingScene.instance);
		}
	}
}


//Just a little workaround to get access to the root displayObject in Starling.
//Starling insists on constructing it itself, so we need to grab the instance afterwards.
import starling.display.Sprite;

class StarlingScene extends Sprite {
	public static var instance:Sprite;
	public function StarlingScene() {
		instance = this;
	}
}