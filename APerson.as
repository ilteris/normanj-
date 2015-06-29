package
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	
	public class APerson
	{
		
		private var _mclip:MovieClip = new MovieClip;
		private var _tclip:MovieClip = new MovieClip;
		private var _txtDict:Dictionary = new Dictionary(true);
		
		public function APerson()
		{
		}
		
		
		public function loadImage(bmp_:Bitmap):void
		{
			_mclip.addChild(bmp_);
			_txtDict["bmp"] = bmp_;
		} //endfunction
		
		public function createName(source:String):void 
		{
			var titleFormat:TextFormat = new TextFormat("Gotham-Medium");
			titleFormat.color = 0x4cccce;    // Make the text color
			titleFormat.size = 14;
			var txt:TextField = new TextField;
			txt.embedFonts = true;
			txt.antiAliasType = AntiAliasType.ADVANCED;
			txt.autoSize = TextFieldAutoSize.RIGHT;
			txt.border = false;
			txt.selectable = false;
			txt.htmlText = source;
			txt.setTextFormat(titleFormat);
			txt.x = _txtDict["bmp"].x + _txtDict["bmp"].width-txt.width;
			txt.y = -35;
			_mclip.addChild(txt);
			
			_txtDict["name"] = txt;
			
		}//endfunction

		public function createTitle(source:String):void 
		{
			var titleFormat:TextFormat = new TextFormat("Gotham-Medium");
			titleFormat.color = 0x6b7e7f;    // Make the text color
			titleFormat.size = 11;
			var txt:TextField = new TextField;
			txt.embedFonts = true;
			txt.antiAliasType = AntiAliasType.ADVANCED;
			txt.autoSize = TextFieldAutoSize.RIGHT;
			txt.border = false;
			txt.selectable = false;
			txt.htmlText = source;
			txt.setTextFormat(titleFormat);
			txt.x = _txtDict["name"].x+_txtDict["name"].width-txt.width;
			txt.y = -19;
			_mclip.addChild(txt);
			_txtDict["title"] = txt;
		}//endfunction
		
		public function createText(source:String):void 
		{
			var titleFormat:TextFormat = new TextFormat("Gotham-Book");
			titleFormat.color = 0x859d9d;    // Make the text color
			titleFormat.size = 12;
			var txt:TextField = new TextField;
			txt.embedFonts = true;
			txt.antiAliasType = AntiAliasType.ADVANCED;
			txt.width = 720;
			titleFormat.leading = 8;
			txt.wordWrap = true;
			txt.autoSize = TextFieldAutoSize.RIGHT;
			txt.border = false;
			txt.selectable = false;
			txt.htmlText = source;
			txt.setTextFormat(titleFormat);
			txt.x = 168;
			txt.y =  -35;
			_mclip.addChild(txt);
			_txtDict["text"] = txt;
		}//endfunction
		
		
		public function createEmailText(source:String):void 
		{
			var titleFormat:TextFormat = new TextFormat("Gotham-Medium");
			titleFormat.color = 0x6b7e7f;    // Make the text color
			titleFormat.size = 14;
			var txt:TextField = new TextField;
			txt.embedFonts = true;
			txt.antiAliasType = AntiAliasType.ADVANCED;
			txt.autoSize = TextFieldAutoSize.LEFT;
			txt.border = false;
			txt.selectable = true;
			txt.text = source;
			txt.setTextFormat(titleFormat);
			txt.x = 597;
			txt.y = 183;
			
			var mc:MovieClip = new MovieClip();
			mc.graphics.lineStyle(0,0x34383c,1);
			mc.graphics.beginFill(0x34383c,1);
			mc.graphics.drawRect(0,0,txt.width,txt.height);
			mc.x = txt.x;
			mc.y = txt.y;
			mc.alpha = 0;
			mc.extra = 
			{
				_source : source
			}//end extra
			
			
			_mclip.addChild(txt);
			_mclip.addChild(mc);
			
			_txtDict["email"] = txt
			mc.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			mc.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);	
			mc.addEventListener(MouseEvent.CLICK, onPress);	
			mc.buttonMode = true;
		}//endfunction
		
			private function onMouseOver(e:MouseEvent):void
		{
			
			var titleFormat:TextFormat = new TextFormat("Gotham-Medium");
			titleFormat.color = 0xffffff;    // Make the text color
			_txtDict["email"].setTextFormat(titleFormat);
			
		}//endfunction
		
		private function onMouseOut(e:MouseEvent):void
		{
			var titleFormat:TextFormat = new TextFormat("Gotham-Medium");
			titleFormat.color = 0x6b7e7e;    // Make the text color
			_txtDict["email"].setTextFormat(titleFormat);
			
		}//endfunction
		
		private function onPress(e:MouseEvent):void
		{
			navigateToURL(new URLRequest("mailto:"+e.target.extra._source), "_self");		
		}//endfunction
		
		
		public function get mc():MovieClip
		{
			return _mclip;
		}//endfunction

	}
}