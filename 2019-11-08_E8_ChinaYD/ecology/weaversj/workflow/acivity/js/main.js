//初始化加载
jQuery(document).ready(function(){	
	  	getField();
	  	
	  	//控制结束日期时间不能大于起始日期时间
	    //改变值触发 
	    jQuery("#"+mid.Start_Date).bindPropertyChange(function(){ 
	    	
	    	var Start_Date = jQuery("#"+mid.Start_Date).val();//起始日期	
	    	var Start_Time = jQuery("#"+mid.Start_Time).val();//起始时间	
	    	
	       	var End_Date = jQuery("#"+mid.End_Date).val();//结束日期	
	       	var End_Time = jQuery("#"+mid.End_Time).val();//结束时间
	       	
	    	var Return_date = jQuery("#"+mid.Return_date).val();//回程日期	
	       	var Return_time = jQuery("#"+mid.Return_time).val();//回程时间	
	   
	       	
	       	if(End_Date!=""){
		       	var Y = "0000";//年
		     	var M = "00";
		     	var D = "00";
		     	var h = "00";
		     	var m = "00";
		    	if(Start_Date!=""){
		    		Y = Start_Date.substring(0,4);
		    		M = Start_Date.substring(5,7); 
		    		D = Start_Date.substring(8,10); 
		    	}
		       	if(Start_Time!=""){
		       		h = Start_Time.substring(0,2);
		       		m = Start_Time.substring(3,5);
		       	}
		       	
		       	var Y2 = "0000";//年
		     	var M2 = "00";
		     	var D2 = "00";
		     	var h2 = "00";
		     	var m2 = "00";
		    	if(End_Date!=""){
		    		Y2 = End_Date.substring(0,4);
		    		M2 = End_Date.substring(5,7); 
		    		D2 = End_Date.substring(8,10); 		    		
		    	}
		       	if(End_Time!=""){
		       		h2 = End_Time.substring(0,2);
		       		m2 = End_Time.substring(3,5);
		       	}
		       	       	
		       	var time1 = Date.UTC(Y,M,D,h,m,"00");
		       	var time2 = Date.UTC(Y2,M2,D2,h2,m2,"00");
		       	
		       
		       	if(time1>time2){
		       		jQuery("#"+mid.End_Date).val("");
		       		jQuery("#"+mid.End_Date+"span").html("");
		       		if(languageid ==8){
			        	top.Dialog.alert("End date should be greater than start date!");	
	        	    }else{
	    	        	top.Dialog.alert("结束日期时间应大于起始日期时间！");	
	        	    }
		       	}
	       	}
	       	
	       	
	       	if(Return_date!=""){
		       	var Y = "0000";//年
		     	var M = "00";
		     	var D = "00";
		     	var h = "00";
		     	var m = "00";
		    	if(Start_Date!=""){
		    		Y = Start_Date.substring(0,4);
		    		M = Start_Date.substring(5,7); 
		    		D = Start_Date.substring(8,10); 
		    	}
		       	if(Start_Time!=""){
		       		h = Start_Time.substring(0,2);
		       		m = Start_Time.substring(3,5);
		       	}
		       	
		       	var Y2 = "0000";//年
		     	var M2 = "00";
		     	var D2 = "00";
		     	var h2 = "00";
		     	var m2 = "00";
		    	if(Return_date!=""){
		    		Y2 = Return_date.substring(0,4);
		    		M2 = Return_date.substring(5,7); 
		    		D2 = Return_date.substring(8,10); 		    		
		    	}
		       	if(Return_time!=""){
		       		h2 = Return_time.substring(0,2);
		       		m2 = Return_time.substring(3,5);
		       	}
		       			       	
		       	var time1 = Date.UTC(Y,M,D,h,m,"00");
		       	var time2 = Date.UTC(Y2,M2,D2,h2,m2,"00");
		       			       
		       	if(time1>time2){
		       		jQuery("#"+mid.Return_date).val("");
		       		jQuery("#"+mid.Return_date+"span").html("");
		       		if(languageid ==8){
			        	top.Dialog.alert("Return date should be greater than start date!");	
	        	    }else{
	    	        	top.Dialog.alert("回程日期时间应大于起始日期时间！");	
	        	    }
		       	}
	       	}   	  
	    });
	    
	    //改变值触发 
	    jQuery("#"+mid.Start_Time).bindPropertyChange(function(){ 
	    	
	    	var Start_Date = jQuery("#"+mid.Start_Date).val();//起始日期	
	    	var Start_Time = jQuery("#"+mid.Start_Time).val();//起始时间	
	    	
	       	var End_Date = jQuery("#"+mid.End_Date).val();//结束日期	
	       	var End_Time = jQuery("#"+mid.End_Time).val();//结束时间
	       	
	    	var Return_date = jQuery("#"+mid.Return_date).val();//回程日期	
	       	var Return_time = jQuery("#"+mid.Return_time).val();//回程时间	
	   
	       	
	       	if(End_Date!=""){
		       	var Y = "0000";//年
		     	var M = "00";
		     	var D = "00";
		     	var h = "00";
		     	var m = "00";
		    	if(Start_Date!=""){
		    		Y = Start_Date.substring(0,4);
		    		M = Start_Date.substring(5,7); 
		    		D = Start_Date.substring(8,10); 
		    	}
		       	if(Start_Time!=""){
		       		h = Start_Time.substring(0,2);
		       		m = Start_Time.substring(3,5);
		       	}
		       	
		       	var Y2 = "0000";//年
		     	var M2 = "00";
		     	var D2 = "00";
		     	var h2 = "00";
		     	var m2 = "00";
		    	if(End_Date!=""){
		    		Y2 = End_Date.substring(0,4);
		    		M2 = End_Date.substring(5,7); 
		    		D2 = End_Date.substring(8,10); 		    		
		    	}
		       	if(End_Time!=""){
		       		h2 = End_Time.substring(0,2);
		       		m2 = End_Time.substring(3,5);
		       	}
		       	       	
		       	var time1 = Date.UTC(Y,M,D,h,m,"00");
		       	var time2 = Date.UTC(Y2,M2,D2,h2,m2,"00");
		       	
		       
		       	if(time1>time2){
		       		jQuery("#"+mid.End_Date).val("");
		       		jQuery("#"+mid.End_Date+"span").html("");
		       		if(languageid ==8){
			        	top.Dialog.alert("End date should be greater than start date!");	
	        	    }else{
	    	        	top.Dialog.alert("结束日期时间应大于起始日期时间！");	
	        	    }
		       	}
	       	}
	       	
	       	
	       	if(Return_date!=""){
		       	var Y = "0000";//年
		     	var M = "00";
		     	var D = "00";
		     	var h = "00";
		     	var m = "00";
		    	if(Start_Date!=""){
		    		Y = Start_Date.substring(0,4);
		    		M = Start_Date.substring(5,7); 
		    		D = Start_Date.substring(8,10); 
		    	}
		       	if(Start_Time!=""){
		       		h = Start_Time.substring(0,2);
		       		m = Start_Time.substring(3,5);
		       	}
		       	
		       	var Y2 = "0000";//年
		     	var M2 = "00";
		     	var D2 = "00";
		     	var h2 = "00";
		     	var m2 = "00";
		    	if(Return_date!=""){
		    		Y2 = Return_date.substring(0,4);
		    		M2 = Return_date.substring(5,7); 
		    		D2 = Return_date.substring(8,10); 		    		
		    	}
		       	if(Return_time!=""){
		       		h2 = Return_time.substring(0,2);
		       		m2 = Return_time.substring(3,5);
		       	}
		       			       	
		       	var time1 = Date.UTC(Y,M,D,h,m,"00");
		       	var time2 = Date.UTC(Y2,M2,D2,h2,m2,"00");
		       			       
		       	if(time1>time2){
		       		jQuery("#"+mid.Return_date).val("");
		       		jQuery("#"+mid.Return_date+"span").html("");
		       		if(languageid ==8){
			        	top.Dialog.alert("Return date should be greater than start date!");	
	        	    }else{
	    	        	top.Dialog.alert("回程日期时间应大于起始日期时间！");	
	        	    }
		       	}
	       	}
	       	
	       	
	    	  
	    });	 
	    //改变值触发 
	    jQuery("#"+mid.End_Date).bindPropertyChange(function(){ 
	    	
	    	var Start_Date = jQuery("#"+mid.Start_Date).val();//起始日期	
	    	var Start_Time = jQuery("#"+mid.Start_Time).val();//起始时间	
	    	
	       	var End_Date = jQuery("#"+mid.End_Date).val();//结束日期	
	       	var End_Time = jQuery("#"+mid.End_Time).val();//结束时间
	       	
	    	var Return_date = jQuery("#"+mid.Return_date).val();//回程日期	
	       	var Return_time = jQuery("#"+mid.Return_time).val();//回程时间	
	   
	       	
	       	if(End_Date!=""){
		       	var Y = "0000";//年
		     	var M = "00";
		     	var D = "00";
		     	var h = "00";
		     	var m = "00";
		    	if(Start_Date!=""){
		    		Y = Start_Date.substring(0,4);
		    		M = Start_Date.substring(5,7); 
		    		D = Start_Date.substring(8,10); 
		    	}
		       	if(Start_Time!=""){
		       		h = Start_Time.substring(0,2);
		       		m = Start_Time.substring(3,5);
		       	}
		       	
		       	var Y2 = "0000";//年
		     	var M2 = "00";
		     	var D2 = "00";
		     	var h2 = "00";
		     	var m2 = "00";
		    	if(End_Date!=""){
		    		Y2 = End_Date.substring(0,4);
		    		M2 = End_Date.substring(5,7); 
		    		D2 = End_Date.substring(8,10); 		    		
		    	}
		       	if(End_Time!=""){
		       		h2 = End_Time.substring(0,2);
		       		m2 = End_Time.substring(3,5);
		       	}
		       	       	
		       	var time1 = Date.UTC(Y,M,D,h,m,"00");
		       	var time2 = Date.UTC(Y2,M2,D2,h2,m2,"00");
		       	
		       
		       	if(time1>time2){
		       		jQuery("#"+mid.End_Date).val("");
		       		jQuery("#"+mid.End_Date+"span").html("");
		       		if(languageid ==8){
			        	top.Dialog.alert("End date should be greater than start date!");	
	        	    }else{
	    	        	top.Dialog.alert("结束日期时间应大于起始日期时间！");	
	        	    }
		       	}
	       	}
	       	
	       	
	       	if(Return_date!=""){
		       	var Y = "0000";//年
		     	var M = "00";
		     	var D = "00";
		     	var h = "00";
		     	var m = "00";
		    	if(Start_Date!=""){
		    		Y = Start_Date.substring(0,4);
		    		M = Start_Date.substring(5,7); 
		    		D = Start_Date.substring(8,10); 
		    	}
		       	if(Start_Time!=""){
		       		h = Start_Time.substring(0,2);
		       		m = Start_Time.substring(3,5);
		       	}
		       	
		       	var Y2 = "0000";//年
		     	var M2 = "00";
		     	var D2 = "00";
		     	var h2 = "00";
		     	var m2 = "00";
		    	if(Return_date!=""){
		    		Y2 = Return_date.substring(0,4);
		    		M2 = Return_date.substring(5,7); 
		    		D2 = Return_date.substring(8,10); 		    		
		    	}
		       	if(Return_time!=""){
		       		h2 = Return_time.substring(0,2);
		       		m2 = Return_time.substring(3,5);
		       	}
		       			       	
		       	var time1 = Date.UTC(Y,M,D,h,m,"00");
		       	var time2 = Date.UTC(Y2,M2,D2,h2,m2,"00");
		       			       
		       	if(time1>time2){
		       		jQuery("#"+mid.Return_date).val("");
		       		jQuery("#"+mid.Return_date+"span").html("");
		       		if(languageid ==8){
			        	top.Dialog.alert("Return date should be greater than start date!");	
	        	    }else{
	    	        	top.Dialog.alert("回程日期时间应大于起始日期时间！");	
	        	    }
		       	}
	       	}
	       	
	       	
	    	  
	    });	 
	    //改变值触发 
	    jQuery("#"+mid.End_Time).bindPropertyChange(function(){ 
	    	
	    	var Start_Date = jQuery("#"+mid.Start_Date).val();//起始日期	
	    	var Start_Time = jQuery("#"+mid.Start_Time).val();//起始时间	
	    	
	       	var End_Date = jQuery("#"+mid.End_Date).val();//结束日期	
	       	var End_Time = jQuery("#"+mid.End_Time).val();//结束时间
	       	
	    	var Return_date = jQuery("#"+mid.Return_date).val();//回程日期	
	       	var Return_time = jQuery("#"+mid.Return_time).val();//回程时间	
	   
	       	
	       	if(End_Date!=""){
		       	var Y = "0000";//年
		     	var M = "00";
		     	var D = "00";
		     	var h = "00";
		     	var m = "00";
		    	if(Start_Date!=""){
		    		Y = Start_Date.substring(0,4);
		    		M = Start_Date.substring(5,7); 
		    		D = Start_Date.substring(8,10); 
		    	}
		       	if(Start_Time!=""){
		       		h = Start_Time.substring(0,2);
		       		m = Start_Time.substring(3,5);
		       	}
		       	
		       	var Y2 = "0000";//年
		     	var M2 = "00";
		     	var D2 = "00";
		     	var h2 = "00";
		     	var m2 = "00";
		    	if(End_Date!=""){
		    		Y2 = End_Date.substring(0,4);
		    		M2 = End_Date.substring(5,7); 
		    		D2 = End_Date.substring(8,10); 		    		
		    	}
		       	if(End_Time!=""){
		       		h2 = End_Time.substring(0,2);
		       		m2 = End_Time.substring(3,5);
		       	}
		       	       	
		       	var time1 = Date.UTC(Y,M,D,h,m,"00");
		       	var time2 = Date.UTC(Y2,M2,D2,h2,m2,"00");
		       	
		       
		       	if(time1>time2){
		       		jQuery("#"+mid.End_Date).val("");
		       		jQuery("#"+mid.End_Date+"span").html("");
		       		if(languageid ==8){
			        	top.Dialog.alert("End date should be greater than start date!");	
	        	    }else{
	    	        	top.Dialog.alert("结束日期时间应大于起始日期时间！");	
	        	    }
		       	}
	       	}
	       	
	       	
	       	if(Return_date!=""){
		       	var Y = "0000";//年
		     	var M = "00";
		     	var D = "00";
		     	var h = "00";
		     	var m = "00";
		    	if(Start_Date!=""){
		    		Y = Start_Date.substring(0,4);
		    		M = Start_Date.substring(5,7); 
		    		D = Start_Date.substring(8,10); 
		    	}
		       	if(Start_Time!=""){
		       		h = Start_Time.substring(0,2);
		       		m = Start_Time.substring(3,5);
		       	}
		       	
		       	var Y2 = "0000";//年
		     	var M2 = "00";
		     	var D2 = "00";
		     	var h2 = "00";
		     	var m2 = "00";
		    	if(Return_date!=""){
		    		Y2 = Return_date.substring(0,4);
		    		M2 = Return_date.substring(5,7); 
		    		D2 = Return_date.substring(8,10); 		    		
		    	}
		       	if(Return_time!=""){
		       		h2 = Return_time.substring(0,2);
		       		m2 = Return_time.substring(3,5);
		       	}
		       			       	
		       	var time1 = Date.UTC(Y,M,D,h,m,"00");
		       	var time2 = Date.UTC(Y2,M2,D2,h2,m2,"00");
		       			       
		       	if(time1>time2){
		       		jQuery("#"+mid.Return_date).val("");
		       		jQuery("#"+mid.Return_date+"span").html("");
		       		if(languageid ==8){
			        	top.Dialog.alert("Return date should be greater than start date!");	
	        	    }else{
	    	        	top.Dialog.alert("回程日期时间应大于起始日期时间！");	
	        	    }
		       	}
	       	}
	       	
	       	
	    	  
	    });	 
	    
	    //改变值触发 
	    jQuery("#"+mid.Return_date).bindPropertyChange(function(){ 
	    	
	    	var Start_Date = jQuery("#"+mid.Start_Date).val();//起始日期	
	    	var Start_Time = jQuery("#"+mid.Start_Time).val();//起始时间	
	    	
	       	var End_Date = jQuery("#"+mid.End_Date).val();//结束日期	
	       	var End_Time = jQuery("#"+mid.End_Time).val();//结束时间
	       	
	    	var Return_date = jQuery("#"+mid.Return_date).val();//回程日期	
	       	var Return_time = jQuery("#"+mid.Return_time).val();//回程时间	
	   
	       	
	       	if(End_Date!=""){
		       	var Y = "0000";//年
		     	var M = "00";
		     	var D = "00";
		     	var h = "00";
		     	var m = "00";
		    	if(Start_Date!=""){
		    		Y = Start_Date.substring(0,4);
		    		M = Start_Date.substring(5,7); 
		    		D = Start_Date.substring(8,10); 
		    	}
		       	if(Start_Time!=""){
		       		h = Start_Time.substring(0,2);
		       		m = Start_Time.substring(3,5);
		       	}
		       	
		       	var Y2 = "0000";//年
		     	var M2 = "00";
		     	var D2 = "00";
		     	var h2 = "00";
		     	var m2 = "00";
		    	if(End_Date!=""){
		    		Y2 = End_Date.substring(0,4);
		    		M2 = End_Date.substring(5,7); 
		    		D2 = End_Date.substring(8,10); 		    		
		    	}
		       	if(End_Time!=""){
		       		h2 = End_Time.substring(0,2);
		       		m2 = End_Time.substring(3,5);
		       	}
		       	       	
		       	var time1 = Date.UTC(Y,M,D,h,m,"00");
		       	var time2 = Date.UTC(Y2,M2,D2,h2,m2,"00");
		       	
		       
		       	if(time1>time2){
		       		jQuery("#"+mid.End_Date).val("");
		       		jQuery("#"+mid.End_Date+"span").html("");
		       		if(languageid ==8){
			        	top.Dialog.alert("End date should be greater than start date!");	
	        	    }else{
	    	        	top.Dialog.alert("结束日期时间应大于起始日期时间！");	
	        	    }
		       	}
	       	}
	       	
	       	
	       	if(Return_date!=""){
		       	var Y = "0000";//年
		     	var M = "00";
		     	var D = "00";
		     	var h = "00";
		     	var m = "00";
		    	if(Start_Date!=""){
		    		Y = Start_Date.substring(0,4);
		    		M = Start_Date.substring(5,7); 
		    		D = Start_Date.substring(8,10); 
		    	}
		       	if(Start_Time!=""){
		       		h = Start_Time.substring(0,2);
		       		m = Start_Time.substring(3,5);
		       	}
		       	
		       	var Y2 = "0000";//年
		     	var M2 = "00";
		     	var D2 = "00";
		     	var h2 = "00";
		     	var m2 = "00";
		    	if(Return_date!=""){
		    		Y2 = Return_date.substring(0,4);
		    		M2 = Return_date.substring(5,7); 
		    		D2 = Return_date.substring(8,10); 		    		
		    	}
		       	if(Return_time!=""){
		       		h2 = Return_time.substring(0,2);
		       		m2 = Return_time.substring(3,5);
		       	}
		       			       	
		       	var time1 = Date.UTC(Y,M,D,h,m,"00");
		       	var time2 = Date.UTC(Y2,M2,D2,h2,m2,"00");
		       			       
		       	if(time1>time2){
		       		jQuery("#"+mid.Return_date).val("");
		       		jQuery("#"+mid.Return_date+"span").html("");
		       		if(languageid ==8){
			        	top.Dialog.alert("Return date should be greater than start date!");	
	        	    }else{
	    	        	top.Dialog.alert("回程日期时间应大于起始日期时间！");	
	        	    }
		       	}
	       	}
	       	
	       	
	    	  
	    });	 
	    
	    //改变值触发 
	    jQuery("#"+mid.Return_time).bindPropertyChange(function(){ 
	    	
	    	var Start_Date = jQuery("#"+mid.Start_Date).val();//起始日期	
	    	var Start_Time = jQuery("#"+mid.Start_Time).val();//起始时间	
	    	
	       	var End_Date = jQuery("#"+mid.End_Date).val();//结束日期	
	       	var End_Time = jQuery("#"+mid.End_Time).val();//结束时间
	       	
	    	var Return_date = jQuery("#"+mid.Return_date).val();//回程日期	
	       	var Return_time = jQuery("#"+mid.Return_time).val();//回程时间	
	   
	       	
	       	if(End_Date!=""){
		       	var Y = "0000";//年
		     	var M = "00";
		     	var D = "00";
		     	var h = "00";
		     	var m = "00";
		    	if(Start_Date!=""){
		    		Y = Start_Date.substring(0,4);
		    		M = Start_Date.substring(5,7); 
		    		D = Start_Date.substring(8,10); 
		    	}
		       	if(Start_Time!=""){
		       		h = Start_Time.substring(0,2);
		       		m = Start_Time.substring(3,5);
		       	}
		       	
		       	var Y2 = "0000";//年
		     	var M2 = "00";
		     	var D2 = "00";
		     	var h2 = "00";
		     	var m2 = "00";
		    	if(End_Date!=""){
		    		Y2 = End_Date.substring(0,4);
		    		M2 = End_Date.substring(5,7); 
		    		D2 = End_Date.substring(8,10); 		    		
		    	}
		       	if(End_Time!=""){
		       		h2 = End_Time.substring(0,2);
		       		m2 = End_Time.substring(3,5);
		       	}
		       	       	
		       	var time1 = Date.UTC(Y,M,D,h,m,"00");
		       	var time2 = Date.UTC(Y2,M2,D2,h2,m2,"00");
		       	
		       
		       	if(time1>time2){
		       		jQuery("#"+mid.End_Date).val("");
		       		jQuery("#"+mid.End_Date+"span").html("");
		       		if(languageid ==8){
			        	top.Dialog.alert("End date should be greater than start date!");	
	        	    }else{
	    	        	top.Dialog.alert("结束日期时间应大于起始日期时间！");	
	        	    }
		       	}
	       	}
	       	
	       	
	       	if(Return_date!=""){
		       	var Y = "0000";//年
		     	var M = "00";
		     	var D = "00";
		     	var h = "00";
		     	var m = "00";
		    	if(Start_Date!=""){
		    		Y = Start_Date.substring(0,4);
		    		M = Start_Date.substring(5,7); 
		    		D = Start_Date.substring(8,10); 
		    	}
		       	if(Start_Time!=""){
		       		h = Start_Time.substring(0,2);
		       		m = Start_Time.substring(3,5);
		       	}
		       	
		       	var Y2 = "0000";//年
		     	var M2 = "00";
		     	var D2 = "00";
		     	var h2 = "00";
		     	var m2 = "00";
		    	if(Return_date!=""){
		    		Y2 = Return_date.substring(0,4);
		    		M2 = Return_date.substring(5,7); 
		    		D2 = Return_date.substring(8,10); 		    		
		    	}
		       	if(Return_time!=""){
		       		h2 = Return_time.substring(0,2);
		       		m2 = Return_time.substring(3,5);
		       	}
		       			       	
		       	var time1 = Date.UTC(Y,M,D,h,m,"00");
		       	var time2 = Date.UTC(Y2,M2,D2,h2,m2,"00");
		       			       
		       	if(time1>time2){
		       		jQuery("#"+mid.Return_date).val("");
		       		jQuery("#"+mid.Return_date+"span").html("");
		       		if(languageid ==8){
			        	top.Dialog.alert("Return date should be greater than start date!");	
	        	    }else{
	    	        	top.Dialog.alert("回程日期时间应大于起始日期时间！");	
	        	    }
		       	}
	       	}
 	  
	    });	 

		
}); 


