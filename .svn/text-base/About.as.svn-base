package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class About extends EventDispatcher
	{
		
		
		private var _xmlLoader:XMLLoader = new XMLLoader;
			
			
		private var _AImagesArr:Array = new Array("assets/images/_anorman.png","assets/images/ronda.png");
		private var _ANamesArr:Array = new Array("Todd J. Neale","Ronda Music");
		private var _ATitlesArr:Array = new Array("Creative Director/Founder","Executive Producer");
		private var _ATextArr:Array = new Array("Todd Neale, founder of Norman J and  former Art Director for Trollbäck + Company, has been designing graphics for film and television for over 10 years in both Los Angeles and New York. A native of Australia, Todd began his education in Switzerland at Art Center (Europe) and received his BFA in 1994 from the Art Center Pasadena. Todd started his career at R/GA Digital Studios, NY, his collective body of work now including film titles for Sidney Lumet, broadcast graphics for HBO, VH1, and a myriad of commercial work including Volvo, GMC Trucks, Fidelity, AMC, Sundance and ABC. Designing at Trollbäck + Company since 2000, Todd decided it was time for a new challenge. His signature style, simple elegent and fun can be seen in his most recent work for REELZ CHANNEL.\nTodd has been recognized by the Art Directors Club, Print Digital Design Annual, Broadcast Designers Assocation, The One Show, Communication Arts, and How Magazine.","Ronda, co-founded Big In Japan Inc., a New York based design boutique, in 2002 and presently serves as President and runs the Business Strategy Division, overseeing e-commerce initiatives for retail clients Adrienne Vittadini, Carolee, Casual Corner, Avenue and ABC Home and strategic marketing initiatives for clients Scholastic, MTV, RichFX and many more. From 1997 to 2001 Music served as Executive Creative Director at Xceed Inc., a global new media development agency where she spearheaded online creative business solutions and branding initiatives for BetterSex.com, The Sinclair Intimacy Institute, Dr. Sandra Scantling as well as The United Bank of Switzerland, Men’s Health Magazine Online, TNT, USA Films and Children’s Television Workshop.\nPreceding her move to new media, Music worked extensively in the fashion, commercial and advertising industries serving as a stylist and retail consultant for major print shoots seen in Glamour, Mademoiselle and Vogue and as writer and creative consultant to New York’s premiere advertising agencies. Music holds an MFA from The University of North Carolina at Chapel Hill.");
		private var _AEmailsArr:Array = new Array("todd@normanj.com","ronda@normanj.com");
		
		
		private var _AContainer:MovieClip = new MovieClip;
		private var _totalCont:MovieClip = new MovieClip;
		private var _imgLoader:ImageLoader = new ImageLoader;
		
		
		
		private var _mclip:MovieClip = new MovieClip;
		public static var LOAD_COMPLETE:String = "loadComplete";
		
		public function About()
		{
		}
		
		public function loadPeople():void
		{
			 _xmlLoader.loadXML("assets/xml/projects_4.xml");
			_xmlLoader.addEventListener(XMLLoader.LOAD_COMPLETE, loadNow, false, 0 , true);
			
			
		}//endfunction
		
		
		private function loadNow(e:Event):void
		{
			_imgLoader.loadImages(_xmlLoader.getProjectImages());
			_imgLoader.addEventListener(ImageLoader.LOAD_COMPLETE, createProjects,false, 0, true);	
		}//endfunction
		
		private function createProjects(e:Event):void
		{
		
			var totalWidth:Number = 0;	
			for (var i:Number = 0; i < _xmlLoader.getProjectImages().length; i++)
			{
				var person:APerson = new APerson;
				person.loadImage(_imgLoader.getMaterialsDict()[_xmlLoader.getProjectImages()[i]]);
				person.createName(_xmlLoader.getProjectTitles()[i]);
				person.createTitle(_xmlLoader.getProjectSubTitles()[i]);
				person.createText(_xmlLoader.getProjectText()[i]);
				person.createEmailText(_AEmailsArr[i]);
				person.mc.x = totalWidth;
				person.mc.y = 0;
				_AContainer.addChild(person.mc);
				totalWidth += person.mc.width +  100;
				
			}//endfor
			
			
   			_AContainer.x = 72;
   			_AContainer.y = 255;
   			
   			_totalCont.addChild(_AContainer);
   			_totalCont.x = 0;
   			_mclip.addChild(_totalCont);
			
			 dispatchEvent(new Event(LOAD_COMPLETE, true));
		}//endfunction

		public function createSB(nj:NormanJ):void
		{
			var sb:ScrollBar = new ScrollBar;
			sb.createSB(nj,_totalCont,"about");	
			
			_mclip.addChild(sb.masker);
			_mclip.addChild(_totalCont);
			 sb.track.y = nj.bg.mc.height - 30;
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