
//判断是增加还是修改方法
var flag="";
/**
 * 定义根节点结构
 */ 
var rootdata = {
	
   catalogCode:'0',
	
   catalogName:'优抚档案目录',
	
   upCatalogCode:'',
	
   catalogInfo:'',
	
   catalogOrder:'',
	
   objectType:'',
	
   serviceType:'',
	
   recordType : 'bptCatalogueArchivesRecord'
};

/**
 * 事件处理：获得 TreebaseParams的值
 */
function getParent(rec){
var parentObjId = rec.get('catalogCode');
	return parentObjId?parentObjId:"0";
}


function getBptCatalogueArchivesdisabled(rec){
	return rec.get('catalogCode')=='';
}
/**
* 定义一个dataset
*/
var dataset = new L5.model.Dataset({
	id : "bptCatalogueArchives_detaildataset"
});

function show(record){
  if(record.get("catalogCode")==0){
   L5.getCmp("bptCatalogueArchives").show();
  }else{
    L5.getCmp("bptCatalogueArchives").show();
  }
}
/**
* 事件处理：将节点信息添加到table中
*/
function selectedBptCatalogueArchives(record){
   
   bptCatalogueArchives_detaildataset.removeAll();
	var data=L5.getCmp("bptCatalogueArchivestree").getCurrentRecord().data;
	var id=data.catalogCode;
	bptCatalogueArchives_detaildataset.add([new bptCatalogueArchives_detaildataset.recordType(data,id)]);
	L5.getCmp("detailPanel").show();
	if(record.get("catalogCode")==rootdata.catalogCode){
		L5.getCmp("detailPanel").hide();
	}
	L5.getCmp("updatePanel").hide();
}

/**
* 事件处理：点击添加按钮
*/
function addBptCatalogueArchives(menuitem){
    var data=L5.getCmp("bptCatalogueArchivestree").getCurrentRecord().data;
	var up_code=data.catalogCode;
	var leve = data.leve;
	if(organType=='13'){
	   if(up_code=='0'){
	      L5.Msg.alert('提示',"没有权限添加优抚目录枝节点，只能添加叶子节点!");
	      return false;
	   }else if(leve=='2'){
	      L5.Msg.alert('提示',"不能再添加下一级节点!");
	      return false;
	   }
	}
	L5.getCmp("detailPanel").hide();
	L5.getCmp("updatePanel").show();
	bptCatalogueArchives_detaildataset.removeAll();
    var mgr=bptCatalogueArchives_detaildataset.newRecord();
	flag="insert";
	//document.getElementById("catalog_Code").disabled=true;
}

/**
* 事件处理：点击删除按钮
*/
function delBptCatalogueArchives(menuitem){
    if(menuitem==null){
		L5.Msg.alert('提示',"请选择要删除的结点!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的结点吗?',function(state){
		if(state=="yes"){
			var record = menuitem.parentMenu.record;
			var prec = record.parentRecord;
			if(record.get("flag")=="1"){
			   if(prec){
			    var delId=record.get("catalogID");
				var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptCatalogueArchivesSaveCommand");
				command.setParameter("delId",delId);
				command.execute("delete");
				prec.remove(record);	
			}
		 }else{
		       L5.Msg.alert('提示',"没有权限删除本节点!");
		       return false;
		 }
	   }else{
			return false;
		}
	});
}


/**
* 事件处理：点击保存按钮
*/
function save(){
    var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptCatalogueArchivesSaveCommand");
    var parentRecord=L5.getCmp("bptCatalogueArchivestree").getCurrentRecord();
	var parentId=parentRecord.get("catalogCode");
	
	var record=bptCatalogueArchives_detaildataset.getCurrent();
	var catalogName = record.get("catalogName");
	if(catalogName==""){
		L5.Msg.alert('提示！',"目录名称不能为空！");
		return false;
	}
	var serviceType = record.get("serviceType");
	if(serviceType==""){
		L5.Msg.alert('提示！',"业务类型不能为空！");
		return false;
	}
	var catalogOrder = record.get("catalogOrder");
	if(catalogOrder==""){
		L5.Msg.alert('提示！',"显示顺序不能为空！");
		return false;
	}
	var childId=record.get("catalogCode");
	command.setParameter("catalogCode",childId);
	command.execute("getFlag");
	var flagState = command.getReturn("flag");
	
	if(flag=="update"){
	    childId=record.get("catalogCode");
		parentId=record.get("upCatalogCode");
	}
	record.set("upCatalogCode",parentId);
	command.setParameter("bptCatalogueArchivesRecord", record);
	command.setParameter("parentId",parentId);
	command.setParameter("childId",childId);
	
	if(flag=="insert"){
	    if(flagState =='1'){
          L5.Msg.alert("提示","相同的目录代码已存在，请选择其它目录代码!");
          return false;
        }
		command.execute("save");
	}else if(flag=="update"){
		command.execute("update");
	}
	if(!command.error){
		L5.Msg.alert("提示","保存成功!");	
		if(flag=="insert"){
			var data = {
		        organId:record.get("organId"),	
		        catalogCode:childId,
			    catalogName:record.get("catalogName"),
			    upCatalogCode:record.get("upCatalogCode"),
			    catalogInfo:record.get("catalogInfo"),
			    catalogOrder:record.get("catalogOrder") ,
			    objectType:record.get("objectType"),
			    serviceType:record.get("serviceType")
		    };
			var rec = new L5.tree.TreeRecord.recordTypes["bptCatalogueArchivesRecord"](data,data.catalogCode);
			parentRecord.insert(rec);
		}else if(flag=="update"){
			var updaterecord=L5.getCmp("bptCatalogueArchivestree").getCurrentNode();
			updaterecord.setText(record.get("catalogName"));
		}
		
		L5.getCmp("detailPanel").show();
		L5.getCmp("updatePanel").hide();
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
//事件处理：点击修改按钮
function  updateBptCatalogueArchives(menuitem){
   var record = menuitem.parentMenu.record;
   if(organType=='13'){
         bptCatalogueArchives_detaildataset.removeAll();
	     var data=L5.getCmp("bptCatalogueArchivestree").getCurrentRecord().data;
	     var id=data.catalogID;
	     bptCatalogueArchives_detaildataset.add([new bptCatalogueArchives_detaildataset.recordType(data,id)]);
	     if(id==rootdata.catalogID){
		    L5.getCmp("detailPanel").hide();
		    L5.getCmp("updatePanel").hide();
	     }else{
		    L5.getCmp("detailPanel").hide();
		    L5.getCmp("updatePanel").show();
	     }
	       flag="update";
	       document.getElementById("serviceType").disabled=true;
  }else if(organType=='11'){
         bptCatalogueArchives_detaildataset.removeAll();
	     var data=L5.getCmp("bptCatalogueArchivestree").getCurrentRecord().data;
	     var id=data.catalogID;
	     bptCatalogueArchives_detaildataset.add([new bptCatalogueArchives_detaildataset.recordType(data,id)]);
	     if(id==rootdata.catalogID){
		    L5.getCmp("detailPanel").hide();
		    L5.getCmp("updatePanel").hide();
	     }else{
		    L5.getCmp("detailPanel").hide();
		    L5.getCmp("updatePanel").show();
	     }
	       flag="update";
	       document.getElementById("serviceType").disabled=true;
  }else{
       L5.Msg.alert('提示',"没有权限修改优抚目录节点!");
	   return false;
  }
   
	
}

function back(){
    history.go(-1);
}