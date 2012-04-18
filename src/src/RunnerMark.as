package 
{
	import ca.esdot.runnermark.RunnerEngine;
	import ca.esdot.stats.FastStats;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	
	public class RunnerMark extends Sprite
	{
		protected var prevTime:int;
		protected var engine:RunnerEngine;
		
		protected var isMouseDown:Boolean = false;
		protected var stats:FastStats;
		protected var lastAdd:int;
		
		public function RunnerMark()
		{
			super();
			
			// support autoOrients
			stage.quality = StageQuality.LOW;
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.frameRate = 60;
			stage.color = 0x0;
			
			setTimeout(init, 1);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp, false, 0, true);
		}
		
		protected function onMouseDown(event:MouseEvent):void { isMouseDown = true; }
		protected function onMouseUp(event:MouseEvent):void { isMouseDown = false; }
		
		protected function init():void {
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			prevTime = getTimer();
			
			var s:Sprite = new Sprite();
			addChild(s);
			
			engine = new RunnerEngine(s, stage.stageWidth, stage.stageHeight);
			createStats();
		}
		
		protected function onMouseClicked(event:MouseEvent):void {
			if(engine.numEnemies < 10){
				
			} else if(engine.numEnemies < 50){
				engine.addEnemies(10);
			} else {
				engine.addEnemies(25);
			}
		}
		
		protected function createStats():void {
			new FastStats(this);
		}
		
		protected function onEnterFrame(event:Event):void {
			var elapsed:Number = getTimer() - prevTime;
			prevTime = getTimer();
			engine.step(elapsed);
			
			if(isMouseDown && getTimer() - lastAdd > 100){ 
				engine.addEnemies(engine.numEnemies > 150? 3 : 1); 
				lastAdd = getTimer();
			}
		}
	}
}