package
{
       import flash.events.Event;
       import flash.events.EventDispatcher;
       import flash.net.URLLoader;
       import flash.net.URLRequest;
       
       public class XMLLoader extends EventDispatcher 
       {
             private var projects:XML;
             public static var LOAD_COMPLETE               :String = "loadComplete";
             
             public function XMLLoader() 
             {
             }
			
			 public function loadXML(source:String):void
			 {
			 	 var xmlReq:URLRequest = new URLRequest(source);
			 	 var xmlLoader:URLLoader = new URLLoader();
                 xmlLoader.load(xmlReq);
                 xmlLoader.addEventListener(Event.COMPLETE, xmlLoaded,false, 0 , true);
                  
			 }  //endfunction           
             
             private function xmlLoaded(e:Event):void 
             {
                  
                  projects = new XML(e.target.data);
                  // trace(projects.*.length());
                  //trace(projects);
                   dispatchEvent(new Event(LOAD_COMPLETE, true));
                  //trace(projects..@cubePosition); // bring backs all the cubePosition attributes in our projects XML object. descendent
             }//endfunction    
             
             
             public function getProjectTitles():Array 
             {
                  var myArr:Array = new Array;
                  for each (var projectXml:XML in projects.project.projectTitle) {
                  //	myArr.push(projectXml.toString().replace(/\s+/g, ""));
             		myArr.push(projectXml.toString());
             }	
                  //return myArr.reverse();
                  return myArr;
             }
             
             public function getProjectImages():Array
             {
                  var myArr:Array = new Array;
                  
                  for each (var projectXml:XML in projects.project.projectImg) 
                  {
                      myArr.push(projectXml.toString());
                  } //endfor
                  return myArr;
             }
             
             
             public function getProjectSubTitles():Array 
             {
                  var myArr:Array = new Array;
            	for each (var projectXml:XML in projects.project.projectSubTitle) 
                {
                      myArr.push(projectXml.toString());
             	}//endforeach
                  //return myArr.reverse();
                  return myArr;
             }//endfuntion
             
             
             public function getProjectText():Array
             {
                  var myArr:Array = new Array;
                  for each (var projectXml:XML in projects.project.projectText) 
                  {
                      myArr.push(projectXml.toString());
                  } //endfor
                  //return myArr.reverse();   
                  return myArr;
             }
             
             public function getProjectFlvs():Array
             {
                  var myArr:Array = new Array;
                  
                  for each (var projectXml:XML in projects.project.projectFlv) 
                  {
                      myArr.push(projectXml.toString());
                  } //endfor
                  return myArr;
             }
             
             public function getProjectMovs():Array
             {
                  var myArr:Array = new Array;
                  
                  for each (var projectXml:XML in projects.project.projectMov) 
                  {
                      myArr.push(projectXml.toString());
                  } //endfor
                  return myArr;
             }
            
              
             public function getContentImages(current:Number):Array {
                  var myArr:Array = new Array;
                  trace("itemMedia:" + projects.project.items[current].item.itemMedia);
                  for each (var xml:XML in projects.project.items[current].item.itemMedia) 
                  {
                         myArr.push(xml.toString());
                  }
                  return myArr;
             }

       }
}