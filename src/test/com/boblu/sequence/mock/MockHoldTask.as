/**
 * User: Bob Dahlberg
 * Date: 2012-07-09
 * Time: 09:59
 */
package com.boblu.sequence.mock
{
	import com.boblu.sequense.SequentialTask;

	public class MockHoldTask extends SequentialTask
	{
		private var _running:Boolean = false;
		
		override public function execute():void
		{
			_running = true;
			_sequence.hold();
		}
		
		public function releaseMock():void
		{
			_running = false;
			_sequence.release();
		}

		public function get running():Boolean
		{
			return _running;
		}
	}
}
