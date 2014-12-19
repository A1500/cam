
//判断是增加还是修改方法

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

function saveTree(){
  var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptCatalogueArchivesSaveCommand");
  command.execute("checkReturn");
  var flag = command.getReturn("flag");
  if(flag =='1'){
     L5.Msg.alert("提示","请直接进行查询修改操作!");
     return false;
  }else{
     command.execute("saveTree");
     if(!command.error){
		L5.Msg.alert("提示","保存成功!");	
     }
  }
 
}


function returnClick(){
    history.go(-1);
}