
function init() {

//	L5.QuickTips.init();
	L5.get("parmsValueText").on("keypress", keyPressForHelp);
	query();


};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	var dataSet=L5.DatasetMgr.lookup("ds");
	dataSet.setParameter("PUB_ORGAN_PARMS.ORGAN_ID@=",organId);
	dataSet.load();

}

function insert() {
	var record =ds.newRecord();
	record.set("organId",organId);
	ds.moveLast();

}

function del(){
	var record = ds.getCurrent();
	if(record){
	L5.MessageBox.confirm(RES_PROMOT, RES_DELETE,
		function(sta){
			if(sta=="yes"){ 
				if(record.state != "1"){
					var command = new L5.Command("org.loushang.bsp.organization.cmd.PubOrganParmsCommand");
					command.setParameter("record",record);
					command.execute("deleteParam");	
					if(!command.error){
						ds.remove(record);
						L5.Msg.alert(RES_PROMOT,"删除成功");
						return;
					}else{
						L5.Msg.alert(RES_PROMOT,command.error);
						return;
					}
				}else{
					ds.remove(record);	
				}
			}
			else return ;
		}
	);
	}else{
		L5.Msg.alert("提示","没有选中记录");
	}
}
function save() {
	var records = ds.getAllChangedRecords();
	if(records.length<1){
		L5.Msg.alert(RES_PROMOT,RES_NOCHANGE);
		return false;
	}
	var validate=true;
	for(var i=0;i<records.length;i++){
		var record=records[i];
	  	var parmsName=record.get("parmsName");
	  	if(parmsName==undefined||parmsName==""){
			L5.Msg.alert(RES_PROMOT,"参数名称不能为空");
			return false;
		}
		var parmsValue=record.get("parmsValue");
	  	if(parmsValue==undefined||parmsValue==""){
			L5.Msg.alert(RES_PROMOT,"参数值不能为空");
			return false;
		}
	}

	var command = new L5.Command("org.loushang.bsp.organization.cmd.PubOrganParmsCommand");
	command.setParameter("records", records);
	command.execute("save");
	if (!command.error) {
		ds.commitChanges();
		L5.Msg.alert(RES_PROMOT,RES_SAVE);
	}else{
		L5.Msg.alert(RES_PROMOT,command.error);
	}
}
function reset() {

	ds.rejectChanges();
}



function parmNameChangedByValue(parmNameValue){

	//先取得参数名称的值
    var parmTypeName="";
    var dataSource="2";
	parmTypeName=parmNameValue;
	var parmsTypeDs=L5.DatasetMgr.lookup("parmsTypeDs");
	var tableName="";
	var selCol="";
	var dispCol="";
	var enumName="";
	var isUseWhere="";
	var whereCondition="0";
	parmsTypeDs.each(function(record){
		if(record.get("value")==parmTypeName){
			parmTypeName=record.get("value");
			dataSource=record.get("dataSource");
			tableName=record.get("sourceTableName");
			selCol=record.get("selCol");
			dispCol=record.get("dispCol");
			enumName=record.get("enumName");
			isUseWhere=record.get("isUseWhere");
			whereCondition=record.get("whereCondition");
			if(whereCondition==null) whereCondition="";
			return false;
		}
	});

	if(selCol=="" || selCol==null) return;
	var parmsHelpDs=L5.DatasetMgr.lookup("parmsHelpDs");
	parmsHelpDs.setParameter("parmTypeName",parmTypeName);
	parmsHelpDs.setParameter("dataSource",dataSource);
	parmsHelpDs.setParameter("tablename",tableName);
	parmsHelpDs.setParameter("selcol",selCol);
	parmsHelpDs.setParameter("dispcol",dispCol);
	parmsHelpDs.setParameter("enumName",enumName);
	parmsHelpDs.setParameter("isUseWhere",isUseWhere);
	parmsHelpDs.setParameter("whereCondition",whereCondition);
	parmsHelpDs.load();
}

function parmNameChanged(){
//	var parmNameValue="";
//	var parmNameControl = document.getElementById("parmsName");
//	if(parmNameControl!=null){
//		parmNameValue=parmNameControl.value;
//	}
//
//
//	parmNameChangedByValue(parmNameValue);
}
var RowSelect=function(sm,rowIndex,record){
//	var parmNameValue=record.data["parmsName"];
//	if(parmNameValue==null) return;
//	parmNameChangedByValue(parmNameValue);
}

function closed(){
	window.close();
}

function selectOrganParms(){
	var choiceBox="radiobox";
	var revalue=window.showModalDialog("selectparms.jsp?choiceBox="+choiceBox,"","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;dialogLeft:"+(window.screen.width-300)/2+";dialogTop:"+(window.screen.height-400)/2);
    if(revalue){
		var list = revalue.split(";");
	  	if (revalue == null) {
	  		return;
	  	}else{
	  		var mgr=ds.getCurrent();
	  		 mgr.set("parmsName",list[0]);
	  	}
  	}
}
