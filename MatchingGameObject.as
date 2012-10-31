package 
{

	import flash.display.MovieClip;
	import flash.display.*;
	import flash.events.MouseEvent;
	import fl.motion.MotionEvent;
	import flash.utils.Timer;
	import flash.utils.*;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.events.Event;


	public class MatchingGameObject extends MovieClip
	{
		// constants
		private static const BOARD_WIDTH:uint = 6;
		private static const BOARD_HEIGHT:uint = 6;
		private static const HORIZONTAL_SPACING:Number = 52;
		private static const VERTICLE_SPACING:Number = 52;
		private static const X_OFFSET:Number = 120;
		private static const Y_OFFSET:Number = 45;
		private static const pointsForHit:int = 100;
		private static const pointsForMiss:int = -5;

		// Private Variables
		private var firstCard:Card;
		private var secondCard:Card;
		private var cardsLeft:uint;
		private var t:Timer = new Timer(1000);
		private var gameScoreField:TextField;
		private var gameTimeTextField:TextField;
		public static var gameScore:int;

		// Public variables
		public static var secs:uint = 0;
		public static var mins:uint = 0;

		public function MatchingGameObject()
		{
			//adds the gamescore text field to the screen
			gameScore = 0;
			gameScoreField = new TextField  ;
			addChild(gameScoreField);
			showScore();

			//starts the game timer.
			t.addEventListener(TimerEvent.TIMER, timeTaken);
			t.start();
			// constructor code

			// load 18 pairs of cards into an array
			var cardList:Array = new Array();
			for (var i:uint = 0; i < (BOARD_WIDTH*BOARD_HEIGHT/2); i++)
			{
				cardList.push(i);
				cardList.push(i);
			}

			cardsLeft = 0;
			//loop to position the cards
			for (var x:uint = 0; x < BOARD_WIDTH; x++)
			{
				for (var y:uint = 0; y < BOARD_HEIGHT; y++)
				{
					var c:Card = new Card();
					c.stop();
					c.x = x * HORIZONTAL_SPACING + X_OFFSET;
					c.y = y * VERTICLE_SPACING + Y_OFFSET;
					var r:uint = Math.floor(Math.random() * cardList.length);
					c.cardface = cardList[r];
					cardList.splice(r, 1);
					c.gotoAndStop(1);
					c.addEventListener(MouseEvent.CLICK, clickCard);
					addChild(c);
					cardsLeft++;
				}
			}
		}// main function end
		public function clickCard(e:MouseEvent)
		{
			var thisCard:Card = (e.currentTarget as Card);
			trace(thisCard.cardface);

			if (firstCard == null)
			{
				firstCard = thisCard;
				firstCard.gotoAndStop(thisCard.cardface+2);
			}
			else if (firstCard == thisCard)
			{
				firstCard.gotoAndStop(1);
				firstCard = null;
			}
			else if (secondCard == null)
			{
				secondCard = thisCard;
				secondCard.gotoAndStop(thisCard.cardface+2);
			}

			// compare the cards choosen.
			if (firstCard.cardface == secondCard.cardface)
			{
				//remove a matching pair
				removeChild(firstCard);
				removeChild(secondCard);
				//reset the selection
				firstCard = null;
				secondCard = null;
				//Add points
				gameScore +=  pointsForHit;
				showScore();
				// Check for game over
				cardsLeft -=  2;// 2 less cards
				if (cardsLeft == 0)
				{
					MovieClip(root).gotoAndStop("GameOver");
					t.stop();
					trace("your time was " + mins + " : " + secs);
				}
			}
			else
			{
				gameScore +=  pointsForMiss;
				showScore();
				firstCard.gotoAndStop(1);
				secondCard.gotoAndStop(1);
				secondCard = null;
				firstCard = thisCard;
				firstCard.gotoAndStop(thisCard.cardface+2);

			}

		}// end clickCard


		private function timeTaken(Event:TimerEvent)
		{
			secs++;
			if (secs == 60)
			{
				mins++;
				secs = 0;
			}
		}

		function showScore()
		{
			gameScoreField.text = "Score: " + String(gameScore);
		}
		
	}//matchingGame class end
}//Package end