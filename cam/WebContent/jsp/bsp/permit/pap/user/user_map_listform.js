function init() {
	//var ds =L5.DatasetMgr.lookup("ds");
	ds.load();
	//L5.QuickTips.init();
}

//设置单元格的可编辑状态
function setEditable(){
	var ds =L5.DatasetMgr.lookup("ds");
	//var userId = ds.getCurrent().get("userId");
	//var typeId= ds.getCurrent().get("typeId");
	var state = ds.getCurrent().state;
	if(state==L5.model.Record.STATE_NEW)
	{
			return true;
	}
	else
		    return false;
}
//新增一条记录
function insert() {
	var record=ds.newRecord();
	ds.moveLast();
}
var rootdata = {
	id : 'rootId',
	struId:'rootId',
	organId:'',
	struType:'00',
	parentId:'-1',
	struLevel:'',
	struPath:'0',
	struOrder:'',
	isLeaf:'',
	inUse:'',
	organName:'用户树',
	shortName:'用户树',
	organType:'0',
	organTypeName:'单位',
	struTypeName:'人力资源',
	recordType : 'struRecord'
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
    window.command=new L5.Command("org.loushang.bsp.permit.pap.user.cmd.UserMapQueryCmd");
    var queryuserId=getParam("queryuserId");
    var querymapValue=getParam("querymapValue");
    if(queryuserId!=undefined&&queryuserId!=""&&queryuserId.indexOf("'")!=-1){
    	L5.MessageBox.alert("提示",'查询条件中不能包含单引号字符');
        return;
    }
    if(querymapValue!=undefined&&querymapValue!=""){
    	if(querymapValue.indexOf("'")!=-1){
    		L5.MessageBox.alert("提示",'查询条件中不能包含单引号字符');
            return;	
    	}
    	if(querymapValue.length>50){
    		L5.MessageBox.alert("提示",'用户映射值不能超过50个字母或者汉字');
            return;	
    	}
    }
	ds.setParameter("PUB_USER_MAP.USER_ID@like",queryuserId);
	ds.setParameter("PUB_USER_MAP.MAP_VALUE@like",querymapValue);
	ds.setParameter("PUB_USER_MAP.TYPE_ID@like",getParam("querytypeId"));
	ds.load();
}
function del(){
	var list="";
	var userGrid=L5.getCmp('editGridPanel');
	//判断是否选择了要删除的记录
	var selected = userGrid.getSelectionModel().getSelections();
	//alert(selected.length);
	if(selected.length<1){
		L5.Msg.alert(messTypePrompt,deletePleaseSelectData);
		return false;
	}else
	{
		//下面是一个提示框，如果用户点击是，那么就执行删除，否则不执行。
		L5.MessageBox.confirm(messType, deleteSelectDataMess,
			function(sta){
				if(sta=="yes"){
					for(var i=0;i<selected.length;i++){
						var record =selected[i];
						var recordState=record.state;
						//if(recordState=="1"){
							ds.remove(record);
						//}else{
						if(recordState!="1"){
							list=list+record.get("userId")+","+record.get("typeId")+";";
						}
					}
					var ids=list.split(";");
					var command = new L5.Command("org.loushang.bsp.permit.pap.user.cmd.UserMapCmd");
					command.setParameter("delIds",ids);
					command.execute("delete");
					//init();
					if(!command.error){
	   					L5.Msg.alert('提示','删除成功!');
	   					//for(var i=0;i<selected.length;i++){
	   						//var record =selected[i];
							//var recordState=record.state;
							//if(recordState!="1"){
							//	ds.remove(record);
						//	}
	   					//}
	   				}else{
	   					L5.Msg.alert('提示','删除成功!');
	   				}
				} else {
				   return;
				   }
				   });
	}
}
function save() {
	var records = ds.getAllChangedRecords();
	if(records.length<1){
		L5.Msg.alert(messTypePrompt,saveNoDataMess);
		return false;
	}
	var isValidate = ds.isValidate();
	if(isValidate != true){
		L5.Msg.alert(messTypePrompt,isValidate);
		return false;
	}
	for(var i=0; i<records.length; i++){
		if(records[i].get("mapValue").length>50){
			L5.Msg.alert("提示","用户映射值不能超过50个字母或者汉字");
		    return false;
		}
			for(var j=i+1;j<records.length;j++){
				if(records[i].get("userId")==records[j].get("userId")&&records[i].get("typeId")==records[j].get("typeId"))
					 {
				    	L5.Msg.alert("提示","存在相同的用户映射，请检查！");
					    return false;
					  }
				 }
		     }
	var command = new L5.Command("org.loushang.bsp.permit.pap.user.cmd.UserMapCmd");
	command.setParameter("records", records);
	command.execute("save");
	if (!command.error) {
		ds.commitChanges();
		L5.Msg.alert(messTypePrompt,"数据保存成功");
	}else{
		L5.Msg.alert(messTypePrompt,command.error);
	}
}
function reset() {
	ds.rejectChanges();
}

