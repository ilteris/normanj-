
package
{
	import flash.display.MovieClip;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class OtherLink
	{
		private var _mclip:MovieClip = new MovieClip;
		private var _name:String;
		private var _pressed:Boolean = false;
		private var _id:Number;
		
		public function OtherLink()
		{
		}

		public function createLink(s_:String):void
		{
				var titleFormat:TextFormat = new TextFormat("Clarendon BT");
				titleFormat.color = 0x859d9d;    // Make the text color
				titleFormat.size = 18;
				var txt:TextField = new TextField;
				txt.embedFonts = true;
				txt.antiAliasType = AntiAliasType.ADVANCED;
				txt.autoSize = TextFieldAutoSize.LEFT;
				txt.border = false;
				txt.selectable = true;
				txt.text = s_.toUpperCase();
				txt.setTextFormat(titleFormat);
				_mclip.addChild(txt);
				_mclip.extra = {
					name:_name,
					pressed:_pressed,
					id:_id
			}
		}//endfunction
		
		public function get mc():MovieClip
		{
			return _mclip;
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