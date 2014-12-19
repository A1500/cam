//判断是增加还是修改方法
var flag="";
//定义根节点结构
var rootdata = {
	catalogCode:'0',
	catalogName:'档案目录名管理',
	sorgType:'',
	applyType:'',
	upCatalogCode:'',
	catalogOrder:'1',
	ifValid:'1',
	catalogLevel:'0',
	archiveStage:'',
	recordType : 'somCatalogRecord'
};
//事件处理：获得 TreebaseParams的值
function getParent(rec){
	var parentObjId = rec.get('catalogCode');
	return parentObjId?parentObjId:"1";
}
function getSomCatalogdisabled(rec){
	return rec.get('catalogCode')=='';
}
//定义一个dataset
var dataset = new L5.model.Dataset({
	id : "somCatalogDataset"
});
//事件处理：将节点信息添加到table中
function selectedSomCatalog(record){
	somCatalogDataset.removeAll();
	var data=L5.getCmp("somCatalogtree").getCurrentRecord().copy().data;
	var id=data.catalogCode;
	somCatalogDataset.add([new somCatalogDataset.recordType(data,id)]);
	L5.getCmp("detailPanel").show();
	if(record.get("catalogCode")==rootdata.catalogCode){
		L5.getCmp("detailPanel").hide();
	}
	L5.getCmp("updatePanel").hide();
}
//添加
function addSomCatalog(menuitem){
	var parentRecord=L5.getCmp("somCatalogtree").getCurrentRecord();
	if(parentRecord.get("catalogLevel") != 4){
		L5.Msg.alert('提示',"选择的节点不能增加下级节点!");
		return;
	}
	L5.getCmp("detailPanel").hide();
	L5.getCmp("updatePanel").show();
	somCatalogDataset.removeAll();
	somCatalogDataset.setParameter("CATALOG_CODE@=",parentRecord.get("catalogCode"));
	var mgr=somCatalogDataset.load();
	flag="insert";
}
//删除
function delSomCatalog(menuitem){
	if(menuitem==null){
		L5.Msg.alert('提示',"请选择要删除的节点!");
		return false;
	}
	var record = menuitem.parentMenu.record;
	if(record.get("catalogLevel") < 5){
		L5.Msg.alert('提示',"选择的节点不能删除!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的节点吗?',function(state){
		if(state=="yes"){
			var prec = record.parentRecord;
			if(prec){
				var delId=record.get("catalogCode");
				var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomCatalogCmd");
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
	var parentRecord=L5.getCmp("somCatalogtree").getCurrentRecord();
	var parentId=parentRecord.get("catalogCode");
	
	var record=somCatalogDataset.getCurrent();
	if(flag=="update"){
		var childId=record.get("catalogCode");
		parentId=record.get("UP_CATALOG_CODE");
	}
	var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomCatalogCmd");
	command.setParameter("somCatalogRecord", record);
	command.setParameter("parentId",parentId);
	command.setParameter("childId",childId);
	if(flag=="insert"){
		command.execute("insert");
		var childId = command.getReturn("childId");
	}else if(flag=="update"){
		command.execute("update");
	}
	if(!command.error){
		L5.Msg.alert("提示","保存成功!");	
		if(flag=="insert"){
			var data = {	
				catalogCode:childId,
				catalogName:record.get("catalogName"),
				sorgType:record.get("sorgType"),
				applyType:record.get("applyType"),
				upCatalogCode:record.get("upCatalogCode"),
				catalogOrder:record.get("catalogOrder"),
				ifValid:record.get("ifValid"),
				catalogLevel:(record.get("catalogLevel")+1),
				archiveStage:(record.get("archiveStage"))
			};
			var rec = new L5.tree.TreeRecord.recordTypes["somCatalogRecord"](data,data.catalogCode);
			parentRecord.insert(rec);
		}else if(flag=="update"){
			var updaterecord=L5.getCmp("somCatalogtree").getCurrentNode();
			updaterecord.setText(record.get("catalogName"));
		}
		L5.getCmp("detailPanel").show();
		L5.getCmp("updatePanel").hide();
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
//修改
function updateSomCatalog(menuitem){
	somCatalogDataset.removeAll();
	var data=L5.getCmp("somCatalogtree").getCurrentRecord().data;
	var id=data.catalogCode;
	var level = data.catalogLevel;
	if(level < 5){
		L5.Msg.alert('提示',"选择的节点不能修改!");
		return false;
	}
	somCatalogDataset.add([new somCatalogDataset.recordType(data,id)]);
	if(id==rootdata.catalogCode){
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
	var leve=rec.get('catalogLevel');
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
			file =figpath+ "/l5/other.gif";
			break;
		default: // 
			file = figpath+"/l5/function.gif";
	}
	return file;
}