//点击下拉框弹出窗口
function showUserTree(){
  var userId=window.showModalDialog("selectuser.jsp","","dialogHeight:500px;dialogWidth:400px;resizable:no;scroll:no;status:no");
  if(userId!==undefined){
  	ds.set("userId",userId);
  	L5.getCmp("grid_itemId").fireEvent("blur");
  }
 }

//渲染“允许使用的下级组织类型”
function render_targetRef(values) {
	var texts=new Array();
	if (!(values instanceof Array)) {
		if(!values||values=="") {
			return;
		}
		values = values.split(',');
	}
	//根据id显示名称
	for (var i=0; i<values.length; i++) {
		var record=organTypeDs.getById(values[i]);
		if(record){
			texts.push(record.get("text"));
		}
	}
	return texts.join(",");
}


function struLoaderTrigger(record){
	var rcdTp = record.recordType;
	if(rcdTp == "struRecord"){
		var organType = record.get('organType');
		var type = parseInt(organType.substring(0, 1));
		if(type == 0 || type == 1 || type == 2){
			return true;
		}
	}
	return false;
}
function userLoaderTrigger(record){
	var rcdTp = record.recordType;
	if(rcdTp == "struRecord"){
		return true;
	}
	return false;
}
function getNodeType(record){
	if(record.isRoot)	return "isRoot";
		return record.recordType;
}
function getOrganId(rec){
	var organId = rec.get('organId');
	return organId?organId:"rootId";
}
function getStruParent(rec){
	var parentId = rec.get('parentId');

	return parentId;
}
function getStruId(rec){
	var struId=rec.get('struId');
	return struId?struId:"rootId";
}
function getStruType(rec){
	var struType=rec.get('struType');
	return struType?struType:"00";
}
function getStrudisabled(rec){
	return false;
}
function getStruTypeId(rec){
	return struTypeId?struTypeId:"00";
}
function getIcon(record){
	var figpath=L5.webPath + "/skins/images";
	var file=figpath + "/l5/bsp_department&corporation.gif";
	if(!record){
		return file;
	}

	var rcdTp = record.recordType;
	if(rcdTp == "struRecord"){
		var organType = record.get('organType');
		var type = organType.substring(0, 1);
		var value = parseInt(type);
		switch(value){
			case 0: //
				file = figpath + "/l5/root.gif";
				break;
			case 1: //
				file = figpath +"/l5/bsp_department&corporation.gif";
				break;
			case 2: //
				file = figpath + "/l5/bsp_department&corporation.gif";
				break;
			default:
				file = figpath + "/other_img.gif";
		}
		return file;
	}
	if(rcdTp == "userRecord"){
		file = figpath + "/l5/bsp_employee.gif";
	}
	return file;
}
/*
* 重置查询
*/
function resetSearch(){
	document.getElementById("querymapValue").value="";
	document.getElementById("queryuserId").value="";
	document.getElementById("querytypeId").value="";
}