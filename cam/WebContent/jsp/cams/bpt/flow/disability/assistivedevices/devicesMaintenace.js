
function init(){
	var editpanel = L5.getCmp("editpanel");
	editpanel.hide();
};

//判断是增加还是修改方法
var flag="";
/**
 * 定义根节点结构
 */ 
var rootdata = {
   applyApparatusId:'00000',
   apparatusName:"假肢矫形器械",
   ups:'',
   leve:'0',
   recordType : 'bptdevicesRecord'
};

/**
* 得到选框的类型。
*/
/*function getChecked(record){
	
	return 0;
}*/
/**
 * 事件处理：获得 TreebaseParams的值
 */
function getParent(rec){
	var parentObjId = rec.get('applyApparatusId');
	return parentObjId?parentObjId:"00000";
}



//是否级联选中节点的下级，false为不选中下级
function isCheckedSub(node,parentNode){

	return false;
}

function getIsLeaf(rec){
	var leaf1=rec.get('leve');
	if(leaf1=='2'){
		return true;
	}else{
		return false;
	}
}

function getChoiceBox(record){
      return  '';
}

//根据类型值获取图标路径
function getIcon(rec){
	var figpath=L5.webPath+"/skins/images";
	var leve=rec.get('leve');
	var value=parseInt(leve);
	switch(value){
			case 0: //根结点
				file =figpath+"/l5/root.gif";
				break;
			case 1: // 二级节点
				file =figpath+"/l5/bsp_department&corporation.gif";
				break;
			case 2: // 三级节点
				file =figpath+ "/l5/bsp_department&corporation.gif";
				break;
			default: // 四级节点
				file = figpath+"/l5/bsp_post.png";
    }
	return file;
}
//叶子节点不添加
function isEndNode(rcd){
	if(rcd.get("leve")=="2"){
		return false;
	}else{
		return true;
	}
}
/**
* 事件处理：点击添加节点
*/
function addNode(menuitem){
	var editpanel = L5.getCmp("editpanel");
	editpanel.show();
	var record=menuitem.parentMenu.record;
	
	devicesMaintenaDataset.newRecord({
		"id":"",
		"applyApparatusId":"",
		"unit":"",
		"apparatusName":"",
		"leve":parseInt(record.get("leve"))+1,
		"ups":record.get("applyApparatusId"),
		"isEfficient":"1"
		
	});
}

/**
* 事件处理：点击删除节点
*/
function deleteNode(menuitem){
	var record=menuitem.parentMenu.record;
	
	if(!deleteCheck(record.get("applyApparatusId"))){
		L5.MessageBox.alert('提示：','存在下级节点，不能删除');
		return;
	}
	
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var  delIds=[];
			delIds[0]=record.get("id");
			var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptAssistiveDevicesMaintenaCommand");
			command.setParameter("delIds", delIds);
			command.execute("delete");
			if (!command.error) {
				var parentTree = L5.getCmp("dicBptDevicetree");
				parentTree.root.record.reload();
				parentTree.root.expand();
			}else{
				L5.Msg.alert('提示',"保存时出现错误！"+command.error);
			}
		}else{
			return false;
		}
	});
	
}

/**
* 事件处理：点击节点显示维护页面
*/
function selectedNode(record){
	var editpanel = L5.getCmp("editpanel");
	editpanel.show();
	devicesMaintenaDataset.setParameter("APPLY_APPARATUS_ID",record.get("applyApparatusId"));
	devicesMaintenaDataset.load();

}
function save(){
	var record = devicesMaintenaDataset.getCurrent();
	var applyApparatusId = record.get("applyApparatusId");
	if(applyApparatusId==""||applyApparatusId==null){
		L5.Msg.alert('提示',"器械编号不能为空!");
		return false;
	}
	var apparatusName = record.get("apparatusName");
	if(apparatusName==""||apparatusName==null){
		L5.Msg.alert('提示',"器械名称不能为空!");
		return false;
	}
	
	
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptAssistiveDevicesMaintenaCommand");
	command.setParameter("records", [record]);
	command.execute("save");
	if (!command.error) {
		L5.Msg.alert('提示',"数据保存成功!");
		var parentTree = L5.getCmp("dicBptDevicetree");
		parentTree.root.record.reload();
		parentTree.root.expand();
		var editpanel = L5.getCmp("editpanel");
		editpanel.hide();
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

function testId(o){
	if(o.value==""){
		return ;
	}
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptAssistiveDevicesMaintenaCommand");
	command.setParameter('applyApparatusId',o.value);
	command.execute('testDeviceId');
	var c = command.getReturn('count');
	var id = command.getReturn('id');
	var yid= document.getElementById("id").value;
	
	if(parseInt(c,10)>0) {
		if((yid!=undefined&&yid!=id)||(yid==undefined)){
			L5.Msg.alert('提示',"此编号已存在!");
			document.getElementById("applyApparatusId").value="";
		}
	}
	
}
function deleteCheck (id){
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptAssistiveDevicesMaintenaCommand");
	command.setParameter('id',id);
	command.execute('checkDelete');
	var c = command.getReturn('count');
	if(parseInt(c,10)<1) return true;
	return false;
}