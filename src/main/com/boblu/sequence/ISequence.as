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
	public interface ISequence
	{
		/**
		 * Adds a simple call to be executed in the sequence
		 * @param call			The function to call
		 * @param parameters	0 to N parameters to delegate to the call
		 */
		function addCall( call:Function, ...parameters ):void;
		
		/**
		 * Adds a task to execute in the sequence
		 * @param task			The ITask to execute.
		 * @param concurrent	Flag if the task can be run concurrently with the previous task or wait for it to finish. Default false.
		 */
		function addTask( task:ITask, concurrent:Boolean = false ):void;

		/**
		 * Holds the sequence at the current execution and waits for the sequence to be released before executing further
		 */
		function hold():void;

		/**
		 * Releases the current sequence to execute any remaining tasks
		 */
		function release():void;
	}
}
