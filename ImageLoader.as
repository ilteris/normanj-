package
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	public class ImageLoader extends EventDispatcher {
		
		// this array should contain all the images in our website.
		// basically this is going to be loaded first.
		// since images are going to be cached, we are not going to 
		// deal with them later.
		
		

		
		private var k:Number = 0;
		private var _materialsDict:Dictionary = new Dictionary();
		private var imageMaterialsDict:Dictionary = new Dictionary();
		private var array:Array;
		// it would be great if we had an xml file with flags of which images are to be materials.
		// everything?
		public static var LOAD_COMPLETE 				:String = "loadComplete";
		
		private var loaded:Boolean = false;
		public function ImageLoader():void {
		}
	
		public function loadImages(array_:Array):void {
			array = array_;
			 var material:Loader = new Loader();
			// trace("hello:" + array[k]);
		  	 material.load(new URLRequest(array[k]));
		  	 material.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoad,false, 0 , true);
		} //endfunction
		
		private function onLoad(e:Event):void  {
				   var loader:Loader = Loader(e.target.loader);
   				   var materialBitmap:Bitmap = Bitmap(loader.content);
   				   _materialsDict[array[k]] = materialBitmap;
   				   if(k >= array.length-1) 
   				   {
   				  	 loaded = true;
   				  	 dispatchEvent(new Event(LOAD_COMPLETE, true));
   				   } //endif
   				   else 
   				   {
   				  	 k++;
   				   	 loadImages(array);
   				   } //end else
		} //endfunction
		
		
		public function  getMaterialsDict():Dictionary {
			return _materialsDict;
		}
		
	}
	
	
}