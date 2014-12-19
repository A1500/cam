function init(){
  if (method==null||method==""){
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
		}
	else if (method=="INSERT"){
		dsUpdateTemporaryHelp.newRecord();
	}
	else if (method=="UPDATE"){
		//dsUpdateTemporaryHelp.setParameter("peopleId",peopleId);
		//dsUpdateTemporaryHelp.load();
		dsUpdateTemporaryHelp.setParameter("id",id);
		dsUpdateTemporaryHelp.load();
	}
	else if(method =="DETAIL"){
	    dsUpdateTemporaryHelp.setParameter("id",id);
		dsUpdateTemporaryHelp.load();
	 
	}
	else{
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
	}
	L5.QuickTips.init(); 
	//L5.getCmp("warapply").on("activate",func);
}


function back()
 {	 		 
		window.close();
		
 }
 function print(){
 	var url="../../comm/print/jspcommonprint.jsp?";
	var text='优抚对象临时救助审批表';
	var width = 1024;
	var height = 768;
    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
 }