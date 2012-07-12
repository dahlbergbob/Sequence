/**
 * User: Bob Dahlberg
 * Date: 2012-06-21
 * Time: 10:54
 */
package com.boblu.sequense
{
	public class SimpleCall extends Delegate
	{
		protected var _onComplete:Function;

		/**
		 * Creates a new Delegate to a function with any number of parameters with a callback when it's done
		 * @param to			The function to call
		 * @param parameters	An array of parameters to send to the function
		 */
		public function SimpleCall( to:Function, parameters:Array = null )
		{
			super( to, parameters );
		}

		/**
		 * @inheritDoc
		 */
		override protected function done():void
		{
			super.done();

			if( _onComplete != null )
				_onComplete();
		}

		/**
		 * Set a callback for when the Delegate is done and is not on hold
		 */
		public function set onComplete( value:Function ):void	{	_onComplete = value;	}
	}
}
