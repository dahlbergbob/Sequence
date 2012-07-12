/**
 * User: Bob Dahlberg
 * Date: 2012-06-21
 * Time: 08:56
 */
package com.boblu.sequense
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
		 * Tell the IDelegate to send a reference to itself when calling its function
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
		 * Holds the IDelegate from executing further and from reporting that its done.
		 */
		public function hold():void
		{
			_onHold = true;
		}

		/**
		 * Releases an held IDelegate to make it resume its agenda.
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
