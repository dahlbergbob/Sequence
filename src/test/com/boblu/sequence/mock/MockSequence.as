/**
 * User: Bob Dahlberg
 * Date: 2012-07-12
 * Time: 09:12
 */
package com.boblu.sequence.mock
{
	import com.boblu.sequence.*;
	public class MockSequence extends Sequence
	{
		public function MockSequence()
		{
			super();
		}
		
		public function isCleaned():Boolean
		{
			if( _concurrent == null )
				if( _sequence == null )
					if( _working == null )
						if( _queue == null )
							return true;
			
			return false;
		}
	}
}
