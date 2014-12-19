var currentList;

function init(){
	if(applyApparatusId!=''){
		currentList = applyApparatusId.split(",");
	}
	L5.getCmp("dicBptDevicetree").on("beforeexpandnode",expandnode);
}

function expandnode(node,deep,anim){
	if(currentList!=''&&currentList!=null&&currentList!=undefined){
		for(var i=0;i<currentList.length;i++){
			currentnumList = currentList[i].split("X");
			
			node.eachChild(function(node){
				if(currentnumList[0].substr(0,1)==node.record.get("applyApparatusId").substr(0,1)
						&&node.record.get("leve")=="1"){
					node.expand();
				}
			});
		}
	}
}
//判断是增加还是修改方法
var flag="";
/**
 * 定义根节点结构
 */ 
var rootdata = {
	
   code:'00000',
	
   text:"假肢矫形器械",
	
	
   ups:'',
	
	
   recordType : 'bptdevicesRecord'
};



function eachCheck(node,checked){
	if(checked){//选中
		DevicesMaintenaDataset.newRecord({"applyApparatusId":node.record.get("applyApparatusId"),"unit":node.record.get("unit"),
			"apparatusName":node.record.get("apparatusName")});
		//node.record.set("operation_flag","1");
	}else{//取消
		
		for(var i=0;i<DevicesMaintenaDataset.getCount();i++){
			if(node.record.get("applyApparatusId")==DevicesMaintenaDataset.getAt(i).get("applyApparatusId")){
				DevicesMaintenaDataset.remove(DevicesMaintenaDataset.getAt(i));
			}
			
		}
	}
	
	
}

	

/**
* 得到选框的类型。
*/
function getChecked(record){
	//L5.getCmp("dicBptDevicetree").getNodeByRecord(record).expand();
	if(currentList!=''&&currentList!=null&&currentList!=undefined){
		for(var i=0;i<currentList.length;i++){
			currentnumList = currentList[i].split("X");
			if(currentnumList[0]==record.get("applyApparatusId")){
				DevicesMaintenaDataset.newRecord({"applyApparatusId":record.get("applyApparatusId"),"unit":record.get("unit"),
					"apparatusName":record.get("apparatusName"),"num":currentnumList[1]});
				return 1;
			}
		}
	}else {
		return 0;
	}
	
}
/**
 * 事件处理：获得 TreebaseParams的值
 */
function getParent(rec){
	var parentObjId = rec.get('applyApparatusId');
	return parentObjId?parentObjId:"00000";
}





function  confirmValue(){
	if(DevicesMaintenaDataset.getCount()<1){
		L5.Msg.alert('提示',"请至少选择一种器械!");
		return false;
	}
	var apparatusName="";
	var applyApparatusId="";
	for(var i=0;i<DevicesMaintenaDataset.getCount();i++){
		var res=DevicesMaintenaDataset.getAt(i);
		var num = res.get("num");
		if(num==''){
			L5.Msg.alert('提示',"请填写器械数量!");
			return false;
		}
		var r = /^\+?[1-9][0-9]*$/;　　//正整数 
		if(num!=''&&!r.test(num)){
			L5.Msg.alert('提示',"请正确填写器械数量!");
			return false;
		}
		if(i==0){
			applyApparatusId = res.get("applyApparatusId")+"X"+ res.get("num");
			apparatusName = res.get("apparatusName")+"X"+ res.get("num")+res.get("unit");
		}else{
			applyApparatusId = applyApparatusId+","+res.get("applyApparatusId")+"X"+ res.get("num");
			apparatusName = apparatusName+","+res.get("apparatusName")+"X"+ res.get("num")+res.get("unit");
		}
	}
	/*if(applyId!=null){
		var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyAssistiveDevicesCommand");
		command.setParameter("records", DevicesMaintenaDataset.getAllRecords());
		command.setParameter("applyId", applyId);
		command.execute("updatePeopleDevices");
		if (!command.error) {
			
		}else{
			L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		}
	}*/
	
	var ret = {
		idAndName : applyApparatusId+";"+apparatusName,
		record : DevicesMaintenaDataset.getAllRecords()
	};
	window.returnValue=ret;
	//window.returnValue=applyApparatusId+";"+apparatusName+";"+DevicesMaintenaDataset.getAllRecords();
	window.close();
}

function closew(){
	//return false;
	window.returnValue="";
	window.close();
}

function clears(){

  //window.returnValue=""+";"+""+";"+""+";"+""+";"+""+";"+""+";"+"";
  window.returnValue=";;;;;;;"
	window.close();

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
   if(record.get("leve")=='2')
      return 'checkbox';
   else
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



