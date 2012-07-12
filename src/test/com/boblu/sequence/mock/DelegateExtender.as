/**
 * User: Bob Dahlberg
 * Date: 2012-06-21
 * Time: 09:39
 */
package com.boblu.sequence.mock
{
	import com.boblu.sequence.Delegate;

	public class DelegateExtender extends Delegate
	{

		public function DelegateExtender( to:Function, ... parameters )
		{	
			super( to, parameters );
		}
	}
}
