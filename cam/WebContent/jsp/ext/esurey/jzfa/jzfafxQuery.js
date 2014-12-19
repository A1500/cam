/**
*
*事件处理：初始化。
*
*/
function init() {
    var grid = L5.getCmp('jzfaGrid');
    var ds = L5.DatasetMgr.lookup("jzfaDataset");
   
    if(organArea.substring(4,12)=="00000000"){	
		var organArea1=organArea.substring(0,4);
		ds.setParameter("PLAN_ORGAN_REGION",organArea1);		
	}else if(organArea.substring(6,12)=="000000"){	
		 var organArea1=organArea.substring(0,6);
		 ds.setParameter("PLAN_ORGAN_REGION",organArea1);
	}else if(organArea.substring(9,12)=="000"){
		var  organArea1=organArea.substring(0,6);
		ds.setParameter("PLAN_ORGAN_REGION",organArea1);
	}else if(!organArea.substring(9,12)=="000"){
		var organArea1=organArea.substring(0,6);
	    ds.setParameter("PLAN_ORGAN_REGION",organArea1);
	}
 	ds.setParameter("ORGAN_TYPE",organType);
   
    ds.load();
};
 
function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
/*********************************救助方案综合查询S***************************************************/
/**
 * 事件处理：点击查询按钮 并根据当前登录单位的行政区划过滤。
 * 操作：同事更新查询列表下的数据统计
 */
function query() {
    var sjtjDataset = L5.DatasetMgr.lookup("sjtjDataset");//数据统计
    var ds = L5.DatasetMgr.lookup("jzfaDataset");//救助方案
	 if(organArea.substring(4,12)=="00000000"){	
		var organArea1=organArea.substring(0,4);
		ds.setParameter("PLAN_ORGAN_REGION",organArea1);		
	}else if(organArea.substring(6,12)=="000000"){	
		 var organArea1=organArea.substring(0,6);
		 ds.setParameter("PLAN_ORGAN_REGION",organArea1);
	}else if(organArea.substring(9,12)=="000"){
		var  organArea1=organArea.substring(0,6);
		ds.setParameter("PLAN_ORGAN_REGION",organArea1);
	}else if(!organArea.substring(9,12)=="000"){
		var organArea1=organArea.substring(0,6);
	    ds.setParameter("PLAN_ORGAN_REGION",organArea1);
	}
	
	//-->
    ds.setParameter("REG_TIMES", getParam("lrrqQ"));
    ds.setParameter("REG_TIMET", getParam("lrrqZ"));
    ds.setParameter("STATUS", getParam("status"));
    ds.setParameter("PLAN_NAME", getParam("planName"));
    ds.setParameter("PLAN_BEGIN", getParam("planBegin"));
    ds.setParameter("PLAN_END", getParam("planEnd"));
    ds.setParameter("PLAN_ORGAN_NAME", getParam("planOrgName"));
    ds.setParameter("ORGAN_TYPE",organType);
    
    sjtjDataset.setParameter("STATUS",getParam("status"));//实施状态
    sjtjDataset.setParameter("PLAN_NAME",getParam("planName"));//救助方案名称
    sjtjDataset.setParameter("PLAN_ORGAN_NAME",getParam("planOrgName"));//救助单位
    sjtjDataset.setParameter("PLAN_BEGIN",getParam("planBegin"));//救助开始日期S
    sjtjDataset.setParameter("PLAN_END",getParam("planEnd"));//救助开始日期T
    sjtjDataset.setParameter("REG_TIME",getParam("lrrqQ"));//救助录入日期S
    sjtjDataset.setParameter("REG_TIME",getParam("lrrqZ"));//救助录入日期T
    ds.load();
    sjtjDataset.load();
    
   
}
/*********************************救助方案综合查询T***************************************************/
/**
 * 事件处理：点击分析按钮
 */
function analyze(){
	var jzfaGrid=L5.getCmp('jzfaGrid');
	var selected=jzfaGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.MessageBox.alert('提示','请选择要分析的记录');
		return false;
	}
	var planIds="";
	for(var i=0;i<selected.length;i++){
		planIds+=selected[i].get("PLAN_ID")+",";
	}
	
	var data = new L5.Map();
	data.put("jzfaids",planIds);
	var url='jsp/ext/esurey/jzfa/jzfafxAnalyze.jsp';
	var text = '救助方案分析';
	L5.forward(url,text,data);
}
/**
*
*事件处理：点击查看方案按钮。
*
*/
function detail(){
	
	var jzfaGrid=L5.getCmp('jzfaGrid');
	var selected=jzfaGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert("提示","请选择一条记录查询！");
		return false;
	}
	var data = new L5.Map();
	data.put("returnJsp","jzfafxQuery.jsp");  
	data.put("planId",selected[0].get('PLAN_ID'));  
	var url='jsp/ext/esurey/jzfa/jzfamxDetailQuery.jsp';
	var text = '救助方案明细';
	L5.forward(url,text,data);

}