function init() {
   if(method==null||method==""){
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
		}
	else if (method=="INSERT"){
		ds.newRecord();
	}
	else if (method=="DETAIL"){
	    ds.baseParams["STANDARDS_COUNTIES@="]=standardsCounties;
		ds.baseParams["START_DATE@="]=startDate;
		ds.baseParams["END_DATE@="]=endDate;
		ds.baseParams["TYPE@="]=4;
		ds.load();
		
	}
	else{
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
	}
	
};

function back()
 {	 	
	history.go(-1);
 }



