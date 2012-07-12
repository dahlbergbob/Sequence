/**
 * User: Bob Dahlberg
 * Date: 2012-06-13
 * Time: 14:01
 */
package
{
	import flash.display.Sprite;
	import flash.events.Event;

	public class Main extends Sprite
	{
		/**
		 * Constructor makes sure the application has stage before proceeding
		 */
		public function Main()
		{
			if( stage == null )
				addEventListener( Event.ADDED_TO_STAGE, init );
			else
				init();
		}

		/**
		 * Starting the application 
		 */
		private function init( e:Event = null ):void
		{
			trace( ".: Running sequence example :." );
		}
	}
}
