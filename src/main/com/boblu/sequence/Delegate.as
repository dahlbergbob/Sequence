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
package com.boblu.sequence
{
	public class Delegate implements ITask
	{
		private var _to:Function;
		private var _arguments:Array;
		private var _useReference:Boolean;
		
		protected var _onHold:Boolean;

		/**
		 * Creates a new Delegate to a function with any number of parameters
		 * @param to			The function to call
		 * @param parameters	An array of parameters to send to the function
		 */
		public function Delegate( to:Function, parameters:Array = null )
		{
			_onHold = false;
			_useReference = false;
			_to = to;
			
			if( parameters != null )
				_arguments = parameters;
			else
				_arguments = [];
		}

		/**
		 * Tell the Delegate to send a reference to itself when calling its function
		 */
		public function set useReference( value:Boolean ):void
		{
			_useReference = value;
		}

		/**
		 * Executes the call to the specified function
		 */
		public function execute():void
		{
			if( _useReference )
				_arguments.push( this );
			
			_to.apply( this, _arguments );
			done();
		}

		/**
		 * Called when the function is called or released
		 */
		protected function done():void
		{
			if( _onHold )
				return;
		}

		/**
		 * Holds the Delegate from executing further and from reporting that its done.
		 */
		public function hold():void
		{
			_onHold = true;
		}

		/**
		 * Releases an held Delegate to make it resume its agenda.
		 */
		public function release():void
		{
			_onHold = false;
			done();
		}

		public function clean():void
		{
		}
	}
}
