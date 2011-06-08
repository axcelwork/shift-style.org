package org.shift_style.net {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.media.Sound;
	import flash.net.URLRequest;

	/**
	 * @author axcelwork
	 */
	public class SoundLoadRequest extends EventDispatcher {
		private var _id:String;
		
		private var _source:Sound;
		private var _request:URLRequest = new URLRequest();
		private var _response:Sound;

		private var _bytesLoaded:int = 0;
		private var _bytesTotal:int = 0;
		private var _opened:Boolean = false;
		private var _completed:Boolean = false;
		
		/**
		 * 新しい SoundLoadRequest インスタンスを作成します.
		 * @param id
		 * @param url
		 */
		public function SoundLoadRequest( url:String = null, id:String = null) {
			//this._source = new Sound();
			this.url = url;
			this.id = id;
		}

		/**
		 * リクエストされる URL です。
		 */
		public function get url():String { return request.url; }
		public function set url(value:String):void { request.url = value; }

		/**
		 * リクエストに付加する ID です。同一のローダー内で使用するリクエストは一意の ID にする必要があります。
		 */
		public function get id():String { return _id; }
		public function set id(value:String):void { _id = value; }

		/**
		 * @private
		 */
		internal function get request():URLRequest { return _request; }

		/**
		 * @private
		 */
		internal function get response():* { return _response; }

		/**
		 * @private
		 */
		internal function get bytesLoaded():int { return _bytesLoaded; }

		/**
		 * @private
		 */
		internal function get bytesTotal():int { return _bytesTotal; }

		/**
		 * @private
		 */
		internal function get opened():Boolean { return _opened; }

		/**
		 * @private
		 */
		internal function get completed():Boolean { return _completed; }

		
		/**
		 * @private
		 */
		internal function load():void {
			request.url = url;
            
            this._source = new Sound(request);
			//this._source.load(request);
			this._source.addEventListener(Event.OPEN, open);
			this._source.addEventListener(ProgressEvent.PROGRESS, progress);
			this._source.addEventListener(Event.COMPLETE, complete);
			
			this._source.addEventListener(IOErrorEvent.IO_ERROR, ioError);
			this._source.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityError);
		}
		
		
		/**
		 * 
		 */
		private function open(e:Event):void {
			_opened = true;
			dispatchEvent(e);
		}

		/**
		 * 
		 */
		private function progress(e:ProgressEvent):void {
			_bytesLoaded = e.bytesLoaded;
			_bytesTotal = e.bytesTotal;
            
			dispatchEvent(e);
		}

		/**
		 * 
		 */
		private function complete(event:Event):void {
			_response = this._source;
			_completed = true;
            
			dispatchEvent(event);
		}

		/**
		 * 
		 */
		private function ioError(e:IOErrorEvent):void {
			dispatchEvent(e);
		}

		/**
		 * 
		 */
		private function securityError(e:SecurityErrorEvent):void {
			dispatchEvent(e);
		}
	}
}
