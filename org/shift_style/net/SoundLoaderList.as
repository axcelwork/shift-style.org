package org.shift_style.net {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.utils.Dictionary;

	/**
	 * @author axcelwork
	 */
	public class SoundLoaderList extends EventDispatcher {
		public static var _instance:SoundLoaderList;
		private var _requests:Dictionary = new Dictionary();
		private var _waitAllOpened:Boolean = true;

		public static function get instance():SoundLoaderList {
			if ( _instance === null ) { 
				_instance = new SoundLoaderList; 
			}
			return _instance;
		}
		
		
		/**
		 * 登録されているリクエストに対応するデータが全て読み込み開始になるのを待ってからイベントを発行するか否かです。<br>
		 * true に設定することにより、progress イベント発行時に loadedTotal が一定値を保ちます。
		 * 
		 * @default true
		 */
		public function get waitAllOpened():Boolean { return this._waitAllOpened; }
		public function set waitAllOpened(value:Boolean):void { this._waitAllOpened = value; }

		
		/**
		 * 対象のリクエストを登録します。
		 * 
		 * @param request 登録対象のリクエストです。
		 * 
		 * @return 登録されたリクエストです。
		 * 
		 * @throws ArgumentError 重複するリクエストを追加した場合。
		 * @throws ArgumentError リクエストに URL が存在しない場合。
		 */
		public function addRequest(request:SoundLoadRequest):SoundLoadRequest {
			_requests[request] = request;
			return request;
		}
		
		/**
		 * 読み込みが完了した ID に対応するレスポンスデータを取得します。
		 * 
		 * @param request レスポンスデータに対応する ID です。
		 * @return ID に対応するレスポンスデータです。
		 * @throws ArgumentError ID に対応するレスポンスデータが存在しない場合。
		 */
		public function getResponseById(id:String):* {
			for each (var request:SoundLoadRequest in _requests) {
				if (id == request.id) {
					if (request.response != null) {
						return request.response;
					}
				}
			}
            
			throw new ArgumentError("ID に対応するデータが存在しません。");
		}

		/**
		 * 登録されているリクエストの読み込みを開始します。
		 */
		public function load():void {
			for each (var request:SoundLoadRequest in _requests) {
				addEventListenerTo(request);
				request.load();
			}
		}

		/**
		 * @private
		 */
		private function addEventListenerTo(request:SoundLoadRequest):void {
			request.addEventListener(Event.OPEN, open);
			request.addEventListener(ProgressEvent.PROGRESS, progress);
			request.addEventListener(Event.COMPLETE, complete);
		}

		/**
		 * @private
		 */
		private function removeEventListenerFrom(request:SoundLoadRequest):void {
			request.removeEventListener(Event.OPEN, open);
			request.removeEventListener(ProgressEvent.PROGRESS, progress);
			request.removeEventListener(Event.COMPLETE, complete);
		}

		/**
		 * @private
		 */
		private function open(event:Event):void {
			var allOpened:Boolean = true;
            
			for each (var request:SoundLoadRequest in _requests) {
				if (!waitAllOpened) {
					request.removeEventListener(Event.OPEN, open);
				}
                
				if (!request.opened) {
					allOpened = false;
				}
			}
            
			if (allOpened || !waitAllOpened) {
				dispatchEvent(new Event(Event.OPEN));
			}
		}

		/**
		 * @private
		 */
		private function progress(event:ProgressEvent):void {
			var allOpened:Boolean = true;
            
			var bytesLoaded:int = 0;
			var bytesTotal:int = 0;
            
			for each (var request:SoundLoadRequest in _requests) {
				if (!request.opened) {
					allOpened = false;
					break;
				}
                
				bytesLoaded += request.bytesLoaded;
				bytesTotal += request.bytesTotal;
			}
            
			if (allOpened || !waitAllOpened) {
				dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS, false, false, bytesLoaded, bytesTotal));
			}
		}

		/**
		 * @private
		 */
		private function complete(event:Event):void {
			removeEventListenerFrom(SoundLoadRequest(event.target));
            
			var allCompleted:Boolean = true;
            
			var bytesLoaded:int = 0;
			var bytesTotal:int = 0;
			var response:Array = [];
            
			for each (var request:SoundLoadRequest in _requests) {
				if (!request.completed) {
					allCompleted = false;
					break;
				}
                
				bytesLoaded += request.bytesLoaded;
				bytesTotal += request.bytesTotal;
				response.push(request.response);
			}
            
			if (allCompleted) {
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
	}
}
