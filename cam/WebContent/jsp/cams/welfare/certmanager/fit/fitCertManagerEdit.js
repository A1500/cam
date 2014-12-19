function init() {
	if (method==null||method==""){
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
		}
	else if (method=="INSERT"){
		ds.newRecord({"taskCode":taskCode,"companyType":'1'});
		document.getElementById('signOrgan').value="山东省民政厅";
		document.getElementById('signDate').value=getCurDate();
		document.getElementById('startDate').value=getCurDate();
		document.getElementById('issuerPeople').value=issuerPeople;
		setEndDate(getCurDate());
	}
	else if (method=="UPDATE"){
		ds.baseParams["TASK_CODE@="]=taskCode;
		ds.load(true);
		if(ds.getAt(0).get("signOrgan")==""){
			document.getElementById('signOrgan').value="山东省民政厅";
 		}
 		if(ds.getAt(0).get("signDate")==""){
			document.getElementById('signDate').value=getCurDate();
 		}
 		if(ds.getAt(0).get("startDate")==""){
			document.getElementById('startDate').value=getCurDate();
			setEndDate(getCurDate());
 		}
 		if(ds.getAt(0).get("issuerPeople")==""){
			document.getElementById('issuerPeople').value=issuerPeople;
 		}
	}
	else{
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
	}
	L5.QuickTips.init(); 
}

function save(){
	var record = ds.getCurrent();
	var valid = ds.isValidate();
	if(valid != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+valid);
		return false;
	}
	record.set("startDate",document.getElementById('startDate').value);
	record.set("endDate",document.getElementById('endDate').value);
	record.set("signOrgan",document.getElementById('signOrgan').value);
	record.set("issuerPeople",document.getElementById('issuerPeople').value);
	record.set("signDate",document.getElementById('signDate').value);
	var command = new L5.Command("com.inspur.cams.welfare.base.cmd.WealCertCommand");
	command.setParameter("record", record);
	if(method=="INSERT"){
		command.execute("insert");
	}else if(method=="UPDATE"){
		command.execute("update");
	}
	if (!command.error) {
		//L5.Msg.alert('提示',"保存成功！");
		method="UPDATE";
		if(record.get("certStatus")=="2"){
			L5.Msg.alert('提示',"保存成功！");
		}else{
			L5.MessageBox.confirm('确定', '保存成功，是否打印证书？',function(sta){
				if(sta=="yes"){
					forRePrint("fit");
				}else{
					window.history.go(-1);
				}
			});
		}
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
 function back()
 {	 	var url='jsp/cams/welfare/certmanager/fit/fitCertManagerList.jsp';
		var text = 'WEAL_CERT';
		L5.forward(url,text);	 
 }
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
	// 根据开始日期与任期回写结束日期
	function setEndDate(obj){
		var date=new   Date(obj.substring(0, 4),   obj.substring(5, 7)-1,   obj.substring(8, 10));
		date.setYear(date.getYear()+3);
		date.setDate(date.getDate()-1);
		document.getElementById('endDate').value=date;
	}
//************************************弹出窗口方法开始
//点击企业名称弹出企业列表
function queryFitList(){
	var win=L5.getCmp('fitWin');
	win.show();
	dsWin.setParameter("WEAL_FIT_STATUS.STATUS@=","1");//加载状态正常
	dsWin.load();
}
function getParam(ElementId){
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	dsWin.setParameter("WEAL_FIT_STATUS.STATUS@=","1");//加载状态正常
	dsWin.setParameter("WEAL_FIT_STATUS.SERIAL_NUM@=",getParam("serialNumQuery"));		
	dsWin.setParameter("WEAL_FIT_STATUS.COMPANY_NAME@=",getParam("companyNameQuery"));		
	dsWin.setParameter("WEAL_FIT_STATUS.LEGAL_PEOPLE@=",getParam("legalPeopleQuery"));
	dsWin.load();
}
function confirmWin(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条企业记录进行证书补录!");
		return false;
	}else{
		document.getElementById("companyName").value=selected[0].get('companyName');
		document.getElementById("serialNum").value=selected[0].get('serialNum');
		document.getElementById("organType").value=selected[0].get('economicNatureCode');
		document.getElementById("legalPeople").value=selected[0].get('legalPeople');
		document.getElementById("approveDate").value=selected[0].get('cognizanceDate');
		document.getElementById("businessScope").value=selected[0].get('businessScope');
		document.getElementById("companyAddress").value=selected[0].get('address');
		ds.set("companyName",selected[0].get('companyName'));
		ds.set("serialNum",selected[0].get('serialNum'));
		ds.set("organType",selected[0].get('economicNatureCode'));
		ds.set("legalPeople",selected[0].get('legalPeople'));
		ds.set("approveDate",selected[0].get('cognizanceDate'));
		ds.set("businessScope",selected[0].get('businessScope'));
		ds.set("companyAddress",selected[0].get('address'));
		closeWin();
	}
}
function closeWin(){
	var win = L5.getCmp("fitWin");
	win.hide();
}