function init() {
	query();
}

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	var organCodeValue = getParam("organAreaCode");
	if(organCodeValue == '' || organCodeValue == null || typeof(organCodeValue) == 'undefined'){
		organCodeValue = organAreaCode;
	}
	if(organCodeValue.indexOf("000")!=-1){
		organCodeValue = organCodeValue.substring(0, organCodeValue.indexOf("000"))+"%"
	}else {
		organCodeValue = organAreaCode+"%";
	}
	ds.setParameter("ORGAN_AREA_CODE@LIKE",organCodeValue);
	ds.setParameter("ORGAN_NAME@LIKE",getParam("name"));
	ds.load();
}

function insert() {
	winDs.removeAll();
	winDs.newRecord({'organAreaCode':organAreaCode,'organAreaName':organAreaName,'organStatus':'1',"organType":'01'});
	var win = L5.getCmp("supportOrganWin");
	win.show();
}

function update(){
	var grid = L5.getCmp("editGridPanel");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请选择一条记录!");
		return;
	}
	var organId=record.get('organId');
	var winDs = L5.DatasetMgr.lookup("winDs");
	winDs.setParameter("ORGAN_ID@=",organId);
	winDs.load();
	var win = L5.getCmp("supportOrganWin");
	win.show();
}
//删除
function remove(){
	var grid = L5.getCmp('editGridPanel');
	var sm = grid.getSelectionModel();
	var record=sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请选择一条记录！");
	}
	L5.MessageBox.confirm('确定', '你确定要删除吗？',function(sta){
		if(sta=="yes"){
			var command=new L5.Command("com.inspur.cams.drel.organ.cmd.SamSupportOrganCmd"); 
			record.set("organStatus","0");
			command.setParameter("record", record);
			command.execute("update");
			if (!command.error) {
				L5.Msg.alert("提示","删除成功！",function(){
					ds.remove(record);
				});		
			}else{
				L5.Msg.alert('提示',"删除时出现错误！"+command.error);
			}
		}
	});
}
//确定
function confirmWin(){
	var winDs = L5.DatasetMgr.lookup("winDs");
	var valid = winDs.isValidate();
	if(valid != true){
		L5.Msg.alert("提示",valid);
		return false;
	}	
	var command=new L5.Command("com.inspur.cams.drel.organ.cmd.SamSupportOrganCmd"); 
	command.setParameter("record", winDs.getCurrent());
	command.execute("save");	
	var win = L5.getCmp("supportOrganWin");
	win.setVisible(false);
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
			query();
		});
	}else{
		L5.Msg.alert("错误",command.error);
	}
}
//窗口关闭
function closeWin(){
	var win = L5.getCmp("supportOrganWin");
	win.setVisible(false);
}
// 弹出本地的行政区划
function func_ForDomicileSelect() {
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&organCode="
					+ organAreaCode + "&organName="
					+ escape(encodeURIComponent(organAreaName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("organAreaCode").value = list[0];
		document.getElementById("organAreaName").value = list[1];
	}
}