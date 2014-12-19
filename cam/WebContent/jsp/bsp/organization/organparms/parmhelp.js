function forHelp(ev,target,key){
	var parmTypeName="";
	var parmNameControl = document.getElementById("parmsName");
	if(parmNameControl!=null){ 
		parmTypeName=parmNameControl.value;
	}
    var dataSource="2";
	var parmsTypeDs=L5.DatasetMgr.lookup("parmsTypeDs");

	parmsTypeDs.each(function(record){
		if(record.get("value")==parmTypeName){

			dataSource=record.get("dataSource");

		}
	});
	//如果参数类型的数据来源是文本，则弹出组织机构选择树
	if(dataSource==0){
		var url ="bsp_stru.jsp";  
		var win = showModalDialog(url,null,"scroll:yes;status:no;dialogWidth:500px;dialogHeight:550px");
		 if (win == null) {  			
				return ;
			  }else{
				  document.getElementById("parmsValueText").value=win[0];
				  document.getElementById("noteText").value=win[1];
				  L5.fireEvent("parmsValueText","blur");
				  L5.fireEvent("noteText","blur");
			  }
			
	}
	else{


		var url ="parm_help.jsp?parmTypeName=";
		url +=encodeURIComponent(encodeURIComponent(parmTypeName));
		
		var win = showModalDialog(url,null,"scroll:yes;status:no;dialogWidth:500px;dialogHeight:550px");
		if (win == null) {  			
			return ;
		  }else{
			  document.getElementById("parmsValueText").value=win[0];
			  document.getElementById("noteText").value=win[1];
			  L5.fireEvent("parmsValueText","blur");
			  L5.fireEvent("noteText","blur");
		  }		  
	}	
}

function keyPressForHelp(ev,target){
	if(ev.getKey()==L5.EventObject.ENTER&&target.value.trim().length>0){
		forHelp(ev,target,true);
		ev.stopEvent();
	}
}


