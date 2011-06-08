package org.shift_style.sound.core {
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;

	/**
	 * @author axcelwork
	 */
	public class ExSoundObject {
		public var _trackID:String;
		public var _isLoop:Boolean;
		public var _isMute:Boolean = false;
		public var _isPlay:Boolean = false;
		public var _isValiable:Boolean = false;

		protected var _sound:Sound;
		protected var _channel:SoundChannel;
		protected var _volume:Number;

		/**
		 * getter / setter
		 */
		public function set volume(value:Number):void {  this._channel.soundTransform.volume = value; }
		public function get volume():Number {
			if (!this._channel) return NaN;
			else return this._channel.soundTransform.volume;
		}		

		/**
		 * 新しい ExSoundObject インスタンスを作成します
		 */
		public function ExSoundObject(source:Sound, trackID:String, loop:Boolean = false, mute:Boolean = false) {
			this._sound = source;
			this._trackID = trackID;
			
			this._isMute = mute;
			this._isLoop = loop;
			this._isValiable = true;
			
			// 無音再生して初期化します
			var trans:SoundTransform = new SoundTransform();
			trans.volume = 0;
			this._channel = this._sound.play(1, 0, trans);
			this._channel.stop();
		}

		/**
		 * 設定したサウンドを再生します
		 */
		public function play(volume:Number = 1, time:Number = 0):void {}

		
		/**
		 * 設定したサウンドを停止します
		 */
		public function stop(time:Number = 0):void {}

		/**
		 * ExSoundObject を開放します
		 */
		public function dispose():void {
			this._isValiable = false;
			this._trackID = null;
			this._sound = null;
			this._channel = null;
		}

		/**
		 * 
		 */
		public function setVolume(volume:Number):void {
			
			// 音量制限
			if (volume < 0) volume = 0;
			else if (2 < volume) volume = 2;
			
			// ミュート解除時のために仮音量を保持する
			this._volume = volume;
			
			// ミュート中はvolume=0を反映して処理終了
			if (this._isMute) {
				volume = 0;
				return;
			}
			
			var trans:SoundTransform = this._channel.soundTransform;
			trans.volume = volume;
			this._channel.soundTransform = trans;
		}

		/**
		 * 
		 */
		public function mute(time:Number):void {
			this._isMute = !this._isMute;
			var trans:SoundTransform = this._channel.soundTransform;
			
			if(this._isMute) {
				trans.volume = 0;			} else {
				trans.volume = this._volume;
			}
			this._channel.soundTransform = trans;
		}
	}
}
