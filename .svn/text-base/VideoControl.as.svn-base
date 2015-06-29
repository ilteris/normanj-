package
{
	import caurina.transitions.Tweener;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.net.NetStream;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class VideoControl
	{
		
		private var _controlsArr:Array = new Array("PLAY", "PAUSE", "REW");
		private var _totalWidth:Number;
		
		private var _video:VideoPlayer;
		private var _mclip:MovieClip = new MovieClip;
		
		private var _current:*;
		private var _prev:*;
		private var _stream:NetStream;
		
		private var _buttonsArr:Array = new Array;
		private var _totalTime:Number;
		private var __color:Number;
		
		
		public function VideoControl(color:Number)
		{
			__color = color;
		}
		
		public function createControls(y:Number):void
		{
			createButtons(y);
		}//endfunction
		
		private function createButtons(y:Number):void
		{
			_totalWidth = -4;
			for (var i:Number = 0; i < _controlsArr.length; i++)
			{
			var titleFormat:TextFormat = new TextFormat("Gotham-Medium");
			titleFormat.color = __color;    // Make the text color
			titleFormat.size = 14;
			var txt:TextField = new TextField;
			txt.width = Configuration.projectTextWidth;
			txt.embedFonts = true;
			txt.antiAliasType = AntiAliasType.ADVANCED;
			txt.autoSize = TextFieldAutoSize.LEFT;
			txt.wordWrap = false;
			txt.border = false;
			txt.selectable = false;
			txt.text = _controlsArr[i];
			txt.setTextFormat(titleFormat);
			//trace(_mclip.y);
			txt.y = y;
			if(i==1)
			{
			txt.x = _totalWidth-1;	
			}
			else if(i==2)
			{
			txt.x = _totalWidth-1;	
			}
			else
			{
				txt.x = _totalWidth;	
			}
			
			_mclip.addChild(txt);
			
			var mc:MovieClip = new MovieClip();
			mc.graphics.lineStyle(0,0x34383c,1);
			mc.graphics.beginFill(0x34383c,1);
			mc.graphics.drawRect(0,0,txt.width,txt.height);
			mc.x = txt.x;
			mc.y = txt.y;
			mc.alpha = 0;
			_mclip.addChild(mc);
			
			mc.extra = 
			{
				text : txt,
				id : i,
				pressed:false
			}//end extra
			
			_buttonsArr.push(mc);
			_totalWidth += txt.width-3;
			mc.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			mc.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);	
			mc.addEventListener(MouseEvent.CLICK, onPress);	
			mc.buttonMode = true;
			
			}//endfor
			
			
			//set the play button
			_buttonsArr[0].extra.pressed = true;
			_buttonsArr[0].mouseEnabled = false;	
			_buttonsArr[0].buttonMode = false;
			_prev = 0;
			Tweener.addTween(_buttonsArr[0].extra.text, 
				{
				_color:0x4dcdd0,
                time:.3,
                transition:"easeOutQuad"
		     	}); //endtween
			
			
			
			
		}//endfunction
		
		
		public function createDownload(y:Number,source:String):void
		{
			var titleFormat:TextFormat = new TextFormat("Gotham-Medium");
			titleFormat.color = __color;    // Make the text color
			titleFormat.size = 14;
			var txt:TextField = new TextField;
			txt.width = Configuration.projectTextWidth;
			//titleFormat.letterSpacing = -.1;
			txt.embedFonts = true;
			txt.antiAliasType = AntiAliasType.ADVANCED;
			txt.autoSize = TextFieldAutoSize.LEFT;
			txt.wordWrap = false;
			txt.border = false;
			txt.selectable = false;
			txt.text = "DOWNLOAD";
			txt.setTextFormat(titleFormat);
			//trace(_mclip.y);
			txt.y = y;
			txt.x = _totalWidth-3;
			_mclip.addChild(txt);
			
			var mc:MovieClip = new MovieClip();
			mc.graphics.lineStyle(0,0x34383c,1);
			mc.graphics.beginFill(0x34383c,1);
			mc.graphics.drawRect(0,0,txt.width,txt.height);
			mc.x = txt.x;
			mc.y = txt.y;
			mc.alpha = 0;
			_mclip.addChild(mc);
			mc.extra = 
			{
				text : txt,
				url : source
			}//end extra
			mc.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			mc.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);	
			mc.addEventListener(MouseEvent.CLICK, onDownloadPress);	
			mc.buttonMode = true;
		}//endfunction
		
		private function onMouseOver(e:MouseEvent):void
		{
			
			Tweener.addTween(e.target.extra.text, 
				{
				_color:0x4dcdd0,
                time:.3,
                transition:"easeOutQuad"
		     	}); //endtween
			
		}//endfunction
		
		private function onMouseOut(e:MouseEvent):void
		{
			/* var titleFormat:TextFormat = new TextFormat("Gotham-Medium");
			titleFormat.color = 0x6b7e7e;    // Make the text color
			_txtDict["download"].setTextFormat(titleFormat); */
			if(!e.target.extra.pressed)
			{
				Tweener.addTween(e.target.extra.text, 
					{
					_color:__color,
	                time:.3,
	                transition:"easeOutQuad"
			     	}); //endtween
		 	}
		}//endfunction
		
		private function onPress(e:MouseEvent):void
		{
			_current = e.target.extra.id;
			if(_prev == null)
			{
				// prev is by default 0
				// the movie already starts playing
			}//endif
			else
			{
				if(_current != _prev && _prev != null) 
				{
					_buttonsArr[_prev].buttonMode = true;	
					_buttonsArr[_prev].mouseEnabled = true;	
					_buttonsArr[_prev].extra.pressed = false;
					Tweener.addTween(_buttonsArr[_prev].extra.text, 
					{
	                    _color:__color,
	                    time:.2,
	                    transition:"easeOutQuad"
					}); //endtween
				}//endif
			}	//endelse		
			
			
			if(_current == 0)
			{
				_video.stream.resume();
				//play the movie
				//by default this should be "on"
				
			}//endif
			else if(_current == 1)
			{
				_video.stream.pause();
				//pause the movie
			}//endelseif
			else if(_current == 2)
			{
				 _video.stream.pause();
    			 _video.stream.seek(0);
				//stop the movie
				
				// go back to the image.
				
			}//end elseif
			
			e.target.extra.pressed = true;
			_buttonsArr[_current].mouseEnabled = false;	
			_buttonsArr[_current].buttonMode = false;	
			
			_prev = _current;
			
		} //endfunction
		
		
		private function onDownloadPress(e:MouseEvent):void
		{
			if(_current != 2)
			{
				_prev = 1;
			
				for (var i:Number = 0; i < _buttonsArr.length; i++)
				{
					if(i == 1) //pause button
					{
						
						_buttonsArr[i].extra.pressed = true;
						_buttonsArr[i].mouseEnabled = false;	
						_buttonsArr[i].buttonMode = false;	
						
						Tweener.addTween(_buttonsArr[i].extra.text, 
						{
		                    _color:0x4dcdd0,
		                    time:.2,
		                    transition:"easeOutQuad"
						}); //endtween
						
						
					} //endif
					else
					{
						_buttonsArr[i].extra.pressed = false;
						_buttonsArr[i].mouseEnabled = true;	
						_buttonsArr[i].buttonMode = true;	
						
						Tweener.addTween(_buttonsArr[i].extra.text, 
						{
		                    _color:__color,
		                    time:.2,
		                    transition:"easeOutQuad"
						}); //endtween
						
					}//endelse
				}//endfor
			}//endif
			_video.stream.pause();
			
			
			
			navigateToURL(new URLRequest(e.target.extra.url), "_blank");		
		}//endfunction
		
		public function get mc():MovieClip
		{
			return _mclip;
		}//endfunction
		public function set video(video:VideoPlayer):void
		{
			_video = video;
		}
		
		public function set stream(ns:NetStream):void
		{
			_stream = ns;
		}//endfunction

	}
}