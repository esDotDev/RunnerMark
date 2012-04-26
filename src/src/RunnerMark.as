package 
{
	import ca.esdot.runnermark.RunnerEngine;
	import ca.esdot.stats.FastStats;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	
	public class RunnerMark extends Sprite
	{
		[Embed(source="assets/scoreBg.png")]
		protected var ScoreBg:Class;
		
		protected var prevTime:int;
		protected var engine:RunnerEngine;
		
		protected var isMouseDown:Boolean = false;
		protected var stats:FastStats;
		protected var lastAdd:int;
		
		public function RunnerMark() {
			stage.quality = StageQuality.LOW;
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.frameRate = 60;
			stage.color = 0x0;
			setTimeout(init, 250);
		}
		
		protected function init():void {
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			prevTime = getTimer();
			
			var s:Sprite = new Sprite();
			addChild(s);
			
			engine = new RunnerEngine(s, stage.stageWidth, stage.stageHeight);
			engine.onComplete = onEngineComplete;
			createStats();
		}
		
		protected function onEnterFrame(event:Event):void {
			if(!engine){ return; }
			
			var elapsed:Number = getTimer() - prevTime;
			prevTime = getTimer();
			
			engine.fps = FastStats.fps;
			engine.step(elapsed);
			if(!engine.onComplete) { //Lazily inject onComplete handler into engine
				engine.onComplete = onEngineComplete;
			}
		}
		
		protected function restartEngine():void{
			removeChildren();
			init();
		}
		
		protected function createStats():void {
			stats = new FastStats(this);
		}
		
		protected function onEngineComplete():void {
			
			removeChildren();
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			var bg:Bitmap = new ScoreBg();
			bg.x = stage.stageWidth - bg.width >> 1;
			bg.y = stage.stageHeight - bg.height >> 1;
			addChild(bg);
			
			var tf:TextFormat = new TextFormat("Arial", 48, 0xFFFFFF, true);
			var score:TextField = new TextField();
			score.defaultTextFormat = tf;
			score.text = String(engine.runnerScore);
			score.width = 300;
			score.height = 50;
			score.x = bg.x + (bg.width - score.textWidth >> 1);
			score.y = bg.y + (bg.height - score.textHeight - 20 >> 1);
			addChild(score);
			
			stage.addEventListener(MouseEvent.CLICK, onRestartClicked);
		}
		
		protected function onRestartClicked(event:MouseEvent):void {
			stage.removeEventListener(MouseEvent.CLICK, onRestartClicked);
			restartEngine();	
		}
	}
}