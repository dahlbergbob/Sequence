/*
 * Sequence 1.0
 * Copyright (C) 2012 Bob Dahlberg
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */
package com.boblu.sequense
{
	public class Sequence extends SequentialTask implements ISequence
	{
		protected var _queue:Vector.<ITask>;
		protected var _working:Vector.<ITask>;
		protected var _concurrent:Vector.<Boolean>;
		private var _holds:int;
		private var _handled:Boolean;

		/**
		 * Creates a new Sequence
		 */
		public function Sequence()
		{
			_queue = new Vector.<ITask>();
			_working = new Vector.<ITask>();
			_concurrent = new Vector.<Boolean>();
			_holds = 0;
			_handled = false;
		}

		/**
		 * Adds a simple call inside of the sequence
		 * @param call			The function to call
		 * @param parameters	The parameters to delegate to the call
		 */
		public function addCall( call:Function, ... parameters ):void
		{
			if( parameters.length == 0 )
				parameters = null;

			_queue.push( new Delegate( call, parameters ) );
			_concurrent.push( false );
		}

		/**
		 * Adds a task to execute in the sequence
		 * @param task	The ITask to execute.
		 */
		public function addTask( task:ITask, concurrent:Boolean = false ):void
		{
			_queue.push( task );
			_concurrent.push( concurrent );
		}

		/**
		 * Executes the sequence
		 */
		override public function execute():void
		{
			holdParent();
			_concurrent.shift();
			var task:ITask = _queue.shift();
			if( task is ISequentialTask )
			{
				ISequentialTask( task ).sequence = this;
			}
			
			_working.push( task );
			task.execute();
			executeNext();
		}

		private function holdParent():void
		{
			if( _sequence != null && !_handled )
			{
				_sequence.hold();
				_handled = true;
			}
		}

		public function hold():void
		{
			_holds++;
		}

		public function release():void
		{
			_holds--;
			executeNext();
		}
		
		private function executeNext():void
		{
			if( _working == null || _queue == null )
				return;
			
			if( _holds == 0 )
				cleanWorking();
			
			if( _working.length > 0 && !isNextConurrent() )
				return;
			
			if( _queue.length == 0 )
			{
				finish();
				return;
			}
			
			execute();
		}

		private function isNextConurrent():Boolean
		{
			if( _concurrent.length > 0 )
				return _concurrent[0];
			
			return false;
		}

		private function cleanWorking():void
		{
			while( _working.length > 0 )
			{
				_working[0].clean();
				_working.shift();
			}
		}
		
		protected function finish():void
		{
			if( _sequence != null )
			{
				_sequence.release();
			}
			else
			{
				clean();
			}
		}
		
		override public function clean():void
		{
			super.clean();
			_queue 		= null;
			_working	= null;
			_concurrent	= null;
		}
	}
}
