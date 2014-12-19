 
function init(){
	domicileDataset.setParameter("filterSql"," id like '"+organArea.substring(0,4)+"%000000'");
	domicileDataset.load();
	domicileDataset.on("load",function(ds){
		ds.filterBy(function(record, id){
			if(!("370100000000".indexOf(record.get('value'))>-1)){
				return record;
			}
		});
	});
	assistanceTypeDS.filterBy(function(record, id){
		if("01".indexOf(record.get('value'))>-1 || "02".indexOf(record.get('value'))>-1 || "03".indexOf(record.get('value'))>-1){
			return record;
		}
	});
	initLoad();
	
	L5.QuickTips.init();
}
function initLoad(){
	samSureyWfDataset.setParameter("CUR_ACTIVITY","ACT_APPLICATION");
	samSureyWfDataset.setParameter("CUR_STATUS","TODO");
	samSureyWfDataset.setParameter("CUR_ACTIVITY_ORGAN_TYPE",organType);
	samSureyWfDataset.setParameter("CUR_ACTIVITY_AREA",organArea);
	samSureyWfDataset.load();
}
function query(){
	samSureyWfDataset.setParameter("CUR_ACTIVITY","ACT_APPLICATION");
	samSureyWfDataset.setParameter("CUR_STATUS","TODO");
	samSureyWfDataset.setParameter("CUR_ACTIVITY_ORGAN_TYPE",organType);
	samSureyWfDataset.setParameter("CUR_ACTIVITY_AREA",organArea);
	
	var name = getParam("name");
	var idCard = getParam("sfzh");
	var domicileCode = getParam("domicileCodeQuery");
	var apanageCode = getParam("apanageCodeQuery");		
	var assistanceType = getParam("assistanceTypeQuery");
	var applyDateQ = getParam("applyDateQ");
	var applyDateZ = getParam("applyDateZ");
	
	samSureyWfDataset.setParameter("name", name);
	samSureyWfDataset.setParameter("idCard", idCard);
	samSureyWfDataset.setParameter("domicileCode", domicileCode);
	samSureyWfDataset.setParameter("apanageCode", apanageCode);	
	samSureyWfDataset.setParameter("assistanceType", assistanceType);
	samSureyWfDataset.setParameter("applyDateQ", applyDateQ);
	samSureyWfDataset.setParameter("applyDateZ", applyDateZ);
	samSureyWfDataset.load();	
}
var addOrEdit = "0";
var peopleId = "";
function addObject(){
	addOrEdit = "0";
	var win = L5.getCmp("addWin");
	win.show();
	$("applyOrganName").value = organName;
	winSureyWfDataset.removeAll();
	winSureyWfDataset.newRecord();
}
function editObject(){
	addOrEdit = "1";
	var gridPanel=L5.getCmp('gridPanel');
	var selected = gridPanel.getSelectionModel().getSelections();
	if(selected.length != 1){
		L5.Msg.alert("提示","请选择一条记录进行处理!");
		return false;
	}
	var win = L5.getCmp("addWin");
	win.show();
	var select = selected[0];
	winSureyWfDataset.removeAll();
	var record = winSureyWfDataset.newRecord();
	record.set("flowId",select.get("FLOW_ID"));
	record.set("surveyId",select.get("SURVEY_ID"));
	record.set("idCard",select.get("ID_CARD"));
	record.set("name",select.get("NAME"));
	record.set("domicileCode",select.get("DOMICILE_CODE"));
	record.set("apanageCode",select.get("APANAGE_CODE"));
	record.set("assistanceType",select.get("ASSISTANCE_TYPE"));
	$("applyOrganName").value = organName;
	peopleId = select.get("PEOPLE_ID");
}
function delObject(){
	var gridPanel=L5.getCmp('gridPanel');
	var selected = gridPanel.getSelectionModel().getSelections();
	if(selected.length < 1){
		L5.Msg.alert("提示","请选择一条记录进行处理!");
		return false;
	}
	L5.MessageBox.confirm('提示','你确定要删除吗？',function(sure){
		if(sure=="yes"){
			var command = new L5.Command("com.inspur.cams.drel.surey.assistance.cmd.SamAssistanceCmd");
			command.setParameter("records",selected);
			command.execute("deleteSurey");
			if (!command.error) {
				initLoad();	
			}else{
				L5.Msg.alert('提示',"删除时出现错误！"+command.error);
			}
		}
	});	
}
function sendObject(){
	var gridPanel=L5.getCmp('gridPanel');
	var selected = gridPanel.getSelectionModel().getSelections();
	if(selected.length < 1){
		L5.Msg.alert("提示","请选择一条记录进行处理!");
		return false;
	}
	var command = new L5.Command("com.inspur.cams.drel.surey.assistance.cmd.SamAssistanceCmd");
	command.setParameter("records",selected);
	command.setParameter("userName",userName);
	command.setParameter("userId",userId);
	command.execute("sendSurey");
	if (!command.error) {
		L5.Msg.alert("提示","提交成功！",function(){
			initLoad();	
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
//外部单位录入核对人员基本信息
function clickSave(){
	if(_$("assistanceTypeSelect")==null||_$("assistanceTypeSelect")==""){
		L5.Msg.alert("提示",'"核对项目"不能为空！');
		return;
	}
	if(addOrEdit == "0"){		
		var record = winSureyWfDataset.getCurrent();
		var command = new L5.Command("com.inspur.cams.drel.surey.assistance.cmd.SamAssistanceCmd");
		command.setParameter("record",record);
		command.setParameter("applyOrganName",organName);
		command.setParameter("organId",organId);
		command.setParameter("organArea",organArea);
		command.setParameter("organType",organType);
		command.execute("insertSurey");
		if (!command.error) {
			L5.Msg.alert("提示","保存成功！",function(){
				var win = L5.getCmp("addWin");
				win.setVisible(false);
				initLoad();
			});	
		}else{
			L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		}
	}
	if(addOrEdit == "1"){
		var record = winSureyWfDataset.getCurrent();
		var command = new L5.Command("com.inspur.cams.drel.surey.assistance.cmd.SamAssistanceCmd");
		command.setParameter("record",record);
		command.setParameter("peopleId",peopleId);
		command.execute("updateSurey");
		if (!command.error) {
			L5.Msg.alert("提示","修改成功！",function(){
				var win = L5.getCmp("addWin");
				win.setVisible(false);
				initLoad();
			});	
		}else{
			L5.Msg.alert('提示',"修改时出现错误！"+command.error);
		}
	}
}
function clickClose(){
	var win = L5.getCmp("addWin");
	win.setVisible(false);
}
function getParam(ElementId) {
    var value = document.getElementById(ElementId).value;
    if (value == "") value = undefined;
    return value;
}

//姓名输入中文校验
function checkCN(propertyName,ChineseName){
 var obj = document.getElementById(propertyName);
 if (obj==null){
  return true;
 }
 var str = obj.value;
 if(str.length==0||__isCN(str)){
  return true;
 }else{
  alert("属性‘"+ ChineseName+"’包含非中文，请重新输入！");


  obj.value="";
  obj.select();
  return false;
 }
  return true;
 }
 
 /*
	 * 函数名称：function  __isCN()
	 * 函数功能：判断是否含有中文及全角？之外的其他字符
	 * 作    者：
	 * 时    间：
	 */
 function __isCN(s){
		var i=s.indexOf(".");
		if(i>-1){
			s=s.replace(".","");
		}
		var re = /^[？\u4E00-\u9FA5]+$/;
		return re.test(s);
 }