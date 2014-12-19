var ciitcommand=new L5.Command("com.inspur.cams.comm.diccityChange.cmd.DicCityChangeCmd");
ciitcommand.setParameter("id",organCode);
ciitcommand.execute("getNameById");
var cityName = ciitcommand.getReturn("cityName");
function init(){
}

/***************************区划代码树**********************************/

/**
 * 定义根节点结构
 */ 
var rootdata = {
	
   id:organCode,
	
   name:cityName,
	
   leve:'-1',
	
   ups:'',
	
   flag:'',
	
   recordType : 'dicCityRecord'
};

/**
 * 事件处理：获得 TreebaseParams的值
 */
 var level = "4" ;
function getParent(rec){
	var parentObjId = rec.get('id');
	var levelValue = rec.get("leve");
	if(levelValue < level) {
		return parentObjId?parentObjId:organCode;
	} else {
		return "000000000000";
	}
}
function getUserInfo(record){
	var rcdTp = record.recordType;
	if(rcdTp == "dicCityRecord"){
		var userId=record.get("id");
		var userName=record.get("name");
		if(userName!=null&&userName!='')
		return userId+"【"+userName+"】";
		else
			return userName;
	}
	return "";
}
function getDicCitydisabled(rec){
	return rec.get('id')=='';
}
/*var radioMaxlevel = 2;
function getChoiceBox(record){
   if(record.get("leve")*1<=radioMaxlevel*1)
      return '';
   else
      return  radioType;
}*/
//根据类型值获取图标路径
function getIcon(rec){
	var figpath=L5.webPath+"/skins/images";
	var leve=rec.get('leve');
	var value=parseInt(leve);
	switch(value){
			case 1: //根结点
				file =figpath+"/l5/root.gif";
				break;
			case 2: // 二级节点
				file =figpath+"/l5/bsp_department&corporation.gif";
				break;
			case 3: // 三级节点
				file =figpath+ "/l5/bsp_department&corporation.gif";
				break;
			default: // 四级节点
				file = figpath+"/l5/bsp_post.png";
    }
	return file;
}

//导出Excel
function exportExcel(){
	var dataset=L5.DatasetMgr.lookup("dicCityExportDataSet");
	dataset.setParameter("ID@RLIKE",areaCode);
	dataset.load();
	L5.dataset2excel(dataset,"/jsp/cams/comm/diccityChange/dicCityExcel.jsp?userName="+organName);
}
