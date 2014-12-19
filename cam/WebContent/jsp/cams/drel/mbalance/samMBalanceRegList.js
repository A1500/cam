//页面初始化
function init() {
	var gvnListDS=L5.DatasetMgr.lookup("gvnListDS");
	gvnListDS.setParameter("hosStatus","2");
	gvnListDS.setParameter("dataSource","GOV");
	gvnListDS.setParameter("domicileCode",organCode);
	//gvnListDS.load();
}
//根据ElementId得到组件的value
function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
//查询方法
function query(){
	var gvnListDS=L5.DatasetMgr.lookup("gvnListDS");
	gvnListDS.setParameter("domicileCode",organCode);
	gvnListDS.setParameter("insuranceType",getParam("insuranceType"));		
	gvnListDS.setParameter("assitanceType",getParam("assitanceType"));	
	gvnListDS.setParameter("hospitalRecordId",getParam("hospitalRecordId"));
	gvnListDS.setParameter("inTime",getParam("inTime"));
	gvnListDS.setParameter("hosStatus","2");
	gvnListDS.setParameter("dataSource","GOV");
	gvnListDS.load();
}
function reg(){
	var data=null;
	var url='jsp/cams/drel/mbalance/samMBalanceReg.jsp';
	var text = '结算登记';
	L5.forward(url,text,data);
}