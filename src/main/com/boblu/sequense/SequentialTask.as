/**
 * User: Bob Dahlberg
 * Date: 2012-07-09
 * Time: 08:31
 */
package com.boblu.sequense
{
	public class SequentialTask extends Task implements ISequentialTask
	{
		protected var _sequence:ISequence;
		
		public function set sequence( value:ISequence ):void
		{
			_sequence = value;
		}


		override public function clean():void
		{
			super.clean();
			_sequence = null;
		}
	}
}
