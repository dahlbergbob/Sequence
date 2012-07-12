/**
 * User: Bob Dahlberg
 * Date: 2012-06-21
 * Time: 09:39
 */
package com.boblu.sequence.mock
{
	import com.boblu.sequense.SimpleCall;

	public class DelegateExtender extends SimpleCall
	{

		public function DelegateExtender( to:Function, ... parameters )
		{
			super( to, parameters );
		}
		
		public function get onHold():Boolean
		{
			return _onHold;
		}
	}
}
