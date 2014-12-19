function init() {
    var ds=L5.DatasetMgr.lookup("ds");
     if(organArea.substring(4,12)=="00000000")
	{	
		var organArea1=organArea.substring(0,4)+"%";
		
		ds.setParameter("SAM_PLAN.REG_ORGAN_REGION@like",organArea1);		
		
		
		
	}else if(organArea.substring(6,12)=="000000")
	{
		
		 var organArea1=organArea.substring(0,6)+"%";
		
		 ds.setParameter("SAM_PLAN.REG_ORGAN_REGION@like",organArea1);
	}
	else if(organArea.substring(9,12)=="000")
	{
		
		var  organArea1=organArea.substring(0,9)+"%";
		
		 ds.setParameter("SAM_PLAN.REG_ORGAN_REGION@like",organArea1);
		
	}else if(!organArea.substring(9,12)=="000")
	{
		
		
		var organArea1=organArea;
		
		 ds.setParameter("SAM_PLAN.REG_ORGAN_REGION@like",organArea1);
		
	}
    L5.QuickTips.init();
        ds.load();
};

function getParam(ElementId) {
    var value = document.getElementById(ElementId).value;
    if (value == "") value = undefined;
    return value;
}
function query() {
    var jzbmquery = getParam("jzbmquery");
    var jzsjqquery = getParam("jzsjqquery");
    var jzsjzquery = getParam("jzsjzquery");
    var jzlxquery = getParam("jzlxquery");
    var jzfamcquery = getParam("jzfamcquery");

    ds.setParameter("SAM_PLAN.PLAN_ORGAN_ID@=", jzbmquery);
    ds.setParameter("SAM_PLAN.PLAN_BEGIN@>=", jzsjqquery==""||jzsjqquery==undefined?"":(jzsjqquery+" 00:00:00"));
    ds.setParameter("SAM_PLAN.PLAN_BEGIN@<=", jzsjzquery==""||jzsjzquery==undefined?"":(jzsjzquery+" 00:00:00"));
    ds.setParameter("SAM_PLAN.PLAN_TYPE@in", jzlxquery);
    ds.setParameter("SAM_PLAN.PLAN_NAME@=", jzfamcquery);
    ds.load();
}
function exportExcel() {
	L5.dataset2excel(ds,"/jsp/sdmz/comm/query/assistanceOfDepartQuery/forexcelDepart.jsp?pageIndex="+ds.pageInfo.pageIndex);
}
/**
 * value:是当前单元格的值
 * cellmeta里保存的是cellId单元格id，id不知道是干啥的，似乎是列号，css是这个单元格的css样式。
 * record是这行的所有数据，你想要什么，record.data["id"]这样就获得了。
 * rowIndex是行号，不是从头往下数的意思，而是计算了分页以后的结果。
 * columnIndex列号太简单了。
 * store 这个是你构造表格时候传递的ds，也就是说表格里所有的数据，你都可以随便调用
*/
function showValue(value, cellmeta, record, rowIndex, columnIndex, store) {
	var grid = L5.getCmp("editGridPanel").getView();
	var te=grid.getCell(rowIndex,3);
	if(te!=undefined) {
	}
}