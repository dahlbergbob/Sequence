/**
 * User: Bob Dahlberg
 * Date: 2012-02-23
 * Time: 09:33
 */
package com.boblu.sequence
{
	import com.boblu.sequence.mock.MockCall;
	import com.boblu.sequence.mock.MockHoldTask;
	import com.boblu.sequence.mock.MockSequence;
	import com.boblu.sequence.mock.MockTask;
	import com.boblu.sequence.mock.MockTaskAddExtra;
	import com.boblu.sequense.ISequence;
	import com.boblu.sequense.Sequence;

	import org.hamcrest.assertThat;
	import org.hamcrest.core.not;
	import org.hamcrest.object.IsInstanceOfMatcher;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.nullValue;

	public class SequenceTest
	{
		private var _sequence:Sequence;
		private var _result:Vector.<String>;
		
		[Before]
		public function setUp():void
		{
			_result = new Vector.<String>();
			_sequence = new Sequence();
		}

		[After]
		public function tearDown():void
		{
			_sequence = null;
			_result = null;
		}

		[Test(description="Test a simple call with parameters")]
		public function testSimpleCall():void
		{
			_sequence.addCall( MockCall.add, "1", _result );
			_sequence.execute();
			assertThat( _result.toString(), equalTo( "1" ) );
		}

		[Test(description="Test a sequence of simple call with parameters")]
		public function testSequenceSimpleCall():void
		{
			_sequence.addCall( MockCall.add, "1", _result );
			_sequence.addCall( MockCall.add, "3", _result );
			_sequence.addCall( MockCall.add, "2", _result );
			_sequence.execute();
			assertThat( _result.toString(), equalTo( "1,3,2" ) );
		}

		[Test(description="Test a sequence of simple calls and tasks")]
		public function testSequence():void
		{
			_sequence.addCall( MockCall.add, "a", _result );
			_sequence.addCall( MockCall.add, "b", _result );
			_sequence.addTask( new MockTask( "c", _result ) );
			_sequence.addCall( MockCall.add, "d", _result );
			_sequence.addTask( new MockTask( "e", _result ) );
			_sequence.addTask( new MockTask( "f", _result ) );
			_sequence.addCall( MockCall.add, "g", _result );
			assertThat( _result.toString(), equalTo( "" ) );
			_sequence.execute();
			assertThat( _result.toString(), equalTo( "a,b,c,d,e,f,g" ) );
		}

		[Test(description="Test a task that holds the sequence")]
		public function testSequenceHold():void
		{
			var holdTask:MockHoldTask = new MockHoldTask();

			_sequence.addTask( new MockTask( "a", _result ) );
			_sequence.addTask( holdTask );
			_sequence.addTask( new MockTask( "b", _result ) );
			_sequence.execute();

			assertThat( _result.toString(), equalTo( "a" ) );
			holdTask.releaseMock();
			assertThat( _result.toString(), equalTo( "a,b" ) );
		}

		[Test(description="Test a task that holds the sequence with a concurrent task after it")]
		public function testSequenceHoldConcurrent():void
		{
			var holdTask:MockHoldTask = new MockHoldTask();

			_sequence.addTask( new MockTask( "a", _result ) );
			_sequence.addTask( holdTask );
			_sequence.addTask( new MockTask( "b", _result ), true );
			_sequence.addTask( new MockTask( "c", _result ), true );
			_sequence.addTask( new MockTask( "d", _result ) );
			_sequence.addTask( new MockTask( "e", _result ), true );

			assertThat( _result.toString(), equalTo( "" ) );
			_sequence.execute();
			assertThat( _result.toString(), equalTo( "a,b,c" ) );
			holdTask.releaseMock();
			assertThat( _result.toString(), equalTo( "a,b,c,d,e" ) );
		}

		[Test(description="Test a task that holds the sequence with a concurrent task after it and the concurrent task is last")]
		public function testSequenceHoldConcurrentLast():void
		{
			var holdTask:MockHoldTask = new MockHoldTask();
			var holdTask2:MockHoldTask = new MockHoldTask();

			_sequence.addTask( new MockTask( "a", _result ) );
			_sequence.addTask( holdTask );
			_sequence.addTask( new MockTask( "b", _result ), true );
			_sequence.addTask( new MockTask( "c", _result ), true );
			_sequence.addTask( new MockTask( "d", _result ) );
			_sequence.addTask( holdTask2 );
			_sequence.addTask( new MockTask( "e", _result ), true );

			assertThat( _result.toString(), equalTo( "" ) );
			_sequence.execute();
			assertThat( _result.toString(), equalTo( "a,b,c" ) );
			holdTask.releaseMock();
			assertThat( _result.toString(), equalTo( "a,b,c,d,e" ) );
			assertThat( holdTask.running, equalTo( false ) );
			assertThat( holdTask2.running, equalTo( true ) );
			holdTask2.releaseMock();
			assertThat( holdTask2.running, equalTo( false ) );
		}
		
		[Test(description="Test a sequence in another sequence")]
		public function testNestingSequences():void
		{
			var sequence2:Sequence = new Sequence();

			sequence2.addTask( new MockTask( "1", _result ) );
			sequence2.addTask( new MockTask( "2", _result ) );
			sequence2.addTask( new MockTask( "3", _result ) );
			
			_sequence.addTask( new MockTask( "a", _result ) );
			_sequence.addTask( new MockTask( "b", _result ) );
			_sequence.addTask( sequence2 );
			_sequence.addTask( new MockTask( "c", _result ) );
			_sequence.addTask( new MockTask( "d", _result ) );
			
			_sequence.execute();
			assertThat( _result.toString(), equalTo( "a,b,1,2,3,c,d" ) );
		}

		[Test(description="Test a sequence in another sequence with a concurrent task after the sequence")]
		public function testNestingSequencesAndConcurrentTasks():void
		{
			var sequence2:Sequence = new Sequence();
			var holdTask:MockHoldTask = new MockHoldTask();

			sequence2.addTask( new MockTask( "1", _result ) );
			sequence2.addTask( new MockTask( "2", _result ) );
			sequence2.addTask( new MockTask( "3", _result ) );
			sequence2.addTask( holdTask, true );

			_sequence.addTask( new MockTask( "a", _result ) );
			_sequence.addTask( new MockTask( "b", _result ) );
			_sequence.addTask( sequence2 );
			_sequence.addTask( new MockTask( "c", _result ), true );
			_sequence.addTask( new MockTask( "d", _result ) );

			_sequence.execute();
			assertThat( _result.toString(), equalTo( "a,b,1,2,3,c" ) );
			holdTask.releaseMock();
			assertThat( _result.toString(), equalTo( "a,b,1,2,3,c,d" ) );
		}

		[Test(description="Test a sequence in another sequence with a concurrent task after the sequence and hold task not at the end")]
		public function testNestingSequencesAndConcurrentTasksAndHoldTasks():void
		{
			var sequence2:Sequence = new Sequence();
			var holdTask:MockHoldTask = new MockHoldTask();

			sequence2.addTask( new MockTask( "1", _result ) );
			sequence2.addTask( new MockTask( "2", _result ) );
			sequence2.addTask( holdTask, true );
			sequence2.addTask( new MockTask( "3", _result ) );

			_sequence.addTask( new MockTask( "a", _result ) );
			_sequence.addTask( new MockTask( "b", _result ) );
			_sequence.addTask( sequence2 );
			_sequence.addTask( new MockTask( "c", _result ), true );
			_sequence.addTask( new MockTask( "d", _result ) );

			_sequence.execute();
			assertThat( _result.toString(), equalTo( "a,b,1,2,c" ) );
			holdTask.releaseMock();
			assertThat( _result.toString(), equalTo( "a,b,1,2,c,3,d" ) );
		}
		
		[Test(description="Test a self-cleaning sequence when it's done")]
		public function testSelfCleaningSequence():void
		{
			var sequence2:MockSequence = new MockSequence();

			sequence2.addTask( new MockTask( "1", _result ) );
			sequence2.addTask( new MockTask( "2", _result ) );
			sequence2.addTask( new MockTask( "3", _result ) );
			sequence2.execute();

			assertThat( _result.toString(), equalTo( "1,2,3" ) );
			assertThat( sequence2.isCleaned(), equalTo( true ) );
		}

		[Test(description="Test a sequential task adding a new task to it's parent sequenct")]
		public function testInjectIntoParentSequence():void
		{
			_sequence.addTask( new MockTask( "a", _result ) );
			_sequence.addTask( new MockTaskAddExtra( "1", _result, true ) );
			_sequence.addTask( new MockTask( "b", _result ) );
			_sequence.execute();
			assertThat( _result.toString(), equalTo( "a,b,1" ) );
		}
	}
}
