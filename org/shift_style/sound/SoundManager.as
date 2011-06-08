package org.shift_style.sound {
	import flash.events.EventDispatcher;
	import org.shift_style.sound.core.SoudSEObject;
	import org.shift_style.sound.core.SoundBGMObject;
	import flash.media.Sound;
	import flash.utils.Dictionary;

	/**
	 * @author axcelwork
	 */
	public class SoundManager extends EventDispatcher {
		private static var _bgTrackList:Dictionary = new Dictionary();		private static var _seTrackList:Dictionary = new Dictionary();
		
		
		public function SoundManager(){
			throw new Error("[Alert] SoundManager クラスは static なのでインスタンスを作成することはできません");
		}
		
		/**
		 * SoundManager に Sound をBGMとして追加します。
		 * @param source Soundインスタンス
		 * @param trackID 識別するためのID		 
		 */
		public static function addBackGround(source:Sound, trackID:String):void{
			_bgTrackList[trackID] = new SoundBGMObject(source, trackID);
		}
		
		/**
		 * 指定したIDにもとづき SoundManager から該当インスタンスを削除します。
		 * @param trackID 識別するためのID
		 */
		public static function removeBackGround(trackID:String):Dictionary{
			_bgTrackList[trackID] = null;
			return _bgTrackList;
		}
		
		/**
		 * SoundManager に Sound をSEとして追加します。
		 * @param source Soundインスタンス
		 * @param trackID 識別するためのID		 
		 */
		public static function addSoundEffect(source:Sound, trackID:String):void{
			_seTrackList[trackID] = new SoudSEObject(source, trackID);
		}
		
		/**
		 * 指定したIDにもとづき SoundManager から該当インスタンスを削除します。
		 * @param trackID 識別するためのID
		 */
		public static function removeSoundEffect(trackID:String):Dictionary{
			_seTrackList[trackID] = null;
			return _seTrackList;
		}
		
		
		
		
		/**
		 * 指定した trackID を再生します。
		 * BGMかSEかを自動で判断して最適な方法で再生します。
		 * @param trackID 識別するためのID
		 * @param volume 発音する初期音量。指定しない場合は 1.0 です。
		 * @param time 再生するときのフェードインする時間です。指定しない場合はフェードインしません。
		 */
		public static function play(trackID:String, volume:Number = 1.0, time:Number = 0):void{
			var type:String = checkList(trackID);
			var target:*;
			
			if(type == "SE"){
				target = _seTrackList[trackID] as SoudSEObject;
			}
			else if(type == "BGM"){
				target = _bgTrackList[trackID] as SoundBGMObject;
			}
			else{
				trace( "[Alert] " + trackID + " は登録されていません");
				return;	
			}
			
			target.play(volume, time);
		}
		
		/**
		 * 指定した trackID を停止します。
		 * BGMかSEかを自動で判断して最適な方法で再生します。
		 * @param trackID
		 * @param volume
		 */
		public static function stop( trackID:String, time:Number = 0 ):void {
			var type:String = checkList(trackID);
			var target:*;
			
			if(type == "SE"){
				target = _seTrackList[trackID] as SoudSEObject;
			}
			else if(type == "BGM"){
				target = _bgTrackList[trackID] as SoundBGMObject;
			}
			else{
				trace( "[Alert] " + trackID + " は登録されていません");
				return;	
			}
			
			target.stop(time);
		}
		
		/**
		 * 指定した trackID をミュート状態にします。
		 * ミュート時に呼び出すとミュートが解除されます。
		 * BGMかSEかを自動で判断して最適な方法で再生します。
		 * @param trackID
		 * @param volume
		 */
		public static function mute(trackID:String, time:Number = 0):void{
			var type:String = checkList(trackID);
			var target:*;
			
			if(type == "SE"){
				target = _seTrackList[trackID] as SoudSEObject;
			}
			else if(type == "BGM"){
				target = _bgTrackList[trackID] as SoundBGMObject;
			}
			else{
				trace( "[Alert] " + trackID + " は登録されていません");
				return;	
			}
			
			target.mute(time);
		}
		
		/**
		 * 指定した trackID の音量を設定します。
		 * @param trackID
		 * @param volume
		 */
		public static function volume( trackID:String, volume:Number ):void {
			var type:String = checkList(trackID);
			var target:*;
			
			if(type == "SE"){
				target = _seTrackList[trackID] as SoudSEObject;
			}
			else if(type == "BGM"){
				target = _bgTrackList[trackID] as SoundBGMObject;
			}
			else{
				trace( "[Alert] " + trackID + " は登録されていません");
				return;	
			}
			
			target.setVolume(volume);
		}
		
		
		/**
		 * 指定した trackID のタイプ(SE/BGM)を返します。
		 * @param trackID
		 */
		public static function getType( trackID:String):String {
			var type:String = checkList(trackID);
			
			if(type != "SE" && type != "BGM"){
				type = "指定した " + trackID + " は登録されていません";
				trace( "[Alert] " + trackID + " は登録されていません");
			}
			
			return type;
		}
		
		/**
		 * 指定した trackID の状況を取得します。
		 * play
		 * stop
		 * mute
		 */
		public static function status(trackID:String):Dictionary{
			var _status:Dictionary = new Dictionary();
			var type:String = checkList(trackID);
			var target:*;
			
			if(type == "SE"){
				target = _seTrackList[trackID] as SoudSEObject;
			}
			else if(type == "BGM"){
				target = _bgTrackList[trackID] as SoundBGMObject;
			}
			else{
				trace( "[Alert] " + trackID + " は登録されていません");
			}
			
			_status[play] = target._isPlay;			_status[stop] = target._isMute;			_status[mute] = target.volume;			_status[volume] = 0;
			
			return _status;
		}

		
		private static function checkList(trackID:String):String{
			var type:String;
			
			if(_seTrackList[trackID] != null) {
				type = "SE";
			}
			else if(_bgTrackList[trackID] != null){
				type = "BGM";
			}
			else{
				type = trackID;
			}
			
			return type;
		}
	}
}
