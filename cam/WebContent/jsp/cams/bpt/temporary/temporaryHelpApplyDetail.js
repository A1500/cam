function init(){
  if (method==null||method==""){
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
		}
	else if (method=="INSERT"){
		dsUpdateTemporaryHelp.newRecord();
	}
	else if (method=="UPDATE"){
		dsUpdateTemporaryHelp.setParameter("applyId",applyId);
		dsUpdateTemporaryHelp.load();
	}
	else if(method =="DETAIL"){
	    dsUpdateTemporaryHelp.setParameter("applyId",applyId);
		dsUpdateTemporaryHelp.load();
	}
	else{
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
	}
	L5.QuickTips.init(); 
}

