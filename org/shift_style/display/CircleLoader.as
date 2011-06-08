package org.shift_style.display {
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.display.Sprite;

	/**
	 * @author yamaji
	 */
	public class CircleLoader extends Sprite {
		/*** プロパティ ***/
		private var timer:Timer;
		private var shapes:Array = [];
		
		public function CircleLoader(num:uint = 12, type:String = "rectangle") {
			//描画
			for(var i:int = 0;i < num;i++) {
				var shape:LoadingGraphics = new LoadingGraphics(type, i, num);
				shape.rotation = -360 / num * i;
				addChild(shape);
				shapes.push(shape);
			}
			
			//Timerの設定
			timer = new Timer(60);
			timer.addEventListener(TimerEvent.TIMER, update);
			timer.start();
			
			this.addEventListener(Event.REMOVED, removed);
		}


		//描画の更新
		private function update(event:TimerEvent):void {
			for each(var shape:LoadingGraphics in shapes) shape.update();
		}
		
		public function set enabled(val:Boolean):void {
			for each(var shape:LoadingGraphics in shapes) shape.enabled = val;
			//falseの時はtimer止めた方が良いのか?
		}
		
		public function get enabled():Boolean {
			return LoadingGraphics(shapes[0]).enabled;
		}
		
		
		private function removed(e:Event):void {
			timer.reset();
		}
	}
}

import flash.display.Sprite;

class LoadingGraphics extends Sprite {
	public var enabled:Boolean = true;
	private var type:String = "rectangle";
	private var i:int = 0;
	private var num:uint = 12;
	
	public function LoadingGraphics(type:String,i:int,num:uint) {
		this.type = type;
		this.i = i;
		this.num = num;
		
		update();
	}

	//更新
	internal function update():void {
		this.graphics.clear();
		this.graphics.beginFill(enabled ? 0x333333 + 0x111111 * i : 0xaaaaaa);
		drawShape();
		this.graphics.endFill();
		if(++i >= num) i = 0;
	}

	//typeに応じて形を変更
	private function drawShape():void {
		switch(type) {
			case "rectangle":	
				this.graphics.drawRoundRect(-1.5, 8, 3, 8, 1, 1); 
				break;
			case "circle":		
				this.graphics.drawCircle(0, 12, 3);
			//macの虹のやつも作りたいな．
			//case "rainbow":
		}
	}
}