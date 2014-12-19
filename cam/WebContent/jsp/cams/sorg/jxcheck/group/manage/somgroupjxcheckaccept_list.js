function init() {
	ds.setParameter("FILL_PEOPLE_AREA@LIKE",areaCode+"%");
	ds.setParameter("SORG_TYPE@=","S");
	ds.setParameter("STATUS@=","3");
	ds.load();
	noCheckDs.setParameter("areaCode",areaCode+"%");
	noCheckDs.setParameter("sorgType","S");
	noCheckDs.setParameter("checkYear",year);
	noCheckDs.load();
}
function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	//if(value=="") value=undefined;
	return value;
}
function query(){
	ds.setParameter("FILL_PEOPLE_AREA@LIKE",areaCode+"%");
	ds.setParameter("SORG_TYPE@=","S");
	ds.setParameter("STATUS@=","3");
	ds.setParameter("CN_NAME@LIKE","%"+getParam("cnName")+"%");		
	ds.setParameter("SORG_CODE@=",getParam("sorgCode"));		
	ds.load();
}

function detail(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	var data = new L5.Map();
	data.put("method","DETAIL");
	data.put("taskCode",selected[0].get('taskCode'));
	var url='jsp/cams/sorg/jxcheck/group/manage/somgroupjxcheckacceptDetail.jsp';
	var text = '年检明细';
	L5.forward(url,text,data);
}

//置为校对不通过状态
function notpass(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	var command = new L5.Command("com.inspur.cams.sorg.jxcheck.manage.SomJxCheckManageCommand");
	command.setParameter("taskCode", selected[0].get('taskCode'));
	command.setParameter("status", "4");
	command.execute("updateStatus");
	if (!command.error) {
		L5.Msg.alert("提示","校对不通过成功！",function(){
			init();
		});		
	}else{
		L5.Msg.alert('提示',"校对不通过时出现错误！"+command.error);
	}
}

function query2(){
	noCheckDs.setParameter("areaCode",areaCode+"%");
	noCheckDs.setParameter("sorgType","S");
	noCheckDs.setParameter("checkYear",year);
	noCheckDs.setParameter("userName",document.getElementById("userName").value);
	noCheckDs.load();
}
function showWin(){
	var editGrid=L5.getCmp('editGridPanel2');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	var win=L5.getCmp("forCheck");
	win.show();
	document.getElementById("fillPeopleName").innerHTML = selected[0].get("USER_NAME");
	var command = new L5.Command("com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckCommand");
	command.setParameter("checkYear", ""+(parseInt(year)-1));
	command.setParameter("fillPeopleId", selected[0].get("USER_ID"));
	command.execute("queryLastYearCheckResult");
	var value = command.getReturn("lastYearCheckResult");
	var ary = value.split(";");
	document.getElementById("lastYearCheckResult").innerHTML=ary[0];
	if(ary.length==2){
		document.getElementById("lastYearCheckResultDesc").value=ary[1];
	}
}
function closeWin(){
	var win=L5.getCmp("forCheck");
	win.hide();
}
function saveResult(){
	var editGrid=L5.getCmp('editGridPanel2');
	var selected=editGrid.getSelectionModel().getSelections();
	var command = new L5.Command("com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckCommand");
	command.setParameter("cnName", selected[0].get("USER_NAME"));
	command.setParameter("sorgType", "S");
	command.setParameter("checkYear", year);
	command.setParameter("checkResult", document.getElementById("checkResult").value);
	command.setParameter("checkResultDesc", document.getElementById("checkResultDesc").value);
	command.setParameter("fillPeopleId", selected[0].get("USER_ID"));
	command.setParameter("fillPeopleName", selected[0].get("USER_NAME"));
	command.setParameter("fillPeopleArea", selected[0].get("AREA_CODE"));
	command.execute("insertNoCheck");
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
			closeWin();
			init();
		});		
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}


