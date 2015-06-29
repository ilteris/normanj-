package
{
	
	import caurina.transitions.Tweener;
	import caurina.transitions.properties.ColorShortcuts;
	
	import flash.display.MovieClip;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	
	public class Contact
	{
		
		private var _mclip:MovieClip = new MovieClip;
		private var _txtDict:Dictionary = new Dictionary(true);
		
		
		public function Contact()
		{
			ColorShortcuts.init();
		}
		
		public function createContact():void
		{
			_mclip.alpha = 0 ;
			//createTitle();
			createAddress();
			createTel();
			createEmail();
			
			Tweener.addTween(_mclip, 
						{
							
		                    alpha:1,
		                    time:.2,
		                    delay: .5,
		                    transition:"easeOutQuad"
			}); //endtween
			
			
			
		}
		
		public function createTitle():void
		{
			var titleFormat:TextFormat = new TextFormat("Gotham-Medium");
			titleFormat.color = 0x7e9596;    // Make the text color
			titleFormat.size = 15;
			var txt:TextField = new TextField;
			txt.embedFonts = true;
			txt.antiAliasType = AntiAliasType.ADVANCED;
			txt.autoSize = TextFieldAutoSize.LEFT;
			txt.border = false;
			txt.selectable = false;
			txt.text = "CONTACT";
			txt.setTextFormat(titleFormat);
			txt.y = -14;
			_mclip.addChild(txt);
			
			_txtDict["title"] = txt;
			
		}
		
		private function createAddress():void
		{
			var titleFormat:TextFormat = new TextFormat("Gotham-Medium");
			titleFormat.color = 0x7e9596;    // Make the text color
			titleFormat.size = 10;
			titleFormat.letterSpacing = 0.5;
			var txt:TextField = new TextField;
			txt.embedFonts = true;
			txt.antiAliasType = AntiAliasType.ADVANCED;
			txt.autoSize = TextFieldAutoSize.LEFT;
			txt.border = false;
			txt.selectable = true;
			titleFormat.leading = 3;
			txt.htmlText = "394 Broadway \n4th Floor \nNew York, NY 10013";
			txt.setTextFormat(titleFormat);
			txt.y = _mclip.y + _mclip.height;
			_mclip.addChild(txt);
			_txtDict["address"] = txt;
		}
		
		private function createTel():void
		{
			var titleFormat:TextFormat = new TextFormat("Gotham-Medium");
			titleFormat.color = 0x7e9596;    // Make the text color
			titleFormat.size = 10;
			titleFormat.letterSpacing = 0.8;
			var txt:TextField = new TextField;
			txt.embedFonts = true;
			txt.antiAliasType = AntiAliasType.ADVANCED;
			txt.autoSize = TextFieldAutoSize.LEFT;
			txt.border = false;
			txt.selectable = true;
			
			titleFormat.leading = 3;
			txt.htmlText = "P 212 937 7861 \nF 212 937 7862";
			txt.setTextFormat(titleFormat);
			txt.x = _mclip.x + _mclip.width + 20;
			txt.y = _txtDict["address"].y;
			_txtDict["tel"] = txt;
			_mclip.addChild(txt);
		}
		
		private function createEmail():void
		{
			var titleFormat:TextFormat = new TextFormat("Gotham-Medium");
			titleFormat.color = 0x7e9596;    // Make the text color
			titleFormat.size = 10;
			titleFormat.letterSpacing = 0.8;
			var txt:TextField = new TextField;
			txt.embedFonts = true;
			txt.antiAliasType = AntiAliasType.ADVANCED;
			txt.autoSize = TextFieldAutoSize.LEFT;
			txt.border = false;
			txt.selectable = true;
			txt.htmlText = "<a href='mailto:info@normanj.com'>info@normanj.com</a>";
			txt.setTextFormat(titleFormat);
			txt.x = _txtDict["tel"].x;
			txt.y = _txtDict["tel"].y+_txtDict["tel"].height-1;
			_txtDict["email"] = txt;
			_mclip.addChild(txt);
		}
		
		public function removeChild(t_:TextField):void
		{
			_mclip.removeChild(t_);
		}//endfunction
		
		public function get mc():MovieClip
		{
			return _mclip;
		}
		
		public function set x(x_:Number):void
		{
			_mclip.x = x_;	
		}
		
		public function get x():Number
		{
			return _mclip.x;
		}
		
		public function set y(y_:Number):void
		{
			_mclip.y = y_;	
		}
		
		public function get y():Number
		{
			return y;
		}
		
		public function get txtDict():Dictionary
		{
			return _txtDict;
		}//endfunction

	}
}