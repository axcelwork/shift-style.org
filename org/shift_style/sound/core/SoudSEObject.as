package org.shift_style.sound.core {
	import flash.media.SoundTransform;
	import flash.events.Event;
	import flash.media.Sound;


	public class SoudSEObject extends ExSoundObject {

		
		/**
		 * 
		 */
		public function SoudSEObject(sound:Sound, track:String, loop:Boolean = false, isMute:Boolean = false) {
			super(sound, track, loop, isMute);
		}
		
		/**
		 * 
		 */
		public override function play(volume:Number = 1, time:Number = 0):void {
			this._isPlay = true;
			
			this._channel = this._sound.play(0);
			this._channel.addEventListener(Event.SOUND_COMPLETE, playComplete);
			
			var trans:SoundTransform = this._channel.soundTransform;
			trans.volume = volume;
			this._channel.soundTransform = trans;
			
			this._volume = this.volume;
			
			if(this._isMute) {
				trans.volume = 0;
				this._channel.soundTransform = trans;
				return;
			}
			
		}
		
		/**
		 * 
		 */
		private function playComplete(e:Event):void {
			this._isPlay = false;
		}
		
		/**
		 * 停止します
		 */
		public override function stop(time:Number = 0):void {
			
			// 再生されていなかったら無効
			if (!this._isPlay) return;
			
			this._isPlay = false;
			this._channel.stop();
		}
	}
}