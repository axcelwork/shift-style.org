package org.shift_style.twit {
	import flash.events.EventDispatcher;
	import org.shift_style.sound.core.SoudSEObject;
	import org.shift_style.sound.core.SoundBGMObject;
	import flash.media.Sound;
	import flash.utils.Dictionary;

	/**
	 * @author axcelwork
	 */
	public class TwitterManager extends EventDispatcher {
		private static var _bgTrackList:Dictionary = new Dictionary();		private static var _seTrackList:Dictionary = new Dictionary();
		
		
		public function TwitterManager(){
			throw new Error("[Alert] TwitterManager クラスは static なのでインスタンスを作成することはできません");
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
		

	}
}
