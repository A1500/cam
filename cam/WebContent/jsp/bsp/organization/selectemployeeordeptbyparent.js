    var choiceOrganType;
	var showOrganType;
	var str=struTypeId;
	if(str=="null" || str=="") {
		str="00";
	}
	if(selectType=="0"){// 选择员工
		choiceOrganType='1,2,6,8';
		showOrganType='1,2,6,8';
	}else{// 选择部门
		choiceOrganType='1,2';
		showOrganType='1,2';
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
	}
}

//从数据库获取根结点数据
var rootdata = function() {
   	var command=new L5.Command("org.loushang.bsp.organization.cmd.StruCommand");
   	var rootRecord;
   	//根结点的struId
  //因为loushang3里面没有rootId这个虚拟的根节点，需要做一下转换
    if(flag=="bsp3"&&rootid=="rootId"){
		command.setParameter("rootid","1");   
    }else{
    	command.setParameter("rootid",rootid);
    }
	command.setParameter("flag",flag);
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
	return choiceOrganType?choiceOrganType:"0";
}

//获取要显示的organType
function getShowOrganType(record){
	return showOrganType?showOrganType:"0";
}

//是否精确匹配组织类型
function getIsExact(record){
	return isExact?isExact:"0";
}
//此方法暂时不用
function  confirmValue1(){
	var tree= L5.getCmp('orgstrutree');
	var struIds=tree.getChecked("struId");
	var organIds = tree.getChecked("organId");
	var organNames = tree.getChecked("organName");
	var corpIds= tree.getChecked("cropId");
	var corpNames= tree.getChecked("cropName");
	var deptIds= tree.getChecked("deptId");
	var deptNames= tree.getChecked("deptName");
	var organTypes=tree.getChecked("organType");
	var reg1=/^8[0-9]*$/;
	var reg2=/^2[0-9]*$/;
	var employeeInfo=[];
	var deptInfo=[];
    var employeeIndex=0;
    var deptIndex=0;
	if(organTypes!=""&&organTypes!=null){
	   for(var i=0;i<organTypes.length;i++){
	      var temp=organTypes[i];
	       if(reg1.test(temp)){
              var sstr=organIds[i]+";"+organNames[i]+";"+struIds[i]+";"+deptIds[i]+";"+deptNames[i]+";"+corpIds[i]+";"+corpNames[i];
              employeeInfo[employeeIndex]=sstr;
              employeeIndex++;
	       }
	       if(reg2.test(temp)){
              var sstr=organIds[i]+";"+organNames[i]+";"+struIds[i]+";"+deptIds[i]+";"+deptNames[i]+";"+corpIds[i]+";"+corpNames[i];
              deptInfo[deptIndex]=sstr;
              deptIndex++;
	       }
	    }
	  if(selectEmployee=="0"){//getselect为“0”代表选择员工；为“1”代表选择部门
	    window.returnValue=employeeInfo;
	    window.close();
	  }
	  if(selectEmployee=="1"){
	    window.returnValue=deptInfo;
	    window.close();
	  }
	}else{
	   L5.Msg.alert("提示","请选择组织节点!");
	   return false;
	}
}
//定义一个全局变量来保存将要返回的组织信息

function  confirmValue(){
    var tree= L5.getCmp('orgstrutree');
    var command=new L5.Command("org.loushang.bsp.organization.cmd.StruCommand");
	var struIds=tree.getChecked("struId");
	var organIds = tree.getChecked("organId");
	var employeeInfo=[];
	var deptInfo=[];
    var employeeIndex=0;
    var deptIndex=0;
    var struIdlist;
    var organIdlist;
    var organNamelist;
    var deptIdlist;
    var deptNamelist;
    var cropIdlist;
    var cropNamelist;
    var employeeInfoString="";
    var deptInfoString="";
    if(struIds!=""&&struIds!=null){
	    command.setParameter("struIds",struIds);
		command.execute("getAllUnderLingInfo");
		if(selectType=="0"){//选择员工
		   organIdlist=command.getReturn("eorganIdlist");
		   organNamelist=command.getReturn("eorganNamelist");
		   struIdlist=command.getReturn("estruIdlist");
		   deptIdlist=command.getReturn("edeptIdlist");
		   deptNamelist=command.getReturn("edeptNamelist");
		   cropIdlist=command.getReturn("ecropIdlist");
		   cropNamelist=command.getReturn("ecropNamelist");
		   for(var i=0;i<struIdlist.size();i++){
		    var struId=struIdlist.get(i);
		    var node=tree.getNodeByRecordId(struId,"stru");
		    if(node!==null&&node!==undefined&&node.ui.checkbox.checked==false){
		            i++;
		     }else{
			   var sstr=organIdlist.get(i)+";"+organNamelist.get(i)+";"+struIdlist.get(i)+";"+deptIdlist.get(i)+";"+deptNamelist.get(i)+";"+cropIdlist.get(i)+";"+cropNamelist.get(i);
			   if(returnValueType=="string"){
			     employeeInfoString+=sstr;
			     if(i!=struIdlist.size()-1){
		       	  employeeInfoString+="&";
		         }
			   }else{
			     employeeInfo[employeeIndex]=sstr;
			     employeeIndex++;
			   }
			 }
		  }
		  if(employeeInfoString!==""){
		    window.returnValue=employeeInfoString;
		  }else if(employeeInfo.length!==0){
		    window.returnValue=employeeInfo;
		  }
			 window.close();
		   }
		 if(selectType=="1"){//选择部门
	       organIdlist=command.getReturn("dorganIdlist");
		   organNamelist=command.getReturn("dorganNamelist");
		   struIdlist=command.getReturn("dstruIdlist");
		   deptIdlist=command.getReturn("ddeptIdlist");
		   deptNamelist=command.getReturn("ddeptNamelist");
		   cropIdlist=command.getReturn("dcropIdlist");
		   cropNamelist=command.getReturn("dcropNamelist");
		   for(var i=0;i<struIdlist.size();i++){
		     var struId=struIdlist.get(i);
		     var node=tree.getNodeByRecordId(struId,"stru");
		    if(node!==undefined&&node.ui.checkbox.checked==false){
		         ;
		    }else{
		     var sstr=organIdlist.get(i)+";"+organNamelist.get(i)+";"+struIdlist.get(i)+";"+deptIdlist.get(i)+";"+deptNamelist.get(i)+";"+cropIdlist.get(i)+";"+cropNamelist.get(i);
		     if(returnValueType=="string"){
		       deptInfoString+=sstr;
		       if(i!=struIdlist.size()-1){
		       	  deptInfoString+="&";
		       }
		     }else{
		      deptInfo[deptIndex]=sstr;
		       deptIndex++;
		      }
		     }
		  }
		  if(deptInfoString!==""){
		    window.returnValue=deptInfoString;
		  }else if(deptInfo.length!==0){
		    window.returnValue=deptInfo;
		  }
		   window.close();
	  }
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
	window.returnValue="";
	window.close();

}

//是否级联选中节点的下级，false为不选中下级
function isCheckedSub(node,parentNode){
   if(node.record.get("organType")==parentNode.record.get("organType")){
      return false;
   }
	return true;
}

function getIsLeaf(rec){
	var leaf1=rec.get('isLeaf');
	if(leaf1=='1'){
		return true;
	}else{
		return false;
	}
}