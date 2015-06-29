package
{
	import flash.display.MovieClip;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class Link
	{
		private var _mclip:MovieClip = new MovieClip;
		private var _name:String;
		private var _pressed:Boolean = false;
		private var _id:Number;
		public function Link()
		{
		}
		
		public function formatLink(s_:String):void
		{
			var titleFormat:TextFormat = new TextFormat("Gotham-Medium");
			titleFormat.color = 0x000000;    // Make the text color
			titleFormat.size = 60;
			titleFormat.letterSpacing = .5;
		
			var txt:TextField = new TextField;
			txt.embedFonts = true;
			txt.antiAliasType = AntiAliasType.ADVANCED;
			txt.autoSize = TextFieldAutoSize.LEFT;
			txt.border = false;
			txt.selectable = false;
			txt.text = s_.toUpperCase();
			txt.setTextFormat(titleFormat);
			_mclip.graphics.lineStyle(0,Configuration.rollOver,0);
			_mclip.graphics.beginFill(Configuration.rollOver,0);
			_mclip.graphics.drawRect(0,0,txt.width,txt.height);
			_mclip.addChild(txt);	
			_mclip.extra = {
				name:_name,
				pressed:_pressed,
				id:_id
				
				
			}
		}
		
		public function get x():Number
		{
			return _mclip.x;
		}//endfunction
		
		public function set x(x_:Number):void
		{
			_mclip.x = x_;
		}//endfunction
		
		public function get y():Number
		{
			return _mclip.y;
		}//endfunction
		
		public function set y(y_:Number):void
		{
			_mclip.y = y_;
		}//endfunction
		
		

		public function get mc():MovieClip
		{
			return _mclip;
		}//endfunction
		
		public function get width():Number
		{
			return _mclip.width;
		}//endfunction
		
		public function set id(id_:Number):void
		{
			_id = id_;
		}//endfunction
		
		public function get id():Number
		{
			return _id;
		}//endfunction
		
		
		public function set name(name_:String):void
		{
			_name = name_;
		}//endfunction
		
		public function get name():String
		{
			return _name;
		}//endfunction
		
		public function set pressed(pressed_:Boolean):void
		{
			_pressed = pressed_;
		} //endfunction
		
		public function get pressed():Boolean
		{
			return _pressed;
		}//endfunction
	}
}