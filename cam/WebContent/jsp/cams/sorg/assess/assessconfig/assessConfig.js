//判断是增加还是修改方法
var flag="";
//定义根节点结构
var rootdata = {
	configId:'0',
	assessContent:typeDesc,
	assessType:type,
	assessScore:'',
	upId:'0',
	fontSize:'',
	fontStyle:'',
	seq:'',
	assessScore:'',
	ifMakeScore:'',
	ifValid:'1',
	configLevel:'0',
	recordType : 'SomAssessConfigRecord'
};
//事件处理：获得 TreebaseParams的值
function getParent(rec){
	var parentObjId = rec.get('configId');
	return parentObjId?parentObjId:"0";
}

function getType(rec){
	return type;
}
function getSomAssessConfigdisabled(rec){
	return rec.get('configId')=='';
}
//定义一个dataset
var dataset = new L5.model.Dataset({
	id : "SomAssessConfigDataset"
});
//事件处理：将节点信息添加到table中
function selectedSomAssessConfig(record){
	SomAssessConfigDataset.removeAll();
	var data=L5.getCmp("SomAssessConfigtree").getCurrentRecord().data;
	var id=data.configId;
	SomAssessConfigDataset.add([new SomAssessConfigDataset.recordType(data,id)]);
	L5.getCmp("detailPanel").show();
	if(record.get("configId")==rootdata.configId){
		L5.getCmp("detailPanel").hide();
	}
	L5.getCmp("updatePanel").hide();
}
//添加
function addSomAssessConfig(menuitem){
	L5.getCmp("detailPanel").hide();
	L5.getCmp("updatePanel").show();
	SomAssessConfigDataset.removeAll();
	var record=SomAssessConfigDataset.newRecord();
	var parentRecord=L5.getCmp("SomAssessConfigtree").getCurrentRecord();
	record.set("assessType",parentRecord.get("assessType"));
	record.set("ifMakeScore","0");
	record.set("ifValid","1");
	record.set("upId",parentRecord.get("configId"));
	var parentConfigLevel = parentRecord.get("configLevel");
	record.set("configLevel",parseInt(parentConfigLevel)+1);
	flag="insert";
}
//删除
function delSomAssessConfig(menuitem){
	if(menuitem==null){
		L5.Msg.alert('提示',"请选择要删除的节点!");
		return false;
	}
	var record = menuitem.parentMenu.record;
	if(record.get("configLevel") < 0){
		L5.Msg.alert('提示',"选择的节点不能删除!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的节点吗?',function(state){
		if(state=="yes"){
			var prec = record.parentRecord;
			if(prec){
				var delId=record.get("configId");
				var command = new L5.Command("com.inspur.cams.sorg.assess.assessconfig.cmd.SomAssessConfigCommand");
				command.setParameter("delId",delId);
				command.execute("delete");
				prec.remove(record);	
			}
		}else{
			return false;
		}
	});
}
//保存
function save(){
	var SomAssessConfigValidate = SomAssessConfigDataset.isValidate();
	if(SomAssessConfigValidate != true){
		L5.Msg.alert("提示",SomAssessConfigValidate);
		return false;
	}	
	var parentRecord=L5.getCmp("SomAssessConfigtree").getCurrentRecord();
	var parentId=parentRecord.get("configId");
	var record=SomAssessConfigDataset.getCurrent();
	if(flag=="update"){
		var childId=record.get("configId");
		parentId=record.get("UP_ID");
	}
	var command = new L5.Command("com.inspur.cams.sorg.assess.assessconfig.cmd.SomAssessConfigCommand");
	command.setParameter("record", record);
	command.setParameter("parentId",parentId);
	command.setParameter("childId",childId);
	if(flag=="insert"){
		command.execute("insert");
		var configId = command.getReturn("configId");
	}else if(flag=="update"){
		command.execute("update");
	}
	if(!command.error){
		L5.Msg.alert("提示","保存成功!");	
		if(flag=="insert"){
			var data = {	
		   configId:configId
		   ,
			configLevel:record.get("configLevel")
		   ,
			assessType:record.get("assessType")
		   ,
			seq:record.get("seq")
		   ,
			assessContent:record.get("assessContent")
		   ,
			assessScore:record.get("assessScore")
		   ,
			upId:record.get("upId")
		   ,
			fontSize:record.get("fontSize")
		   ,
			fontStyle:record.get("fontStyle")
		   ,
			ifMakeScore:record.get("ifMakeScore")
		   ,
			ifValid:record.get("ifValid")
			};
			var rec = new L5.tree.TreeRecord.recordTypes["SomAssessConfigRecord"](data,data.configId);
			parentRecord.insert(rec);
		}else if(flag=="update"){
			var updaterecord=L5.getCmp("somAssessConfigtree").getCurrentNode();
			updaterecord.setText(record.get("assessContent"));
		}
		L5.getCmp("detailPanel").show();
		L5.getCmp("updatePanel").hide();
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
	//保存的时候重新查询树的字典表，将刚保存的项给读出来
	DicSomAssessConfigDataSet.reload();
}
//修改
function updateSomAssessConfig(menuitem){
	SomAssessConfigDataset.removeAll();
	var data=L5.getCmp("SomAssessConfigtree").getCurrentRecord().data;
	var id=data.configId;
	SomAssessConfigDataset.add([new SomAssessConfigDataset.recordType(data,id)]);
	if(id==rootdata.configId){
		L5.getCmp("detailPanel").hide();
		L5.getCmp("updatePanel").hide();
	}else{
		L5.getCmp("detailPanel").hide();
		L5.getCmp("updatePanel").show();
	}
	flag="update";
}
//图标路径
function getIcon(rec){
	var figpath=L5.webPath+"/skins/images";
	var leve=rec.get('configLevel');
	var value=parseInt(leve);
	
	switch(value){
		case 0: //根节点
			file =figpath+"/l5/root.gif";
			break;
		case 1: //二级节点
			file =figpath+"/l5/root.gif";
			break;
		case 2: // 三级节点
			file =figpath+"/l5/module.gif";
			break;
		case 3: // 四级节点
			file =figpath+ "/l5/other.gif";
			break;
		case 4: // 五级节点
			file =figpath+ "/l5/function.gif";
			break;
		default: // 
			file = figpath+"/l5/function.gif";
	}
	
	//file = figpath+"/l5/function.gif";
	return file;
}