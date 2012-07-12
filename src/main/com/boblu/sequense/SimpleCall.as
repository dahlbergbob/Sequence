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
	public class SimpleCall extends Delegate
	{
		protected var _onComplete:Function;

		/**
		 * Creates a new Delegate to a function with any number of parameters with a callback when it's done
		 * @param to			The function to call
		 * @param parameters	An array of parameters to send to the function
		 */
		public function SimpleCall( to:Function, parameters:Array = null )
		{
			super( to, parameters );
		}

		/**
		 * @inheritDoc
		 */
		override protected function done():void
		{
			super.done();

			if( _onComplete != null )
				_onComplete();
		}

		/**
		 * Set a callback for when the Delegate is done and is not on hold
		 */
		public function set onComplete( value:Function ):void	{	_onComplete = value;	}
	}
}
