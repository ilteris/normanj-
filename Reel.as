package
{

	
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;


	public class Reel extends EventDispatcher
	{
		private var _mclip:MovieClip = new MovieClip;
		private var _videoArr:Array = new Array;
		private var _videoContent:Boolean = false;
		
		public static var LOAD_COMPLETE:String = "loadComplete";
		public function Reel()
		{
		}
		
		public function loadImage():void
		{
			var imgLoader:Loader = new Loader();
			imgLoader.load(new URLRequest("reel.jpg"));
			imgLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoad);
		}//endfunction
		
		
		public function loadVideo():void
		{
			_mclip.x = Configuration.mmOffsetX + 10 ;
   			_mclip.y = 154+45;
			var movie:VideoPlayer = new VideoPlayer("assets/flv/NormanJRoughCut.flv");
			_mclip.addChild(movie.mc);
			movie.createController(250,"assets/mov/NormanJRoughCut.mov");
				
			movie.loadVideo(480,270,true);
			_videoArr.push(movie);
			_videoContent = true;
			// dispatchEvent(new Event(LOAD_COMPLETE, true));
			// _mclip.addEventListener(Event.ENTER_FRAME,onEnterFrame);
		}//endfunction
		
		private function onLoad(e:Event):void
		{
			var loader:Loader = Loader(e.target.loader);
   			var bmp:Bitmap = Bitmap(loader.content);
   			_mclip.addChild(bmp);
   			_mclip.x = 78 ;
   			_mclip.y = 154;
   			
   			_mclip.buttonMode = true;
   			//_mclip.addEventListener(MouseEvent.CLICK, onPress);
   			
			dispatchEvent(new Event(LOAD_COMPLETE, true));
		}//endfunction
		
		private function onEnterFrame(e:Event):void
		{
			trace(e.target.width);
		}//endfunction
		
		
		
		private function onPress(e:Event):void
		{
			/* var movie:VideoPlayer = new VideoPlayer("assets/videos/NormanJRoughCut.flv");
			movie.loadVideo(480,360,true);
			movie.video.x = 0;
			movie.video.y = 0;
			_videoArr.push(movie);
			_mclip.addChild(movie.video);
			 _videoContent = true; */
			 
		}//endfunction
		
		public function get videoContent():Boolean
		{
			return _videoContent;
		}//endfunction
		
		
		public function get videoArr():Array
		{
			return _videoArr;
		}// endfunction
		public function closeStream():void
		{
			_videoArr[0].streamClose();
			_mclip.removeChild(_videoArr[0].mc);
			_videoArr.pop();
			_videoContent = false;
		}//endfunction
		public function get mc():MovieClip
		{
			return _mclip;
		}//endfunction
		
		

	}
}