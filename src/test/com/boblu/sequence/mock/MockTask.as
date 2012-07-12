/**
 * User: Bob Dahlberg
 * Date: 2012-07-09
 * Time: 09:41
 */
package com.boblu.sequence.mock
{
	import com.boblu.sequence.mock.MockCall;
	import com.boblu.sequense.Task;

	public class MockTask extends Task
	{
		private var _value:String;
		private var _result:Vector.<String>;
		
		public function MockTask( value:String, result:Vector.<String> )
		{
			_value = value;
			_result = result;
		}
		
		override public function execute():void
		{
			MockCall.add( _value, _result );
		}

		override public function clean():void
		{
			_value = null;
			_result = null;
		}
	}
}
