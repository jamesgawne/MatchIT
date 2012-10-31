package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	
	public class startBtn_mc extends MovieClip {
		
		
		public function startBtn_mc() {
			// constructor code
			addEventListener(MouseEvent.CLICK, startGame);
			
		}
		
		private function startGame(e:MouseEvent){
			gotoAndStop(2);
		}
	}
	
}
