//处理界面上的空值
	var str=struTypeId;
	if(str=="null" || str=="") {
		str="00";
	}

//初始化：主要是初始化组织树结构，并设置需要监听的事件
function init() {
	var tree = L5.getCmp('orgstrutree');
	var grid=L5.getCmp("struGrid");
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
	if(struIds!='null'&&struIds!=""){
      organDataset.setParameter("struIds",struIds);
      organDataset.load();
      }
	//多选框状态改变时触发的事件
	//tree.on("checkChange",checkChanged);
	//树节点被双击时触发事件
	tree.on("dblclick",selectperson);
    //Edit中行被双击时触发的事件
    grid.on("rowdblclick",rowDbClick);
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
   	//要选择的organType
   	command.setParameter("choiceOrganType",choiceOrganType);
   	//要显示的organType
   	//command.setParameter("showOrganType",showOrganType);
   	command.setParameter("showPost",showPost);
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
}


/**
*定义一个数据集
*/
var dataset=new L5.model.Dataset({id:"organDataset"});


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
	window.returnValue="";
	window.close();
}

function clears(){
	//window.returnValue=""+";"+""+";"+""+";"+""+";"+""+";"+""+";"+"";
	if(returnValueType == "array"){
		var arr = new Array("","","","","","","");
		window.returnValue = arr;
	}else{
		window.returnValue=";;;;;;";
	}
	window.close();
}

//是否级联选中节点的下级，false为不选中下级
function isCheckedSub(node,parentNode){
	return false;
}

//双击树组织树中节点，自动添加到右边的列表中
function selectperson(node,e){
   var tree = L5.getCmp("orgstrutree");
   var struId=node.record.get("struId");
   var organId =node.record.get("organId");
   var organName =node.record.get("organName");
   var organType =node.record.get("organType");
   var organDs=L5.DatasetMgr.lookup("organDataset");
	// 点击选择叶子节点 触发添加到右侧
	if (organId != ""&& organName != ""){
		    var i=0;
		    for(;i<organDs.getCount();i++){
		      if(organId==organDs.getAt(i).get("organId"))
		           break;
		     }
		     if(i==organDs.getCount()){
 			   organDs.add([node.record]);
		     }
    }
}

//向右按钮触发事件：选择树上节点，点击向右的按钮，添加到右边的列表中
function moveRight(){
  var tree = L5.getCmp("orgstrutree");
  var node=tree.getCurrentNode();
  if(node!=false&&node!=undefined){
	  var record=node.record;
	  var organId=record.get("organId");
	  var organType=record.get("organType");
	  var reg=/^8[0-9]*$/;
	  if(reg.test(organType)&&organType!=""){
	    if(organDataset.find("organId",organId,0)==-1){
	       organDataset.add([record]);
	    }else{
	      L5.MessageBox.alert("提示","该员工已在列表中！");
			return;
	    }

	  }  
  }else{
	  L5.MessageBox.alert("提示","请选择要添加的节点");
	  return; 
  }
}
//点击确定按钮
 function confirmValue(){
	var ds=L5.DatasetMgr.lookup("organDataset");
	var revalue="";
	var len=ds.getCount();
	var arr=new Array(len);
	if(len>0){
	  if(returnValueType=="array"){
	     for(var i=0;i<len;i++){
		  var organId=ds.getAt(i).get("organId");
		  var organName=ds.getAt(i).get("organName");
		  var struId=ds.getAt(i).get("struId");
		  var deptId=ds.getAt(i).get("deptId");
		  var deptName=ds.getAt(i).get("deptName");
		  var cropId=ds.getAt(i).get("cropId");
		  var cropName=ds.getAt(i).get("cropName");
		  if(organId !="" && organName !=""){
               arr[i]=new Array(7);
               arr[i][0]=organId;
               arr[i][1]=organName;
               arr[i][2]=struId;
               arr[i][3]=deptId;
               arr[i][4]=deptName;
               arr[i][5]=cropId;
               arr[i][6]=cropName;
	     }
      }
      window.returnValue=arr;
  	}else{
    	for(var i=0;i<len;i++){
		  var organId=ds.getAt(i).get("organId");
		  var organName=ds.getAt(i).get("organName");
		  var struId=ds.getAt(i).get("struId");
		  var deptId=ds.getAt(i).get("deptId");
		  var deptName=ds.getAt(i).get("deptName");
		  var cropId=ds.getAt(i).get("cropId");
		  var cropName=ds.getAt(i).get("cropName");
		  var temp;
		  if(organId !="" && organName !=""){
		      revalue+=organId+";"+organName+";"+struId+";"+deptId+";"+deptName+";"+cropId+";"+cropName;
		       if(i!=(len-1)){
		    	 revalue+="&";
		       }
		  }
	   }
	   window.returnValue=revalue;
     }
		window.close();
	 }else{
	     L5.MessageBox.alert("提示","请选择要添加的节点！");
	      return false;
	      }
	 }


