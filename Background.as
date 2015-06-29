package
{
	import flash.display.MovieClip;
	
	public class Background
	{
		private var _mclip:MovieClip = new MovieClip;
		
		
		public function Background()
		{
			
		}
		
		public function createBg():void
		{
			var mc:MovieClip = new MovieClip();
			mc.graphics.beginFill(Configuration.bgColor,1);
			mc.graphics.drawRect(0,0,1000,563);
			_mclip.addChild(mc);
		}
		
		
		
		public function get mc():MovieClip
		{
			return _mclip;
		}
		
		

	}
}