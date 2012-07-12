/**
 * User: Bob Dahlberg
 * Date: 2012-07-09
 * Time: 09:41
 */
package com.boblu.sequence.mock
{
	import com.boblu.sequense.SequentialTask;
	import com.boblu.sequense.Task;

	public class MockTaskAddExtra extends SequentialTask
	{
		private var _value:String;
		private var _result:Vector.<String>;
		private var _addOnParent:Boolean;
		
		public function MockTaskAddExtra( value:String, result:Vector.<String>, addOnParent:Boolean )
		{
			_addOnParent = addOnParent;
			_value = value;
			_result = result;
		}
		
		override public function execute():void
		{
			if( _addOnParent )
			{
				_sequence.addTask( new MockTask( _value, _result ) );
			}
		}

		override public function clean():void
		{
			_value = null;
			_result = null;
		}
	}
}