//组织树中多选框的状态改变时，触发该方法(该方法暂且不用了，改用双击节点添加的方式)
function checkChanged(node,checked){
   // 选择框选中
   var tree = L5.getCmp("orgstrutree");
   var struId=node.record.get("struId");
   var organId = node.record.get("organId");
   var organName =node.record.get("organName");
   var organType =node.record.get("organType");
  // node.ui.toggleCheck();
   var organDs=L5.DatasetMgr.lookup("organDataset");
	// 选择叶子节点 触发添加到右侧
	if (organId != ""&& organName != ""){
		if (node.ui.checkbox.checked == true) {
		    var i=0;
		    for(;i<organDs.getCount();i++){
		      if(organId==organDs.getAt(i).get("organId"))
		           break;
		     }
		     if(i==organDs.getCount()){
 			   organDs.add([node.record]);
		     }
		}else{
		    for(var i=0;i<organDs.getCount();i++){
		      if(organId==organDs.getAt(i).get("organId")){
		      		organDs.removeAt(i);
		      		break;
		         }
		    }
		}
    }
}
//EditGrid中双击某一行时，该行自动移除
function rowDbClick(grid,rowIndex,e){
  var organDs=L5.DatasetMgr.lookup("organDataset");
  var struDs=L5.DatasetMgr.lookup("orgstruDs");
  var tree = L5.getCmp("orgstrutree");
 // var struId=organDs.getAt(rowIndex).get("struId");
 // var selnode=tree.getNodeByRecordId(struId,"stru");
   //selnode.ui.checkbox.checked=false;
   organDs.removeAt(rowIndex);
}

//点击上移按钮
function moveUp(){
 var grid=L5.getCmp("struGrid");
 var ds=L5.DatasetMgr.lookup("organDataset");
 //获取所有被选中的行
  var sm=grid.getSelectionModel();
  var cell=sm.getSelections();
  var sellen=cell.length;
  var rows=ds.getCount();
  var i;
  if(sellen<1){
    L5.MessageBox.alert("提示","请选择要上移的记录！");
		return;
     }
  if(sellen>1){
   	L5.MessageBox.alert("提示","一次只能移动一条记录");
	return;
    }
	   var organId=cell[0].get("organId");
	   var selIndex=ds.find("organId",organId,0);
	   if(selIndex==0){ //如果选择的是第一条记录，提示信息
	     L5.MessageBox.alert("提示","当前记录已经是第一行记录！");
		 return;
	    }else{
		   var record=ds.getAt(selIndex);
		   var rc=[];
		   rc[0]=record;
		   ds.removeAt(selIndex);
		   ds.insert(selIndex-1,rc);
		   ds.movePrev();
	       }
}

