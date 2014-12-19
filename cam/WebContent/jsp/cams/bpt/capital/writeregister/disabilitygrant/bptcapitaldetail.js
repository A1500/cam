function init() {
	if(method==null||method==""){
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
		}
	else if (method=="INSERT"){
	}
	else if (method=="DETAIL"){
	    ds.setParameter("REGISTER_ID",registerId);
	    //ds.setParameter("respectiveYears",respectiveYears);	
		ds.load();
	}
	else{
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
	}
};
