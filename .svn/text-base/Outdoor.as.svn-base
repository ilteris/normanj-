package
{
	import caurina.transitions.Tweener;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	
	public class Outdoor extends EventDispatcher
	{
		
		private var _imgLoader:ImageLoader = new ImageLoader;
		
		private var _xmlLoader:XMLLoader = new XMLLoader;
		private var _mclip:MovieClip = new MovieClip;
		private var _RPImgContainerText:MovieClip = new MovieClip;
		private var _RProjectsArr:Array = new Array;
		private var _RPImgContainer:MovieClip = new MovieClip;
		private var enabled:Boolean = false;
		
		private var _videoArr:Array = new Array;
		
		private var _locArr:Array = new Array;
		
		
		private var _current:*;
		
		private var _totalWidthArr:Array = new Array;
		
		private var _nj:NormanJ;
		
		public static var LOAD_COMPLETE:String = "loadComplete";
		public function Outdoor()
		{
		}//endfunction
		
		
		public function createBg():void
		{
			var mc:MovieClip = new MovieClip();
			mc.graphics.lineStyle(0,0x34383c,0);
			mc.graphics.beginFill(0x34383c,0);
			mc.graphics.drawRect(0,0,1000,308);
			_mclip.addChild(mc);
			
		}//endfunction
		
		public function loadProjects():void
		{
            _xmlLoader.loadXML("assets/xml/projects_2.xml");
			_xmlLoader.addEventListener(XMLLoader.LOAD_COMPLETE, loadImages, false, 0 , true);
			}//endfunction
		
		
		private function loadImages(e:Event):void
		{
			_imgLoader.loadImages(_xmlLoader.getProjectImages());
			_imgLoader.addEventListener(ImageLoader.LOAD_COMPLETE, createProjects,false, 0, true);
		}//endfunction


		private function createProjects(e:Event):void
		{
			var totalWidth:Number = 10;
			for (var i:Number = 0; i < _xmlLoader.getProjectImages().length; i++)
			{
				var project:RProject = new RProject(i);
				
				project.loadImage(_imgLoader.getMaterialsDict()[_xmlLoader.getProjectImages()[i]]);
				project.mc.x = totalWidth;
				project.mc.y = 0;
				project.createTitle(_xmlLoader.getProjectTitles()[i]);
				project.createSubTitle(_xmlLoader.getProjectSubTitles()[i]);
				project.createText(_xmlLoader.getProjectText()[i]);
				//project.createDownload(_xmlLoader.getProjectMovs()[i]);
				project.t_mc.alpha = 0;
				_RPImgContainer.addChild(project.bgclip);
				_RPImgContainer.addChild(project.t_mc);
				
				_RProjectsArr.push(project);
				
				 var movie:VideoPlayer = new VideoPlayer(_xmlLoader.getProjectFlvs()[i]);
				
				movie.img = project.mc;
				movie.mc.x = project.mc.x;
				movie.mc.y = project.mc.y; 
				movie.createController(250,_xmlLoader.getProjectMovs()[i]);
				
				 _videoArr.push(movie); 
				_RPImgContainer.addChild(movie.mc); 
				
				_RPImgContainer.addChild(project.mc);
				project.t_mc.alpha = 0;

				project.t_mc.x = project.mc.x + project.mc.width-project.t_mc.width;
				
				_totalWidthArr.push(totalWidth);
				totalWidth += project.mc.width;	
				
				
				project.mc.addEventListener(MouseEvent.CLICK,onPress);	
				project.mc.addEventListener(MouseEvent.MOUSE_OVER, onRollOver);
				
						
			}//endfor
			
			var mc:MovieClip = new MovieClip();
			mc.graphics.beginFill(0x34383c,0);
			mc.graphics.drawRect(0,0,1000,308);
			_mclip.addChild(mc);	
			mc.x = 0;
			mc.y = 221;
			
			
			_RPImgContainer.x = Configuration.mmOffsetX;
			_RPImgContainerText.addChild(_RPImgContainer);
			_RPImgContainerText.y = mc.y + (mc.height-_RPImgContainerText.height)/2;
			//_RPImgContainerText.addEventListener(Event.ENTER_FRAME,onEnterFrame);
			dispatchEvent(new Event(LOAD_COMPLETE, true));
		}//endfunction
		
		
		
			
		private function onRollOver(e:Event):void
		{
			  for(var i:Number = 0; i < _RProjectsArr.length; i++)
                  {
                      //trace("_RProjectsArr[i].mc.extra.id: " + _RProjectsArr[i].mc.extra._id);
                      //trace("e.trget.extra.id: " + e.target.extra._id);
                      if(enabled)
                      {
                        /*  Tweener.addTween(_RProjectsArr[i].mc, 
                         {
                                      x:_RProjectsArr[i].mc.x + _RProjectsArr[i].mc.width + 50,
                                      alpha:1,
                                      time:2,
                                      delay:.2,
                                      transition:"easeoutexpo"
                         }); //endtween  */
                      }//endif
                      else
                      {
                      }//endelseif
                      if(e.target.extra._id ==  _RProjectsArr[i].mc.extra._id)
                      {
                         enabled = true;
                         //check enabled
                         //if false
                         //don't do anything.
                         //else tween
                         
                      }//endif
                  }//endfor
                  enabled = false;
                  
                  e.target.addEventListener(Event.ENTER_FRAME,checkBoundary); 
			
                   /* Tweener.addTween(e.target.extra.t_mc, 
                           {
                                 x:e.target.x + e.target.width + 50,
                                 alpha:1,
                                 time:2,
                                 delay:.2,
                                 transition:"easeoutexpo"
                  }); //endtween  */
 					
					
		}//endfunction
		
		
		private function checkBoundary(e:Event):void
             {
                  var tl:Number = e.target.x;
                  var tr:Number = e.target.x + e.target.width + e.target.width*.7;
                  var t:Number  = e.target.y;
                  var b:Number  = e.target.y + e.target.height;
                  
                  
                /*   trace("e.target.mouseX: " + e.target.mouseX);
                  trace("e.target.mouseY: " + e.target.mouseY);
                  trace("tl: " + tl);
                  trace("tr: " + tr);
                  trace("t: " + t);
                  trace("b: " + b); */
                  
                  
                  //add 20 offset for x and y!
                   if(e.target.mouseX + e.target.x < tl || e.target.mouseX + e.target.x > tr || e.target.mouseY < t || e.target.mouseY > b )
                   {
                      e.target.removeEventListener(Event.ENTER_FRAME, checkBoundary);
				      for(var i:Number = 0; i < _RProjectsArr.length; i++)
					  {
				
						if(enabled)
						{
						//	trace(i);
							Tweener.addTween(_RProjectsArr[i].mc, 
							{
					                    x:_totalWidthArr[i],
					                    time:2,
					                    delay:.2,
					                    transition:"easeoutexpo"
							}); //endtween 
						}//endif
						else
						{
						}//endelseif
							
						if(e.target.extra._id ==  _RProjectsArr[i].mc.extra._id)
						{
							enabled = true;
							//check enabled
							//if false
							//don't do anything.
							//else tween
							
						}//endif
					}//endfor
					
					enabled = false;
					/* Tweener.addTween(e.target.extra.t_mc, 
								{
				                    x:e.target.x + e.target.width - e.target.extra.t_mc.width,
				                    alpha:0,
				                    time:.8,
				                    delay:.1,
				                    transition:"easeoutexpo"
					}); //endtween  */
					
					
                  }//endif 
                  else
                  {
                  	 //trace(e.target.mouseX);
                  }//end else
             }//endfunction
             
             
		private function rollOut(e:MovieClip):void
		{
			for(var i:Number = 0; i < _RProjectsArr.length; i++)
			{
				
				if(enabled)
				{
				//	trace(i);
					Tweener.addTween(_RProjectsArr[i].mc, 
					{
			                    x:_totalWidthArr[i],
			                    time:2,
			                    delay:.2,
			                    transition:"easeoutexpo"
					}); //endtween 
					
					
			
				}//endif
				else
				{
					
				}//endelseif
					
				if(e.target.extra._id ==  _RProjectsArr[i].mc.extra._id)
				{
					enabled = true;
					//check enabled
					//if false
					//don't do anything.
					//else tween
					
				}//endif
			}//endfor
			
			enabled = false;
					
		}//endfunction
		
		
		private function onPress(e:MouseEvent):void
		{
			//_RPImgContainerText.x = _current * - 480;
			
			
			_current = e.target.extra._id;
			
			
			 Tweener.addTween(_RPImgContainerText, 
					{
						x:-1*_current * 480,
	                    time:2,
	                    transition:"easeoutexpo",
	                    onComplete:function():void
	                    { 
	        				 _videoArr[e.target.extra._id].videoContent = true;
			 				 _videoArr[e.target.extra._id].loadVideo(480,270,true);
			 				Tweener.addTween(e.target, 
							{
	                  			  alpha:0,
	                   			  time:1,
	                    		  transition:"easeoutexpo"
							}); //endtween  
			 			}//endfunction
			}); //endtween 
			
			
			
			e.target.mouseEnabled = false;
			 Tweener.addTween(_videoArr[e.target.extra._id].mc, 
					{
	                    alpha:1,
	                    time:1,
	                    transition:"easeoutexpo"
			}); //endtween 
			
			for(var i:Number = 0; i < _RProjectsArr.length; i++)
			{
				
					
				if(e.target.extra._id ==  _RProjectsArr[i].mc.extra._id)
				{
					//check enabled
					//if false
					//don't do anything.
					//else tween
					
				}//endif
				else
				{
					
					Tweener.addTween(_RProjectsArr[i].mc, 
					{
			                    //x:_RProjectsArr[i].mc.x + _RProjectsArr[i].mc.width + 50, 
			                    time:1,
			                    delay:.2,
			                    alpha:0,
			                    transition:"easeoutexpo"
					}); //endtween 
					
					_RProjectsArr[i].mc.mouseEnabled = false;
					_RProjectsArr[i].mc.buttonMode = false;
				}//endelse
			}//endfor
			
			  Tweener.addTween(e.target.extra.t_mc, 
                           {
                                 x:e.target.x + e.target.width + 50,
                                 alpha:1,
                                 time:3,
                                 delay:.2,
                                 transition:"easeoutexpo"
                  }); //endtween  
			
			
			 e.target.removeEventListener(Event.ENTER_FRAME, checkBoundary);
			 
			 // should we remove RollOver Event Listeners for each object at this point?
			
		}//endfunction
		
		
		public function createSB(nj:NormanJ):void
		{
			var sb:ScrollBar = new ScrollBar;
			_RPImgContainerText.extra = {
			videoArray:_videoArr,
			projectArr:_RProjectsArr
			}//endextr
			sb.createSB(nj,_RPImgContainerText,"recent");	
			
			_mclip.addChild(_RPImgContainerText);
			_mclip.addChild(sb.masker);
			 sb.track.y = nj.bg.mc.height - 25;
			 sb.thumb.y = nj.bg.mc.height - 25;
			 
			
			_mclip.addChild(sb.track);
			_mclip.addChild(sb.thumb); 
		}//endfunction
		
		
		private function onEnterFrame(e:Event):void
		{
			//trace(e.target.width);
		}//endfunction
		
		
		public function get RPImgContainerText():MovieClip
		{
			return _RPImgContainerText;
		}//endfunction
		
		public function get videoArray():Array
		{
			return _videoArr;
		}//endfunction
		
		public function get mc():MovieClip
		{
			return _mclip;
		}//endfunction
		
		public function get RProjectsArr():Array
		{
			return _RProjectsArr;
		}//endfunction

	}
}