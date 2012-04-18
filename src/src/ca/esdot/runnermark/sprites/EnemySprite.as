package ca.esdot.runnermark.sprites
{
	public class EnemySprite extends GenericSprite
	{
		public function EnemySprite(display:Object, type:String=null){
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
			
			if(!isJumping && display.y == groundY && Math.random() < .02){
				velY = -display.height * .25;
				isJumping = true;
			}
			
		}
	}
}