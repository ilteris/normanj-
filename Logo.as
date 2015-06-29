package
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	
	public class Logo extends EventDispatcher
	{
		private var _mclip:MovieClip = new MovieClip;
		public static var LOAD_COMPLETE:String = "loadComplete";
		
		public function Logo()
		{
		}
		
		public function loadImage():void
		{
			var imgLoader:Loader = new Loader();
			imgLoader.load(new URLRequest("assets/swf/normanJLogo.swf"));
			imgLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoad);
		}//endfunction
		
		private function onLoad(e:Event):void
		{
			var loader:Loader = Loader(e.target.loader);
   			var mc:MovieClip = MovieClip(loader.content);
   			_mclip.addChild(mc);
			dispatchEvent(new Event(LOAD_COMPLETE, true));
		}//endfunction
		
		
		
		public function get mc():MovieClip
		{
			return _mclip;
		}//endfunction

	}
}