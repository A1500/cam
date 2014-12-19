
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
}

function back(){
    history.go(-1);
}