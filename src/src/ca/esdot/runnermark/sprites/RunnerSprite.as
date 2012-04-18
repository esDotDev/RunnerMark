package ca.esdot.runnermark.sprites
{
	public class RunnerSprite extends GenericSprite
	{
		public var enemyList:Array;
		public function RunnerSprite(display:Object, type:String=null) {
			super(display, type);
		}
		
		public function update():void {
			velY += gravity;
			y += velY; 
			if(y > groundY){
				y = groundY;
				isJumping = false;
				velY = 0;
			}
			
			if(!enemyList || isJumping){ return; }
			var enemy:EnemySprite;
			for(var i:int = 0, l:int = enemyList.length; i < l; i++){
				enemy = enemyList[i];
				if(enemy.x > this.x && enemy.x - this.x < this.width * 1.5){
					velY = -22;
					isJumping = true;
					break;
				}
			}
			
		}
	}
}