package
{
	
	import caurina.transitions.Tweener;
	import caurina.transitions.properties.ColorShortcuts;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class MenuManager
	{
		private var _mStrings:Array = new Array("reel","recent","about","other" );
		private var _mclip:MovieClip = new MovieClip;
		private var _mElements:Array = new Array;
		private var _current:* = null;
		private var _prev:* = null;
		
		private var _bg:Background;
		private var _contact:Contact;
		
		private var _imgLoader:ImageLoader = new ImageLoader;
		
		private var _xmlLoader:XMLLoader = new XMLLoader;
		
		
		
		private var _nj:NormanJ;
		private var _counter:Number = 1;
		
		private var _sectArr:Array = new Array;
		private var _logo:Logo;
		public function MenuManager(bg_:Background, contact_:Contact,normanj:NormanJ)
		{
			_bg = bg_;
			_contact = contact_;
			ColorShortcuts.init();
			_nj = normanj;
		}
		
		public function createMenu():void 
		{
			
			for (var i:Number = 0; i < _mStrings.length; i++)
			{
				var link:Link = new Link;
				
				link.name = _mStrings[i];
				link.id = i;
				link.formatLink(_mStrings[i]);
				
				link.mc.buttonMode = true;
				link.mc.mouseChildren = false;
				
				if(_mElements.length > 0)
				{
					if(i == 2 )
					{
						link.x = _mElements[i-1].x + _mElements[i-1].width-9;
						link.y = Configuration.mmOffsetY+10;
					}//endif
					else if(i == 3)
					{
						link.x = _mElements[i-1].x + _mElements[i-1].width-6;
						link.y = Configuration.mmOffsetY+10;
					}
					else
					{
						link.x = _mElements[i-1].x + _mElements[i-1].width-3;
						link.y = Configuration.mmOffsetY+10;
					}
				} //endif
				else // zero
				{
					link.x = Configuration.mmOffsetX ;
					link.y = Configuration.mmOffsetY+10;
				}//end else
				link.mc.addEventListener(MouseEvent.ROLL_OUT,onRollOut);
				link.mc.addEventListener(MouseEvent.ROLL_OVER,onRollOver);
				link.mc.addEventListener(MouseEvent.CLICK,onPress);
				
				_mElements.push(link);
				
				link.mc.alpha = 0;
				
				
				_mclip.addChild(link.mc);
				
				
				
			}//endfor
			
			loadProjects();
			
		} //endfunction
		
		
		private function loadProjects():void
		{
            _xmlLoader.loadXML("assets/xml/projects_"+_counter+".xml");
			_xmlLoader.addEventListener(XMLLoader.LOAD_COMPLETE, loadImages, false, 0 , true);
			}//endfunction
		
		
		private function loadImages(e:Event):void
		{
			_imgLoader.loadImages(_xmlLoader.getProjectImages());
			
			_counter++;
			if(_counter < 5) 
			{
				_imgLoader.addEventListener(ImageLoader.LOAD_COMPLETE, shootProjects,false, 0, true);
			}//endfunction
		}//endfunction
		
		private function shootProjects(e:Event):void
		{
			_imgLoader = new ImageLoader;
			loadProjects();
		}//endfunction
		

		private function onPress(e:MouseEvent):void
		{
			_current = e.target.extra.id;
			//trace("prev: " + _prev);
			if (_prev == null)
			{
				// don't close anything since everythins is closed.
			} //end if
			else 
			{
				if(_prev == 1) // recent
			{
				for(var i:Number = 0; i < _sectArr[0].videoArray.length; i++)
				{
				if(_sectArr[0].videoArray[i].videoContent)
					{
						 Tweener.addTween(_sectArr[0].videoArray[i].controlArr[0].mc, 
						{
							
							y:0,
		                    alpha:0,
		                    time:.2,
		                    transition:"easeOutQuad",
		                    onComplete:function():void{
		                    	//trace(_sectArr[0].videoArray[i].stream);
		                    }//endOnComplete
						}); //endtween 
						_sectArr[0].videoArray[i].streamClose();
						_sectArr[0].videoArray[i].videoContent = false;
						_sectArr[0].videoArray.pop();
					}//endif
				} //endfor
			} //endif
			else if(_prev == 3) // other
			{
				if(_sectArr[0].prev == 1 || _sectArr[0].prev == 2)
				{
					for(var i:Number = 0; i < _sectArr[0].sectArr[0].videoArray.length; i++)
					{
						if(_sectArr[0].sectArr[0].videoArray[i].videoContent)
						{
						_sectArr[0].sectArr[0].videoArray[i].streamClose();
						//_sectArr[0].mc.removeChild(_sectArr[0].videoArray[i].mc);
						_sectArr[0].sectArr[0].videoArray[i].videoContent = false;
						_sectArr[0].sectArr[0].videoArray.pop();
						
						}//endif
					} //endfor
				}//endif
			} //endelseif
				if(_prev == 0)
				{
					if(_sectArr[0].videoContent)
					{
						_sectArr[0].closeStream();
					}//endif

					turnOffReelBg();
					// clear  the contact button.
					
					_contact.removeChild(_contact.txtDict["title"]);
				} //end if
				
				_mclip.removeChild(_sectArr[0].mc);
				_sectArr.pop();
				 Tweener.addTween(_mElements[_prev].mc, 
						{
							
		                    _color:0x859d9d,
		                    alpha:1,
		                    time:.2,
		                    transition:"easeOutQuad"
				}); //endtween 
			
			
			} //end else
			
			e.target.extra.pressed = true;
			_mElements[_current].mc.mouseEnabled = false;	
			_mElements[_current].mc.buttonMode = false;	
			
			
			if(e.target.extra.name == "reel" )
			{
				var reel:Reel = new Reel;
				//reel.loadImage();
				_sectArr.push(reel);
				//reel.addEventListener(Reel.LOAD_COMPLETE, placeReel,false, 0, true);
				placeReel();
				// make the logo go orange.
				/* Tweener.addTween(_logo.mc, 
						{
							_color:0xff5625,
		                    time:.3,
		                    delay:.2,
		                    transition:"easeOutQuad"
				}); //endtween */
				
			
			}//endif
			else if(e.target.extra.name == "recent")
			{
				var recent:Recent = new Recent;
				recent.loadProjects();
				_sectArr.push(recent);
				recent.addEventListener(Recent.LOAD_COMPLETE, turnOnRecent,false, 0, true);
				//make the logo go blue
			/* 	Tweener.addTween(_logo.mc, 
						{
							_color:0x4cccce,
		                    time:.3,
		                    delay:.2,
		                    transition:"easeOutQuad"
				}); //endtween */
			
			
				trace("recent");	
			}//end elseif
			
			else if(e.target.extra.name == "about")
			{
				var about:About = new About;
				about.loadPeople();
				_sectArr.push(about);
				about.addEventListener(About.LOAD_COMPLETE, placeAbout,false, 0, true);

			
			
				trace("about");	
			}//end elseif
			
			else if(e.target.extra.name == "other")
			{
				var other:Other = new Other;
				other.loadAssets(_nj);
				_sectArr.push(other);
				other.mc.alpha = 0;
				_mclip.addChild(other.mc);
				
				/* Tweener.addTween(_logo.mc, 
						{
							_color:0x4cccce,
		                    time:.3,
		                    delay:.2,
		                    transition:"easeOutQuad"
				}); //endtween
				 */
				
				Tweener.addTween(other.mc, 
							{
			                    alpha:1,
			                    time:.2,
			                    transition:"easeOutQuad"
				}); //endtween
				trace("other");	
			}//end elseif
			
			if(_current != _prev && _prev != null) 
			{
				_mElements[_prev].mc.buttonMode = true;	
				_mElements[_prev].mc.mouseEnabled = true;	
				_mElements[_prev].mc.extra.pressed = false;
				Tweener.addTween(_mElements[_prev].mc, 
						{
		                    _color:Configuration.rollOut,
		                    time:.2,
		                    transition:"easeOutQuad"
				}); //endtween
				
			}//endif
			
			_prev = _current;
		} //endfunction
		
		private function turnOffReelBg():void
		{ // reel off
			Tweener.addTween(_bg.mc, 
						{
		                    _color:0x1c2127,
		                    time:.2,
		                     delay:.2,
		                    transition:"easeOutQuad"
			}); //endtween
			
			Tweener.addTween(_contact.mc, 
						{
		                    alpha:1,
		                    time:.2,
		                    transition:"easeOutQuad"
			}); //endtween
			
		}//endfunction
		
		private function turnOnReelBg():void
		{
						// change background elements to normal
			Tweener.addTween(_bg.mc, 
						{
		                    _color:0x060708,
		                    time:.2,
		                     delay:.2,
		                    transition:"easeOutQuad"
			}); //endtween
			
			Tweener.addTween(_contact.mc, 
						{
		                    alpha:.2,
		                    time:.2,
		                    transition:"easeOutQuad"
			}); //endtween
		}//endfunction
		
		private function turnOnRecent(e:Event):void
		{
			
			_sectArr[0].mc.x = 0;
			_sectArr[0].mc.y = 0;
			_sectArr[0].mc.alpha = 0;
			_mclip.addChild(_sectArr[0].mc);
			
			_sectArr[0].createSB(_nj);
			Tweener.addTween(_sectArr[0].mc, 
						{
							alpha:1,
		                    time:.2,
		                     delay:.2,
		                    transition:"easeOutQuad"
			}); //endtween
			
			 Tweener.addTween(_mElements[_current].mc, 
						{
							
		                    //_color:0x859d9d,
		                    alpha:1,
		                    time:.2,
		                    transition:"easeOutQuad"
			}); //endtween 
			
			// remove the img.
		} // endfunction
		private function onRollOver(e:MouseEvent):void
		{
			Tweener.addTween(e.target, 
					{
	                    _color:Configuration.rollOver,
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
		                    _color:Configuration.rollOut,
		                    time:.2,
		                    transition:"easeOutQuad"
					     }); //endtween
			}//endif
		} //endfunction
		
		public function turnOnLinks():void
		{
			for (var i:Number = 0; i < _mElements.length; i++)
			{
				Tweener.addTween(_mElements[i].mc, 
						{
							
		                    alpha:1,
		                    time:.5,
		                    delay:.8,
		                    y : Configuration.mmOffsetY,
		                    transition:"easeOutQuad"
			}); //endtween
			}//endfor
				_logo = new Logo;
				_logo.loadImage();
				_logo.addEventListener(Reel.LOAD_COMPLETE, placeLogo,false, 0, true);
				_mclip.addChild(_logo.mc);
				
		}//endfunction
		private function placeLogo(e:Event):void
		{
			e.target.mc.x = Configuration.mmOffsetX;
			e.target.mc.y = Configuration.mmOffsetY-60;
			e.target.mc.alpha = 0;
			
				
			Tweener.addTween(e.target.mc, 
						{
							_color:0x4cccce,
		                    alpha:1,
		                    y:Configuration.mmOffsetY-65,
		                    time:.3,
		                    delay:.2,
		                    transition:"easeOutQuad"
			}); //endtween
		}//endfunction
		
		
		private function placeReel():void
		{
			if(_sectArr.length != 0)
			{
				_contact.createTitle();
			}//endif
			
			turnOnReelBg();
			
			_sectArr[0].mc.alpha = 0;
			_mclip.addChild(_sectArr[0].mc);
			
			Tweener.addTween(_mElements[_current].mc, 
						{
							
		                    _color:0x859d9d,
		                    alpha:.2,
		                    time:.2,
		                    transition:"easeOutQuad"
			}); //endtween
			
			
			Tweener.addTween(_sectArr[0].mc, 
						{
		                    alpha:1,
		                    time:1,
		                    transition:"easeOutQuad",
		                    onComplete:function():void{_sectArr[0].loadVideo();}
			}); //endtween
		}//endfunction
		
		private function placeAbout(e:Event):void
		{
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
		
		
		// GETTERS SETTERS
		
		public function get mc():MovieClip
		{
			return _mclip;
		}//endfunction
		
		public function get mElements():Array
		{
			return _mStrings;
		}//endfunction

	}
}