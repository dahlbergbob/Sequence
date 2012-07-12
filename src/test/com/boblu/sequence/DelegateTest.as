/**
 * User: Bob Dahlberg
 * Date: 2012-02-23
 * Time: 09:33
 */
package com.boblu.sequence
{
	import com.boblu.sequence.mock.DelegateExtender;
	import com.boblu.sequence.Delegate;

	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;

	public class DelegateTest
	{
		private const ONE:Number = Math.random();
		private const TWO:Number = Math.random();
		private const THREE:Number = Math.random();
		
		private var _called:Boolean;
		private var _call:Delegate;
		
		[Before]
		public function setUp():void
		{
			_called = false;
		}

		[After]
		public function tearDown():void
		{
		}

		[Test(description="Test calling without parameters")]
		public function testCall():void
		{
			_call = new Delegate( callWithout );
			_call.execute();
			assertThat( _called, equalTo( true ) );
		}

		[Test(description="Test calling without parameters but with reference")]
		public function testReferenceCall():void
		{
			_call = new Delegate( callWithReference );
			_call.useReference = true;
			_call.execute();
			assertThat( _called, equalTo( true ) );
		}

		[Test(description="Test calling with one parameter")]
		public function testCallWithOne():void
		{
			_call = new Delegate( callWithOne, [ONE] );
			_call.execute();
			assertThat( _called, equalTo( true ) );
		}

		[Test(description="Test calling with one parameter and reference")]
		public function testReferenceCallWithOne():void
		{
			_call = new Delegate( callWithReferenceOne, [ONE] );
			_call.useReference = true;
			_call.execute();
			assertThat( _called, equalTo( true ) );
		}

		[Test(description="Test calling with three parameters")]
		public function testCallWithThree():void
		{
			_call = new Delegate( callWithThree, [ONE, TWO, THREE] );
			_call.execute();
			assertThat( _called, equalTo( true ) );
		}

		[Test(description="Test calling with three parameters and reference")]
		public function testReferenceCallWithThree():void
		{
			_call = new Delegate( callWithReferenceThree, [ONE, TWO, THREE] );
			_call.useReference = true;
			_call.execute();
			assertThat( _called, equalTo( true ) );
		}

		[Test(description="Test calling extended call with three parameters")]
		public function testExtendedCallWithThree():void
		{
			_call = new DelegateExtender( callWithThree, ONE, TWO, THREE );
			_call.execute();
			assertThat( _called, equalTo( true ) );
		}

		[Test(description="Test calling extended call with an array as parameter")]
		public function testExtendedCallWithArray():void
		{
			_call = new DelegateExtender( callWithArray, [ONE, TWO, THREE] );
			_call.execute();
			assertThat( _called, equalTo( true ) );
		}

		[Test(description="Test calling extended call with an array as parameter and reference")]
		public function testExtendedReferenceCallWithArray():void
		{
			_call = new DelegateExtender( callWithReferenceArray, [ONE, TWO, THREE] );
			_call.useReference = true;
			_call.execute();
			assertThat( _called, equalTo( true ) );
		}


		private function callWithout():void
		{
			_called = true;
		}
		private function callWithReference( reference:Delegate ):void
		{
			_called = ( reference is Delegate );
		}
		private function callWithOne( one:Number ):void
		{
			_called = ( one == ONE );
		}
		private function callWithReferenceOne( one:Number, reference:Delegate ):void
		{
			_called = ( one == ONE && ( reference is Delegate ) );
		}
		private function callWithThree( one:Number, two:Number, three:Number ):void
		{
			_called = ( one == ONE && two == TWO && three == THREE );
		}
		private function callWithReferenceThree( one:Number, two:Number, three:Number, reference:Delegate ):void
		{
			_called = ( one == ONE && two == TWO && three == THREE && ( reference is Delegate ) );
		}
		private function callWithArray( arr:Array ):void
		{
			_called = ( arr.length > 0 );
		}
		private function callWithReferenceArray( arr:Array, reference:Delegate ):void
		{
			_called = ( arr.length > 0 && ( reference is Delegate ) );
		}
	}
}
