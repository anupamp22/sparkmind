$(document).ready(function(){

	//showing the dynamic menu drop downs
	$("#navlinks li > a").on('click', function(e){
        $(this).siblings('ul').toggle('slow');
    });
	
	//Showing the dynamic date and time
	function myClock(){
			var now = new Date();
			var dd = now.getDate(); 
			var mm= now.getMonth()+1;
			var yyyy = now.getFullYear();
			var currTime = now.toLocaleTimeString();
			setTimeout(myClock,1000);

			$("#today").text(mm+'/'+dd+'/'+yyyy+' '+currTime);	

	}
	myClock();
	//the hide and show of the divs upon menu selection
	$('#Home').show();
	$('#Company').hide();
	$('#Vision').hide();
	$('#Mission').hide();
	$('#error').hide();
	$('#ManagementTeam').hide();
	$('#searchResults').hide();

	$('#a_home').click(function(){
		$('#Home').toggle();
		$('#Company').hide();
		$('#Vision').hide();
		$('#Mission').hide();
		$('#ManagementTeam').hide();
		$('#searchResults').hide();
	});

	$('#a_company').click(function(){
		$('#Home').hide();
		$('#Company').toggle();
		$('#Vision').hide();
		$('#Mission').hide();
		$('#ManagementTeam').hide();
		$('#searchResults').hide();
	});
	$('#a_vision').click(function(){
		$('#Home').hide();
		$('#Company').hide();
		$('#Vision').toggle();
		$('#Mission').hide();
		$('#div_contact').hide();
		$('#searchResults').hide();
	});
	$('#a_mission').click(function(){
		$('#Home').hide();
		$('#Company').hide();
		$('#Vision').hide();
		$('#Mission').toggle();
		$('#ManagementTeam').hide();
		$('#searchResults').hide();
	});
	$('#search').click(function(){
		$('#Home').hide();
		$('#Company').hide();
		$('#Vision').hide();
		$('#Mission').hide();
		$('#ManagementTeam').hide();
		$('#searchResults').show();		
	});
	$('#a_ManagementTeam').click(function(){
		$('#Home').hide();
		$('#Company').hide();
		$('#Vision').hide();
		$('#Mission').hide();
		$('#ManagementTeam').toggle();
		$('#searchResults').hide();		
	});
	
	
	$('#form_contact').validate({
		rules:{
			name:{required:true, minlength:3},
			company:{required:true},
			email:{required:true,email:true},
			phone:{required:true,number:true,minlength:6}
		},
		message:{
			name:{required:'This field is required', minlength:'min length is 3'},
			company:{reuired:'This field is required'},
			email:{required:'This field is required'},
			phone:{required:'This field is required',number:'Invalid phone no', minlength:'Min length for phone no is 6'},
			message:{required:'This field is required'}
		},
		success:function(label){
			label.html('ok').removeClass('error').addClass('ok');
			setTimeout(function(){
				label.fadeOut(500);
			},2000);
		}		
	}); //end of form_contact validate function
	
	
	$('#form_contact').submit(function(event){
		event.preventDefault();	
		$.postJSON('${pageContext.request.contextPath}/email/send', {
			senderName:$('#name').val(),
			senderCompany:$('#company').val(),
			senderEmail:$('#email').val(),
			senderPhone:$('#phone').val(),
			senderMessage:$('#message').val()			
		},
		function(result){
			if (result.success==true){
				dialog('Success', 'message sent successfully');
			}
			else{
				dialog('Failure', 'there is an error sending this message');
			}			
		});		
	}); //end of contact form send click function
	
}); //end of DOM loading

//Google API feeds
google.load("feeds",1);
function initialize(){
		/*var feed = new google.feeds.Feed("http://www.sciencenews.org/view/feed/name/allrss");
		feed.load(function(result){
			if (!result.error) {
				var container = document.getElementById("feed");
      			for (var i = 0; i < result.feed.entries.length; i++) {
		            var entry = result.feed.entries[i];
		            var div = document.createElement("div");
		            div.appendChild(document.createTextNode(entry.title));
		            container.appendChild(div);
      			}
    		}
		});*/
		var feed =[ "http://feeds.feedburner.com/JavaCodeGeeks",
					"http://www.javaworld.com/category/mobile-java/index.rss",
					"http://www.javaworld.com/category/enterprise-java/index.rss",
					"http://www.javaworld.com/category/core-java/index.rss"];
		var fg = new GFdynamicFeedControl(feed[0],"feed5");
		/*var fg = new GFdynamicFeedControl(feed[1],"feed2");
		var fg = new GFdynamicFeedControl(feed[2],"feed3");
		var fg = new GFdynamicFeedControl(feed[3],"feed4");*/		
	}	
	google.setOnLoadCallback(initialize);	
	
	//Google Search API feeds
    google.load("search", "1");

    // Call this function when the page has been loaded
    function onSearch() {
      var searchControl = new google.search.SearchControl();
      // create a draw options object so that we
      // can position the search form root
      var options = new google.search.DrawOptions();
      options.setSearchFormRoot(document.getElementById("search"));
      
      searchControl.addSearcher(new google.search.WebSearch());
      searchControl.addSearcher(new google.search.NewsSearch());
      //searchControl.draw(document.getElementById("searchcontrol");
      searchControl.draw(document.getElementById("searchResults"), options);
      //searchControl.execute("Ferrari Enzo");
      //$('#content').hide();
      //$('#searchResults').show();
    }
    google.setOnLoadCallback(onSearch);
    
    function dialog(title, text){
    	$('#msgbox').text(text);
    	$('#msgbox').dialog(
    			{
    				title:title,
    				modal:true,
    				buttons:{"ok":function(){
    					$(this).dialog("close");}
    				}
    					
    			});    				
    }//end of dialog function 			
    	
    
    
    
    
 
	