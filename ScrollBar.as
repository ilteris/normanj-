package
{
	
	import caurina.transitions.Tweener;
	import caurina.transitions.properties.ColorShortcuts;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	
	public class ScrollBar
	{
		private var _xOffset:Number;
		private var _xMin:Number;
		private var _xMax:Number;
		
		private var _masker:MovieClip;
		
		private var _thumb:MovieClip;
		private var _track:MovieClip;
		
		private var _imageContainer:MovieClip;
		
		private var _nj:NormanJ;
		
		private var _source:String;
		
		private var _glWidth:Number;
		
		public function ScrollBar()
		{
			ColorShortcuts.init();
		}
		
		public function createSB(nj:NormanJ,RPImg:MovieClip,source:String):void
		{
		 	_nj = nj;
			_imageContainer = RPImg;
			_glWidth = _imageContainer.width;
			
			_source = source;
			_masker = new MovieClip();
			_masker.graphics.beginFill(0x34383c,1);
			_masker.graphics.drawRect(0,0,1000,608);	
			_imageContainer.mask = _masker;
						
			_track = new MovieClip;
			_track.graphics.beginFill(0x12151a,1);
			_track.graphics.drawRect(0,0,1000,8);	
			
			_thumb = new MovieClip;
			_thumb.graphics.beginFill(0x4cccce,1);
			_thumb.graphics.drawRect(0,0,100,8);	
			
			thumb.buttonMode = true;
			_xMax = _track.width - _thumb.width;
			_xMin = 0;
			
			_thumb.addEventListener(MouseEvent.MOUSE_DOWN,thumbDown);
			_nj.stage.addEventListener(MouseEvent.MOUSE_UP,thumbUp);
			 
			/* _thumb.addEventListener(MouseEvent.ROLL_OUT,onRollOut);
			_thumb.addEventListener(MouseEvent.ROLL_OVER,onRollOver);
			 */	
		}//endfunction
		
		
		private function thumbDown(e:MouseEvent):void
		{
		if(_source == "recent") //getting miscellany and outdoor too. 
		{
			for(var i:Number = 0; i < _imageContainer.extra.projectArr.length; i++)
			{
				
					_imageContainer.extra.projectArr[i].mc.mouseEnabled = true;
					_imageContainer.extra.projectArr[i].mc.buttonMode = true;
					Tweener.addTween(_imageContainer.extra.projectArr[i].mc, 
					{
			                    //x:_RProjectsArr[i].mc.x + _RProjectsArr[i].mc.width + 50, 
			                    time:2,
			                    delay:.2,
			                    alpha:1,
			                    transition:"easeoutexpo"
					}); //endtween 
					Tweener.addTween(_imageContainer.extra.projectArr[i].t_mc, 
					{
			                  //  x:e.target.x + e.target.width + 50, 
			                    time:.4,
			                    delay:.2,
			                    alpha:0,
			                    transition:"easeoutexpo"
					}); //endtween 
			}//endfor
			
			
			for (var i:Number = 0; i < _imageContainer.extra.videoArray.length; i++)
			{
				if(_imageContainer.extra.videoArray[i].videoContent)
				{
					_imageContainer.extra.videoArray[i].streamClose();
					_imageContainer.extra.videoArray[i].stop();
					
					 Tweener.addTween(_imageContainer.extra.videoArray[i].controlArr[0].mc, 
						{
							
							y:0,
		                    alpha:0,
		                    time:.8,
		                    transition:"easeOutQuad"
					}); //endtween 
						
				}//endif
				
				
				
				
				
			}//endfor
		}
			_nj.stage.addEventListener(MouseEvent.MOUSE_MOVE, thumbMove);
			_xOffset = _nj.stage.mouseX - _thumb.x;
			
		}//endfunction
		
		
		private function thumbUp(e:MouseEvent):void
		{
			_nj.stage.removeEventListener(MouseEvent.MOUSE_MOVE, thumbMove);
		}//endfunction
		
		
		
		
		
		private function thumbMove(e:MouseEvent):void
		{
			_thumb.x = _nj.stage.mouseX - _xOffset;
			
			
			
			if(_thumb.x <= _xMin)
				_thumb.x = _xMin;
			if(_thumb.x >= _xMax)
				_thumb.x = _xMax;
			var sp:Number = thumb.x / _xMax ;

			if(_source=="recent")
			{
				Tweener.addTween(_imageContainer, 
				{
                x:(-sp*(_glWidth+Configuration.mmOffsetX-_masker.width+70)),
                time:.8,
                transition:"easeOutQuad"
		    	 }); //endtween
				
			}//end if
			else if(_source=="other")
			{
				Tweener.addTween(_imageContainer, 
				{
                x:(-sp*(_glWidth+Configuration.mmOffsetX -_masker.width+140)),
                time:.8,
                transition:"easeOutQuad"
		     	}); //endtween
				
			}
			else if(_source=="about")
			{
				Tweener.addTween(_imageContainer, 
				{
                x:(-sp*(_glWidth+Configuration.mmOffsetX-_masker.width+40)),
                time:.8,
                transition:"easeOutQuad"
		     	}); //endtween
			}//end elseif
			
				     
				     
			e.updateAfterEvent();
				
		}
		
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
				Tweener.addTween(e.target, 
						{
		                    _color:0x859d9d,
		                    time:.2,
		                    transition:"easeOutQuad"
					     }); //endtween
		} //endfunction
		
		
		
		public function get thumb():MovieClip
		{
			return _thumb;			
		}//endfunction
		
		
		
		public function get track():MovieClip
		{
			return _track;			
		}//endfunction
		
		public function get masker():MovieClip
		{
			return _masker;
		}//endfunction
	}
}