
	var str=struTypeId;
	if(str=="null" || str=="") {
		str="00";
	}
function init() {
	var tree = L5.getCmp('orgstrutree');
	if( expandAll === 'true') {
		tree.expandAll();
	}else{
	 tree.root.expand();
		if(locateLoginUser==='true'){
	        var command=new L5.Command("org.loushang.bsp.organization.cmd.StruCommand");
			   command.execute("locateLoginUser");
			   var locatePath;
			   if(!command.error){
			      locatePath="/"+command.getReturn("locatePath");
			   }else{
			      return;
			   }
				var rootIndex=locatePath.indexOf("/"+rootid+"/");
				if(rootIndex==-1){
				   rootid=1;
				}
				var path=locatePath.substr(locatePath.indexOf("/"+rootid+"/"));
				tree.selectPath(path,"struPath");
		}
		if(locateOrganId!=null&&locateOrganId!="undefined"){
              var command=new L5.Command("org.loushang.bsp.organization.cmd.StruCommand");
              command.setParameter("organId",locateOrganId);
              command.execute("locateOrganId");
              var locatePath;
              if(!command.error){
                locatePath="/"+command.getReturn("locatePath");
              }else{
                return;
              }
             var rootIndex=locatePath.indexOf("/"+rootid+"/");
             if(rootIndex==-1){
				   rootid=1;
				}

				var path=locatePath.substr(locatePath.indexOf("/"+rootid+"/"));
				tree.selectPath(path,"struPath");
		}
	}
}
//从数据库获取根结点数据
var rootdata = function() {
   	var command=new L5.Command("org.loushang.bsp.organization.cmd.StruCommand");
   	var rootRecord;
   	if(userId=="SUPERADMIN"||userId=="PUBLIC"){
   	   command.setParameter("rootid","rootId");
  	}else{
   	  //根结点的struId
      command.setParameter("rootid",rootid);
  	}
   	//要选择的organType
   	command.setParameter("choiceOrganType",choiceOrganType);
   	//要显示的organType
   	command.setParameter("showOrganType",showOrganType);
   	//所查询的组织类型struType
   	command.setParameter("struTypeId",struTypeId);
    command.execute("getRootForHelp");
    if(!command.error) {
		rootRecord=command.getReturn("rootRecord");
	}else {
		L5.Msg.alert("提示",command.error);
	}
	//判定根结点是否符合可选条件
	var checkorganType=rootRecord.organType;
	if(choiceOrganType.indexOf(checkorganType)!=-1){
		checkorganId=rootRecord.organId;
	}else{
		checkorganId="";
	}
   return {
    id : rootRecord.struId,//唯一标志record,如果是前台配置生成record,需要指定id
	struId:rootRecord["struId"],
	organId:checkorganId,
	struType:rootRecord.struType,
	parentId:rootRecord.parentId,
	struLevel:rootRecord.struLevel,
	struPath:rootRecord.struPath,
	struOrder:rootRecord.struOrder,
	isLeaf:rootRecord.isLeaf,
	inUseStru:rootRecord.inUseStru,
	organName:rootRecord.organName,
	shortName:rootRecord.shortName,
	organType:rootRecord.organType,
	organTypeName:rootRecord.organTypeName,
	struTypeName:rootRecord.struTypeName,
	inUseOrgan:rootRecord.inUseOrgan,
	recordType : 'stru'
	};
};


function getParentId(record){
	var pid=record.get("struId");
	return pid;
}

function getStruType(rec){
	var struType=rec.get('struType');
	return struType?struType:"00";
}

function  getStruId(record){
	var struId=record.get('struId');
	 return struId?struId:"rootId";
}

//获取要选择的organType
function getChoiceOrganType(record){
	return choiceOrganType?choiceOrganType:"0"
}

//获取要显示的organType
function getShowOrganType(record){
	return showOrganType?showOrganType:"0"
}

//是否精确匹配组织类型
function getIsExact(record){
	return isExact?isExact:"0"
}

function  confirmValue(){
	var tree = L5.getCmp('orgstrutree');
	var organId = tree.getChecked("organId");
	var organCode = tree.getChecked("organCode");
	var organName = tree.getChecked("organName");
	var struId = tree.getChecked("struId");
	var corpId = tree.getChecked("cropId");
	var corpName = tree.getChecked("cropName");
	var deptId = tree.getChecked("deptId");
	var deptName = tree.getChecked("deptName");
	var organType=tree.getChecked("organType");
	if(organId !="" && organName !=""){
	   if(returnValueType=="array"){
		    var len=organId.length;
		    var arr=new Array(len);
	        for(var i=0;i<organId.length;i++){
	            arr[i]=new Array(8);
	            arr[i][0]=organId[i];
	            arr[i][1]=organName[i];
	            arr[i][2]=struId[i];
	            arr[i][3]=deptId[i];
	            arr[i][4]=deptName[i];
	            arr[i][5]=corpId[i];
	            arr[i][6]=corpName[i];
	            arr[i][7]=organType[i];
	        }
          window.returnValue=arr;
	   }else {
	     window.returnValue=organCode+";"+organName+";"+struId+";"+deptId+";"+deptName+";"+corpId+";"+corpName+";"+organType;
	   }
		window.close();
	}else{
		L5.Msg.alert("提示","请选择组织节点!");
	    return false;
	}
}

	//根据类型值获取图标路径
function getIcon(rec){
	var figpath=L5.webPath+"/skins/images";
	var file="images/corp_img.gif";
	if(!rec){
		return file;
	}
	var organType=rec.get('organType');
	var type=organType.substring(0, 1);
	var value=parseInt(type);
	switch(value){
			case 0: //根结点
				file =figpath+"/l5/root.gif";
				break;
			case 1: // 法人
				file =figpath+"/l5/bsp_department&corporation.gif";
				break;
			case 2: // 部门
				file =figpath+ "/l5/bsp_department&corporation.gif";
				break;
			case 6: // 岗位
				file = figpath+"/l5/bsp_post.png";
				break;
			case 8: // 职工
				file =figpath+ "/l5/bsp_employee.gif";
				break;
			default:
				file =figpath+ "/l5/other.gif";

	}
	return file;
}

function getChoiceBox(record){
	//后台判断的方法，不符合条件的，后台将organId置空，从而无法选中
	var organId=record.get("organId");
	if(organId=="rootId"){
		if(record.isRoot){
			return '';
		}
	}
	if(organId==""){
		return '';
	}else{
	    if(isCheckBox=="0"){
			return  'radiobox';
		}else{
			return  'checkbox';
		}


	}
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

function getUserId(){
  return userId;
}

function getIsLeaf(rec){
	var leaf1=rec.get('isLeaf');
	if(leaf1=='1'){
		return true;
	}else{
		return false;
	}
}