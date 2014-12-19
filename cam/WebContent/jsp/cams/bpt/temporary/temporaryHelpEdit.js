function init() {
	if (method==null||method==""){
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
		}
	else if (method=="INSERT"){
		ds.newRecord();
	}
	else if (method=="UPDATE"){
		//ds.setParameter("peopleId",peopleId);
		//ds.load();
		ds.setParameter("applyId",applyId);
		ds.load();
	}else if (method=="ADD"){
		ds.setParameter("peopleId",peopleId);
		ds.load();
	}else if(method =="DETAIL"){
	    dsUpdateTemporaryHelp.setParameter("applyId",applyId);
		dsUpdateTemporaryHelp.load();
	 
	}
	else{
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
	}
	//ds.on("load",setDefultValue);
	L5.QuickTips.init(); 
}
function save(){

	var dsUpdateTemporaryHelp  = L5.DatasetMgr.lookup("ds");
	var record = dsUpdateTemporaryHelp.getCurrent();
	var helpType = record.get("helpType");
	if(helpType==''){
		L5.Msg.alert("提示","救助类别不能为空！");
		return false;
	}
	var applySubject = record.get("applySubject");
	if(applySubject==''){
		L5.Msg.alert("提示","申请事由不能为空！");
		return false;
	}
    var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptTemporaryHelpCommand"); 
	command.setParameter("records",dsUpdateTemporaryHelp.getCurrent());
	command.execute("update");	
	if (!command.error) {
		L5.Msg.alert('提示',"保存成功!");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function print(){
 	var url="../../comm/print/jspcommonprint.jsp?";
	var text='优抚对象临时救助审批表';
	var width = 1024;
	var height = 768;
    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
 }
 
/*function	setDefultValue(ds){
		
			var attnName = ds.get("attnName");
			var checkApproveDate = ds.get("checkApproveDate");
			var aduitApproveDate = ds.get("aduitApproveDate");
			var secretary = ds.get("secretary");
			if(attnName == null || attnName == "") {
				ds.set("attnName",currentUserName);
			}
			if(checkApproveDate == null || checkApproveDate == "") {
				ds.set("checkApproveDate",getCurDate());
			}
			if(secretary == null || secretary == "") {
				ds.set("secretary",currentUserName);
			}
			if(aduitApproveDate == null || aduitApproveDate == "") {
				ds.set("aduitApproveDate",getCurDate());
			}
			
		}*/
	//获得当前日期 
function getCurDate(){
	var date=new Date();
	var year=""+date.getFullYear();
	var month=date.getMonth()+1;
	if(month<10){month="0"+month;}
	var day = date.getDate();
	if(day<10){day = "0"+day;}
	return year+"-"+month+"-"+day;
}	

