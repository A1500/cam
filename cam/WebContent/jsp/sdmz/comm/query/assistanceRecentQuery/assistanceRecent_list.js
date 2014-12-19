function init() {
    var lrsj = document.getElementById("lrsjquery").value;
   var ds= L5.DatasetMgr.lookup("ds")
    var conDate;
	if(lrsj!=undefined&&lrsj!="") {
		conDate = new Date((new Date).getTime()-lrsj*24*60*60*1000);
	}
    ds.setParameter("SAM_PLAN.PLAN_BEGIN@>=", conDate.toString()+" 00:00:00");
    if(organArea.substring(4,12)=="00000000")
	{	
		var organArea1=organArea.substring(0,4)+"%";
		
		ds.setParameter("SAM_PLAN.PLAN_ORGAN_REGION@like",organArea1);		
		
		
		
	}else if(organArea.substring(6,12)=="000000")
	{
		
		 var organArea1=organArea.substring(0,6)+"%";
		
		 ds.setParameter("SAM_PLAN.PLAN_ORGAN_REGION@like",organArea1);
	}
	else if(organArea.substring(9,12)=="000")
	{
		
		var  organArea1=organArea.substring(0,9)+"%";
		
		 ds.setParameter("SAM_PLAN.PLAN_ORGAN_REGION@like",organArea1);
		
	}else if(!organArea.substring(9,12)=="000")
	{
		
		
		var organArea1=organArea;
		
		 ds.setParameter("SAM_PLAN.PLAN_ORGAN_REGION@like",organArea1);
		
	}
   ds.load();
    L5.QuickTips.init();
};

function getParam(ElementId) {
    var value = document.getElementById(ElementId).value;
    if (value == "") value = undefined;
    return value;
}
function query() {
    var lrsj = document.getElementById("lrsjquery").value;
    var conDate;
	if(lrsj!=undefined&&lrsj!="") {
		conDate = new Date((new Date).getTime()-lrsj*24*60*60*1000);
	}
    ds.setParameter("SAM_PLAN.PLAN_BEGIN@>=", conDate.toString()+" 00:00:00");
    var jzbmquery = document.getElementById("jzbmquery").value;

    ds.setParameter("SAM_PLAN.PLAN_ORGAN_ID@=", jzbmquery);
    ds.load();
}
function mutiHelp() {
	var itemWin = L5.getCmp("multiItem_help");
	if(itemWin) {
		itemWin.show();
		return;
	} else {
		var itemDs = L5.DatasetMgr.lookup("jzlxDs");
		var item_config={};
		item_config.id="multiItem_help";
		item_config.dataset = itemDs;
		item_config.gridColumns=[{header:"编号",sortable:true,field:"value"},{header:"名称",sortable:true,field:"text"}];
		var multiItem_search=new L5.SearchArea();
		multiItem_search.addTextField("code","编号","DIC_ASSITANCE_TYPE_EXT.CODE");
		multiItem_search.addTextField("name","名称","DIC_ASSITANCE_TYPE_EXT.NAME");
		itemWin = new L5.GridHelpWindow(item_config,multiItem_search);
		itemWin.show();
	}
	//进行调用
	itemWin.afterExecute=function(){
		var result=this.getReturn();
    	if(result!=null&&!itemWin.isClear){
    		setValue(result);
    	}
	}
}
function setValue(result) {
	var jzlxDisplay = document.getElementById("jzlxDisplay");
	var jzlxquery = document.getElementById("jzlxquery");
	var reValue = "";
	if(result.length) {
		for(var i=0;i<result.length;i++) {
			var record = result[i];
			jzlxDisplay.value += (","+record.get("text"));
			jzlxquery.value += (","+record.get("value"));
		}	
	} else {
		jzlxDisplay.value = result.get("text");
		jzlxquery.value = result.get("value");
	}
}
function jzlxDbClick() {
	document.getElementById("jzlxDisplay").value="";
	document.getElementById("jzlxquery").value="";
}

function exportExcel() {
	L5.dataset2excel(ds,"/jsp/sdmz/comm/query/assistanceRecentQuery/forexcel.jsp?pageIndex="+ds.pageInfo.pageIndex);
}