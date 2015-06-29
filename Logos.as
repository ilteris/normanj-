package
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	
	public class Logos extends EventDispatcher
	{
		private var _mclip:MovieClip = new MovieClip;
		private var _imgContainer:MovieClip = new MovieClip;
		private var _nj:NormanJ;
		
		public static var LOAD_COMPLETE:String = "loadComplete";
		
		public function Logos()
		{
		}
		
		public function loadImage(normanj:NormanJ):void
		{
			_nj = normanj;
			var imgLoader:Loader = new Loader();
			imgLoader.load(new URLRequest("assets/images/logosImg.png"));
			imgLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoad);
		}//endfunction	

		private function onLoad(e:Event):void
		{
			var loader:Loader = Loader(e.target.loader);
   			var bmp:Bitmap = Bitmap(loader.content);
   			var mc:MovieClip = new MovieClip();
			mc.graphics.beginFill(0x34383c,0);
			mc.graphics.drawRect(0,0,1000,308);
			_mclip.addChild(mc);	
			mc.x = 0;
			mc.y = 221;
   			
   			_imgContainer.addChild(bmp);
   			 bmp.x = Configuration.mmOffsetX + 5;
   			_imgContainer.y = mc.y + (mc.height-_imgContainer.height)/2;
   			_imgContainer.x = 0;
   			
			dispatchEvent(new Event(LOAD_COMPLETE, true));
		}//endfunction
		
		
		
		public function createSB(nj:NormanJ):void
		{
			var sb:ScrollBar = new ScrollBar;
			sb.createSB(nj,_imgContainer,"other");	
			
			_mclip.addChild(sb.masker);
			_mclip.addChild(_imgContainer);
			 sb.track.y = nj.bg.mc.height- 30;
			 sb.thumb.y = nj.bg.mc.height - 30;
			 
			
			_mclip.addChild(sb.track);
			_mclip.addChild(sb.thumb);
		}//endfunction
		
		
		
		
		public function get mc():MovieClip
		{
			return _mclip;
		}//endfunction
		
	}
}