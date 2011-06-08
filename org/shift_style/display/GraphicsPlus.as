package org.shift_style.display {
	import flash.display.IGraphicsData;
	import flash.display.Shader;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.geom.Point;

	/**
	 * @author yamaji
	 */
	public class GraphicsPlus extends Shape {
		public function GraphicsPlus() {}

		public function drawFan(x:Number, y:Number, r1:Number, r2:Number, a1:Number, a2:Number):void {
			//角度をラジアンに直す
			var radian1:Number = a1 * Math.PI / 180;
			var radian2:Number = a2 * Math.PI / 180;
			
			// 外円の描画
			draw(x, y, r1, radian1, radian2, false);
			// 内円の描画
			draw(x, y, r2, radian2, radian1, true);
		}

		private function draw(x:Number, y:Number, r:Number, t1:Number, t2:Number, lineTo:Boolean):void {
			var div:Number = Math.max(1, Math.floor(Math.abs(t1 - t2) / 0.4));
			var lx:Number;
			var ly:Number;
			var lt:Number;
			
			for (var i:int = 0;i <= div;i++) {
				var ct:Number = t1 + (t2 - t1) * i / div;
				var cx:Number = Math.cos(ct) * r + x;
				var cy:Number = Math.sin(ct) * r + y;
            
				if(i == 0) {
					if(lineTo) this.graphics.lineTo(cx, cy);
                else this.graphics.moveTo(cx, cy);
				} else {
					var cp:Point = getControlPoint(new Point(lx, ly), lt + Math.PI / 2, new Point(cx, cy), ct + Math.PI / 2); 
					this.graphics.curveTo(cp.x, cp.y, cx, cy);
				}
				lx = cx;
				ly = cy;
				lt = ct;
			}
		}

		
		private function getControlPoint(p1:Point, t1:Number, p2:Point, t2:Number):Point {
			var dif:Point = p2.subtract(p1);
			var l12:Number = Math.sqrt(dif.x * dif.x + dif.y * dif.y);
			var t12:Number = Math.atan2(dif.y, dif.x);
			var l13:Number = l12 * Math.sin(t2 - t12) / Math.sin(t2 - t1);
        
			return new Point(p1.x + l13 * Math.cos(t1), p1.y + l13 * Math.sin(t1));
		}

		
		public function beginFill(color:uint, alpha:Number = 1):void {
			this.graphics.beginFill(color, alpha);
		}

		public function beginGradientFill(type:String, colors:Array, alphas:Array, ratios:Array, matrix:Matrix = null, spreadMethod:String = "pad", interpolationMethod:String = "rgb", focalPointRatio:Number = 0):void {
			this.graphics.beginGradientFill(type, colors, alphas, ratios, matrix, spreadMethod, interpolationMethod, focalPointRatio);
		}

		public function beginShaderFill(shader:Shader, matrix:Matrix = null):void {
			this.graphics.beginShaderFill(shader, matrix);
		}

		public function clear():void {
			this.graphics.clear();
		}

		public function curveTo(controlX:Number, controlY:Number, anchorX:Number, anchorY:Number):void {
			this.graphics.curveTo(controlX, controlY, anchorX, anchorY);
		}

		public function drawCircle(x:Number, y:Number, radius:Number):void {
			this.graphics.drawCircle(x, y, radius);
		}

		public function drawEllipse(x:Number, y:Number, width:Number, height:Number):void {
			this.graphics.drawEllipse(x, y, width, height);
		}

		public function drawGraphicsData(graphicsData:Vector.<IGraphicsData>):void {
			this.graphics.drawGraphicsData(graphicsData);
		}

		public function drawPath(commands:Vector.<int>, data:Vector.<Number>, winding:String = "evenOdd"):void {
			this.graphics.drawPath(commands, data, winding);
		}

		public function drawRect(x:Number, y:Number, width:Number, height:Number):void {
			this.graphics.drawRect(x, y, width, height);
		}

		public function drawRoundRect(x:Number, y:Number, width:Number, height:Number, ellipseWidth:Number, ellipseHeight:Number = NaN):void {
			this.graphics.drawRoundRect(x, y, width, height, ellipseWidth, ellipseHeight);
		}

		public function drawRoundRectComplex(x:Number, y:Number, width:Number, height:Number, topLeftRadius:Number, topRightRadius:Number, bottomLeftRadius:Number, bottomRightRadius:Number):void {
			this.graphics.drawRoundRectComplex(x, y, width, height, topLeftRadius, topRightRadius, bottomLeftRadius, bottomRightRadius);
		}

		public function drawTriangles(vertices:Vector.<Number>, indices:Vector.<int> = null, uvtData:Vector.<Number> = null, culling:String = "none"):void {
			this.graphics.drawTriangles(vertices, indices, uvtData, culling);
		}

		public function endFill():void {
			this.graphics.endFill();
		}

		public function lineGradientStyle(type:String, colors:Array, alphas:Array, ratios:Array, matrix:Matrix = null, spreadMethod:String = "pad", interpolationMethod:String = "rgb", focalPointRatio:Number = 0):void {
			this.graphics.lineGradientStyle(type, colors, alphas, ratios, matrix, spreadMethod, interpolationMethod, focalPointRatio);
		}

		public function lineShaderStyle(shader:Shader, matrix:Matrix = null):void {
			this.graphics.lineShaderStyle(shader, matrix);
		}

		public function lineStyle(thickness:Number = NaN, color:uint = 0, alpha:Number = 1.0, pixelHinting:Boolean = false, scaleMode:String = "normal", caps:String = null, joints:String = null, miterLimit:Number = 3):void {
			this.graphics.lineStyle(thickness, color, alpha, pixelHinting, scaleMode, caps, joints, miterLimit);
		}

		public function lineTo(x:Number, y:Number):void {
			this.graphics.lineTo(x, y);
		}

		public function moveTo(x:Number, y:Number):void {
			this.graphics.moveTo(x, y);
		}
	}
}
