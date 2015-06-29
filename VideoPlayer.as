package
{
	import caurina.transitions.Tweener;
	
	import fl.video.VideoEvent;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.utils.Dictionary;
	
	public class VideoPlayer extends EventDispatcher
	{
		
		
		
		private var _txtDict:Dictionary = new Dictionary(true);
		
		
		private var _video:Video;
		private var _source:String;
		private var _img:MovieClip;
		private var _stream:NetStream;
		
		private var _playhead:MovieClip;
		
		private var _controlArr:Array = new Array;
		
		private var _totalTime:Number = -1;
		private var _mclip:MovieClip = new MovieClip;
		
		
		private var _videoContent:Boolean = false;;
		
		public static var STOPPED_STATE_ENTERED:String = "stopped";
		
		public function VideoPlayer(source:String)
		{
		_source = source;
		//_project = project;
		_mclip.extra = {
				videoContent:_videoContent
		}//endextra
		
			var _connection:NetConnection = new NetConnection();
          	_connection.connect(null);
          	_stream = new NetStream(_connection);
			
		}//endfunction

		public function loadVideo(width:Number, height:Number,autoplay:Boolean):void
		{
		
          	_stream.addEventListener(NetStatusEvent.NET_STATUS, netstat);
          	_stream.bufferTime = 2;
          	_stream.client = new Object(); // prevents error message, not catching on MetaData.
          	var _videoWidth:Number = width;
          	var _videoHeight:Number = height;
       		_video = new Video(_videoWidth, _videoHeight);
       		_video.width = _videoWidth;
       		_video.height = _videoHeight;
        	_mclip.addChild(_video); 
			 _video.attachNetStream(_stream);
             _stream.play(_source); 
             
           	Tweener.addTween( _controlArr[0].mc, 
				{
					y:25,
                    alpha:1,
                    time:1.0,
                    transition:"easeoutexpo"
			}); //endtween 
			
			
			var netClient:Object = new Object();
			netClient.onMetaData = function(meta:Object)
			{
					trace("metaduration:" + meta.duration);
			       _totalTime = meta.duration;
			};
			
			  _stream.client = netClient;
			  
			
            _video.addEventListener(VideoEvent.COMPLETE, onComplete);
		}//endfunction
		
		
					
		
		
		public  function stop():void
		{
			_videoContent = false;
			Tweener.addTween(mc, 
				{
                    alpha:0,
                    time:1.5,
                    transition:"easeoutexpo"
			}); //endtween 
			
			if(_img != null)
			{
				_img.mouseEnabled = true;
				
			}//endif
			
			Tweener.addTween(_img, 
				{
                    alpha:1,
                    time:1,
                    transition:"easeoutexpo"
		}); //endtween 
		}//endfunction

		private function onComplete(e:VideoEvent):void
        {
          	streamClose();
        }
        
		private function netstat(stats:NetStatusEvent):void
		{	
	        trace(stats.info.code);	
		};

		public function startVideo():void
		{
			_stream.play(_source);
		} //endfunction
		

		public function streamClose():void
		{
			_stream.close();
			trace("closing");
			removeEvent();
		}

		public function createController(y:Number, source:String):void
		{
			if(y==340)
			{
				var control:VideoControl = new VideoControl(Configuration.controlBtnOutReel);	
			}//endif
			else
			{
				var control:VideoControl = new VideoControl(Configuration.controlBtnOutRest);
			}//endelse
			
			control.video = this;
			control.stream = _stream;
			control.createControls(y);
			control.createDownload(y,source);
			control.mc.alpha = 0;
			createBar(y);
			_controlArr.push(control);
			_mclip.addChild(control.mc);
			
		}	
		
		
		public function createBar(y:Number):void
		{
			_playhead = new MovieClip();
			_playhead.graphics.lineStyle(0,0xb8b8b0,0);
			_playhead.graphics.beginFill(0xb8b8b0,.3);
			_playhead.graphics.drawRect(0, 0, 480, 2);
			_playhead.graphics.endFill();
			_playhead.y = y+20;
			_playhead.width = 0;
			_mclip.addChild(_playhead);
			//creating event
			//trace(_stream.time);
			_playhead.addEventListener(Event.ENTER_FRAME, traceHead);
		}//endfunction
		
		private function traceHead(e:Event):void
		{
			//trace(_stream.time);
			_playhead.width = (_stream.time*480)/_totalTime;
		}//endfunction
		
		
		public function removeEvent():void
		{
			_video.removeEventListener(Event.ENTER_FRAME, traceHead);
		}
		
		
		
			
		public function set img(img:MovieClip):void
		{
			_img = img;			
		}
		
		
		public function set videoContent(bool:Boolean):void
		{
			_mclip.extra.videoContent = bool;
		}//endfunction
		
		
		public function get videoContent():Boolean
		{
			return _mclip.extra.videoContent;	
		}//endfunction
		
		public function get stream():NetStream
		{
			return _stream;
		}
		
		
		public function get video():Video
		{
			return _video;
		}//endfunction
		
		
	
		public function get mc():MovieClip
		{
			return _mclip;
		}//endfunction
		
		public function get controlArr():Array
		{
			return _controlArr;
		} //endfunction
		
	}
}