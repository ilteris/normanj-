package
{
	import caurina.transitions.Tweener;
	import caurina.transitions.properties.ColorShortcuts;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class Other extends EventDispatcher
	{
		
		
		
		
		
		private var _mStrings:Array = new Array("logos","documentary","archive");
		
		private var _mclip:MovieClip = new MovieClip;
		private var _mElements:Array = new Array;
		private var _current:* = 0;
		private var _prev:* = 0;
		
		private var _sectArr:Array = new Array;
		
		public static var LOAD_COMPLETE:String = "loadComplete";
		
		private var _otherBucket:Array = new Array;
		private var numOfLinks:Number = 3;
		
		private var _nj:NormanJ;
		public function Other() 
		{
			ColorShortcuts.init();
		}


		public function loadAssets(nj:NormanJ):void
		{
			_nj = nj;
			dispatchEvent(new Event(LOAD_COMPLETE, true));
			
			//createBg();
			createSubLinks();	
			
		}//endfunction
		
		private function createBg():void
		{
			var mc:MovieClip = new MovieClip();
			mc.graphics.lineStyle(0,0x34383c,0);
			mc.graphics.beginFill(0x34383c,0);
			mc.graphics.drawRect(0,0,1000,308);
			_mclip.addChild(mc);	
			_otherBucket.push(mc);
			mc.x = -78;
			mc.y = 128;
		}//endfunction
		
		private function createSubLinks():void
		{
			var totalWidth:Number = 0;
			for (var i:Number = 0; i < numOfLinks; i++)
			{
				
				
				
				var otherLink:OtherLink = new OtherLink;
				otherLink.name = _mStrings[i];
				otherLink.id = i;
				
				otherLink.createLink(_mStrings[i]);
				otherLink.mc.x = Configuration.mmOffsetX  + totalWidth + 5;
				otherLink.mc.y = Configuration.mmOffsetY + 95;
				otherLink.mc.buttonMode = true;
				otherLink.mc.mouseChildren = false;
				_mElements.push(otherLink);
				
				if(i==0)
				{
					Tweener.addTween(otherLink.mc, 
					{
	                    _color:0x4cccce,
	                    time:.2,
	                    transition:"easeOutQuad"
				     }); //endtween
				     
				    otherLink.mc.extra.pressed = true;
					otherLink.mc.mouseEnabled = false;	
					otherLink.mc.buttonMode = false;	
			
					var logos:Logos = new Logos;
					
					logos.loadImage(_nj);
					_sectArr.push(logos);
					logos.addEventListener(Reel.LOAD_COMPLETE, placeLogos,false, 0, true);
				     
				} //end if
				
				
				otherLink.mc.addEventListener(MouseEvent.ROLL_OUT,onRollOut);
				otherLink.mc.addEventListener(MouseEvent.ROLL_OVER,onRollOver);
				otherLink.mc.addEventListener(MouseEvent.CLICK,onPress);
				
				
				
				if(i < 2)
				{
					var t:TextField = createSlash();
					t.x = otherLink.mc.x + otherLink.mc.width;
					t.y = otherLink.mc.y;
					_mclip.addChild(t);
					 totalWidth += otherLink.mc.width + t.width;
				}//endif
				else 
				{
					totalWidth += otherLink.mc.width;	
				}//endelse
				_mclip.addChild(otherLink.mc);
				
				
			}//endfor
		}//endfunction
		
		
		
		private function createSlash():TextField
		{
			var titleFormat:TextFormat = new TextFormat("Clarendon Lt BT");
			titleFormat.color = 0xeeffe1;    // Make the text color
			titleFormat.size = 18;
			var txt:TextField = new TextField;
			txt.embedFonts = true;
			txt.antiAliasType = AntiAliasType.ADVANCED;
			txt.autoSize = TextFieldAutoSize.LEFT;
			txt.border = false;
			txt.selectable = true;
			txt.text = "/";
			txt.setTextFormat(titleFormat);
			return txt;
		}//endfunction
		
		private function onPress(e:MouseEvent):void
		{
			_current = e.target.extra.id;
			if (_prev == null)
			{
				// don't close anything since everythins is closed.
			} //end if
			else if(_prev == 1 || _prev == 2)
			{
				for(var i:Number = 0; i < _sectArr[0].videoArray.length; i++)
				{
					if(_sectArr[0].videoArray[i].videoContent)
					{
							_sectArr[0].videoArray[i].streamClose();
							//_sectArr[0].mc.removeChild(_sectArr[0].videoArray[i].mc);
							_sectArr[0].videoArray.pop();
							_sectArr[0].videoArray[i].videoContent = false;
							
							 Tweener.addTween(_sectArr[0].videoArray[i].controlArr[0].mc, 
							{
								
								y:0,
			                    alpha:0,
			                    time:.2,
			                    transition:"easeOutQuad"
							}); //endtween 
					
					
					}//endif
					
				} //endfor
			
				_mclip.removeChild(_sectArr[0].mc);
				
				_sectArr = [];
			}//endelseif
			else
			{
				_mclip.removeChild(_sectArr[0].mc);
				_sectArr = [];
				
				 Tweener.addTween(_mElements[_prev].mc, 
						{
							
		                    _color:0xeeffe1,
		                    alpha:1,
		                    time:.2,
		                    transition:"easeOutQuad"
				}); //endtween 
			}//endelse
			
			e.target.extra.pressed = true;
			_mElements[_current].mc.mouseEnabled = false;	
			_mElements[_current].mc.buttonMode = false;	
			
			
			if(e.target.extra.name == "logos" )
			{
				var logos:Logos = new Logos;
				logos.loadImage(_nj);
				_sectArr.push(logos);
				logos.addEventListener(Reel.LOAD_COMPLETE, placeLogos,false, 0, true);
			}//endif
			else if(e.target.extra.name == "documentary")
			{
				var outdoor:Outdoor = new Outdoor;
				outdoor.loadProjects();
				_sectArr.push(outdoor);
				outdoor.addEventListener(Outdoor.LOAD_COMPLETE, placeOutdoor,false, 0, true);
				trace("documentary");
			}//end elseif
			else if(e.target.extra.name == "archive")
			{
				var miscellany:Miscellany = new Miscellany;
				miscellany.loadProjects();
				_sectArr.push(miscellany);
				miscellany.addEventListener(Miscellany.LOAD_COMPLETE, placeMisc, false, 0, true);
				trace("archive");	
			}//endelseif
			
			if(_current != _prev && _prev != null) 
			{
				_mElements[_prev].mc.buttonMode = true;	
				_mElements[_prev].mc.mouseEnabled = true;	
				_mElements[_prev].mc.extra.pressed = false;
				Tweener.addTween(_mElements[_prev].mc, 
						{
		                    _color:0x859d9d,
		                    time:.2,
		                    transition:"easeOutQuad"
				}); //endtween
				
			}//endif
			
			_prev = _current;
		}//endfunction
		
		
		private function placeLogos(e:Event):void
		{
			e.target.mc.x = 0;
			e.target.mc.y = 0;
			e.target.mc.alpha = 0;
			
			e.target.createSB(_nj);
			
			_mclip.addChild(e.target.mc);
			
			
			Tweener.addTween(e.target.mc, 
						{
		                    alpha:1,
		                    time:.2,
		                    transition:"easeOutQuad"
			}); //endtween
		}//endfunction
		
		private function placeOutdoor(e:Event):void
		{
			e.target.mc.x = 0;
			e.target.mc.y = 0;
			e.target.mc.alpha = 0;
			
			_mclip.addChild(e.target.mc);
			e.target.createSB(_nj);
			
			Tweener.addTween(e.target.mc, 
						{
		                    alpha:1,
		                    time:.2,
		                    transition:"easeOutQuad"
			}); //endtween
		}//endfunction
		
		private function placeMisc(e:Event):void
		{
			e.target.mc.x = 0;
			e.target.mc.y = 0;
			e.target.mc.alpha = 0;
			
			_mclip.addChild(e.target.mc);
			e.target.createSB(_nj);
			
			
			
			Tweener.addTween(e.target.mc, 
						{
		                    alpha:1,
		                    time:.2,
		                    transition:"easeOutQuad"
			}); //endtween
		}//endfunction
		
		
		private function onRollOver(e:MouseEvent):void
		{
			Tweener.addTween(e.target, 
					{
	                    _color:0x4cccce,
	                    time:.2,
	                    transition:"easeOutQuad"
				     }); //endtween
		}//end function
		
		private function onRollOut(e:MouseEvent):void
		{
			if(!e.target.extra.pressed) 
			{
				Tweener.addTween(e.target, 
						{
		                    _color:0x859d9d,
		                    time:.2,
		                    transition:"easeOutQuad"
					     }); //endtween
			}//endif
		} //endfunction
		
		
		
		public function get sectArr():Array
		{
			return _sectArr;
		}//endfunction
		public function get mc():MovieClip
		{
			return _mclip;
		}//endfunction
		
		public function get prev():*
		{
			return _prev;
		}//endfunction
		
		

	}
}