//点击下移按钮
function moveDown(){
 var grid=L5.getCmp("struGrid");
 var ds=L5.DatasetMgr.lookup("organDataset");
 //获取所有被选中的行
  var sm=grid.getSelectionModel();
  var cell=sm.getSelections();
  var sellen=cell.length;
  var rows=ds.getCount();
  if(sellen<1){
    L5.MessageBox.alert("提示","请选择要下移的记录！");
		return;
     }
  if(sellen>1){
   	L5.MessageBox.alert("提示","一次只能移动一条记录");
	return;
    }
	   var organId=cell[0].get("organId");
	   var selIndex=ds.find("organId",organId,0);
	   if(selIndex+1==rows){ //如果选择的是最后一条记录，提示信息
	     L5.MessageBox.alert("提示","当前记录已经是最后一行了！");
		 return;
	    }else{
		   var record=ds.getAt(selIndex);
		   var rc=[];
		   rc[0]=record;
		   ds.removeAt(selIndex);
		   ds.insert(selIndex+1,rc);
		   ds.moveNext();
	       }
}
//点击置顶按钮
function moveTop(){
 var grid=L5.getCmp("struGrid");
  var ds=L5.DatasetMgr.lookup("organDataset");
  //获取所有被选中的行
  var sm=grid.getSelectionModel();
  var cell=sm.getSelections();
  var sellen=cell.length;
  var rows=ds.getCount();
  if(ds.getCount()==0){
	  L5.MessageBox.alert("提示","没有可以置顶的记录！");
	  return; 
  }
  if(sellen==1){
	var organId=cell[0].get("organId");
	var selIndex=ds.find("organId",organId,0);
    if(selIndex==0){
      L5.MessageBox.alert("提示","当前记录已经是第一行了！");
	  return;
    }else{
      var record=ds.getAt(selIndex);
      var rc=[];
      rc[0]=record;
      ds.removeAt(selIndex);
      ds.insert(0,rc);
      ds.moveFirst();
    }
   }else if(sellen<1){
	    L5.MessageBox.alert("提示","请选择一条记录！");
		return;
    }else if(sellen>1){
    	L5.MessageBox.alert("提示","一次只能移动一条记录！");
		return;
    }
}

//点击置底按钮
function moveBottom(){
  var grid=L5.getCmp("struGrid");
  var ds=L5.DatasetMgr.lookup("organDataset");
  //获取所有被选中的行
  var sm=grid.getSelectionModel();
  var cell=sm.getSelections();
  var sellen=cell.length;
  var rows=ds.getCount();
  if(sellen==1){
	var organId=cell[0].get("organId");
	var selIndex=ds.find("organId",organId,0);
    if(selIndex+1==rows){
      L5.MessageBox.alert("提示","当前记录已经是最后一行了！");
	  return;
    }else{
      var record=ds.getAt(selIndex);
      ds.removeAt(selIndex);
      ds.add([record]);
      ds.moveLast();
    }
  }else{
    if(sellen<1){
	    L5.MessageBox.alert("提示","请选择一条记录！");
		return;
		}else{
		  L5.MessageBox.alert("提示","一次只能移动一条记录！");
		  return;
		}
  }
}

//点击向左的按钮，删除Grid里面选择的记录行,同时将树中相应节点的选中状态取消
function moveLeft(){
  var grid=L5.getCmp("struGrid");
  var organDs=L5.DatasetMgr.lookup("organDataset");
  var struDs=L5.DatasetMgr.lookup("orgstruDs");
  var tree = L5.getCmp("orgstrutree");
  if(organDs.getCount()==0){
    L5.MessageBox.alert("提示","没有可以移除的记录！");
		return;
   }
  //获取所有被选中的行
  var sm=grid.getSelectionModel();
  var cell=sm.getSelections();
  if(cell.length<1){
    L5.MessageBox.alert("提示","请先选择要移除的记录");
		return;
  }else{
      for(var i=0;i<cell.length;i++){
       var struId=cell[i].get("struId");
       //var selnode=tree.getNodeByRecordId("stru_"+struId);
      // selnode.ui.checkbox.checked=false;
       organDs.remove(cell[i]);
   }
  }
}
function getUserId(){
	  return userId;
	}

function getShowPost(){
   return showPost?showPost:"true";
}

function getIsLeaf(rec){
	var leaf1=rec.get('isLeaf');
	if(leaf1=='1'){
		return true;
	}else{
		return false;
	}
}