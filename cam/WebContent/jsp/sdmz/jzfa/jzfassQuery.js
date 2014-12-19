/**
 * 事件处理：初始化 根据当前登录单位的行政区划过滤。
 */
function init() {
    var ds = L5.DatasetMgr.lookup("jzfaDataset");
    var sjtjDataset=L5.DatasetMgr.lookup("sjtjDataset");
    if (organArea.substring(4, 12) == "00000000")
    {
        var organArea1 = organArea.substring(0, 4);
        jzfaDataset.setParameter("SAM_PLAN.PLAN_ORGAN_REGION@like", organArea1);
   } else if (organArea.substring(6, 12) == "000000")
    {
        var organArea1 = organArea.substring(0, 6) ;
       jzfaDataset.setParameter("SAM_PLAN.PLAN_ORGAN_REGION@like", organArea1);
    }
    else if (organArea.substring(9, 12) == "000")
    {
        var organArea1 = organArea.substring(0, 6);
        jzfaDataset.setParameter("SAM_PLAN.PLAN_ORGAN_REGION@like", organArea1);
   } else if (!organArea.substring(9, 12) == "000")
  {
        var organArea1 = organArea.substring(0, 6);
      jzfaDataset.setParameter("SAM_PLAN.PLAN_ORGAN_REGION@like", organArea1);
 }
	sjtjDataset.setParameter("REG_ORGAN_TYPE",'A1');
	ds.load();
	sjtjDataset.load();
    L5.QuickTips.init();
}
/*
 * 通用帮助
 */
function forHelp(){
	var revalue=window.showModalDialog("../../bsp/organization/getselect.jsp?rootId="+struId+"&showOrganType=0&organType=12,13,14,15&isExact=0&isCheckBox=0&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
		//list[0] == organId,list[1]==organName,list[2]==struId
//		var userDataset = L5.DatasetMgr.lookup("userDataset");
//		var userRecord = userDataset.getCurrent();
		document.getElementById("lrdwId").value = list[0];
		document.getElementById("lrdwmc").value = list[1];

	}
}
/**
 * 选择属地行政区划窗口
 */
function func_ForDomicileSelect() {
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&organCode="
					+ organArea + "&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("lrdwId").value = list[0];
		document.getElementById("lrdwmc").value = list[1];
	}
}

/**
 * 事件处理：点明细按钮
 */
function detail(){
	
	var jzfaGrid=L5.getCmp('jzfaGrid');
	var selected=jzfaGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert("提示","请选择一条记录查看！");
		return false;
	}
	var data = new L5.Map();
	data.put("planId",selected[0].get('planId'));
	var url='jsp/sdmz/jzfa/jzfassmxQuery.jsp';
	var text = '救助方案明细';
	L5.forward(url,text,data);

}
/******************************************救助方案查询licb开始************************************************************/
/**
 * 事件处理：救助方案查询
 * 注：数据统计同时同步数据
 */
function query() {
     var ds = L5.DatasetMgr.lookup("jzfaDataset");//救助方案
    var sjtjDataset = L5.DatasetMgr.lookup("sjtjDataset");//数据统计
    var planname = document.getElementById("planName").value;//救助方案名称
    var plantype = document.getElementById("planType").value;//救助类型代码
    var planbegin = document.getElementById("planBegin").value;//救助开始日期S
    var planend = document.getElementById("planEnd").value;//救助开始日期T
    var lrrqQ = document.getElementById("lrrqQ").value;//录入日起S
    var lrrqZ = document.getElementById("lrrqZ").value;//录入日起T
    var lrdwId = document.getElementById("lrdwIdquery").value;//录入单位ID
    var organArea1="";
    //数据过滤，上级查看下级数据，下级不能查看上级数据。
     if (organArea.substring(4, 12) == "00000000")
    {
          organArea1 = organArea.substring(0, 4);
        jzfaDataset.setParameter("SAM_PLAN.PLAN_ORGAN_REGION@like", organArea1);
    } else if (organArea.substring(6, 12) == "000000")
    {
          organArea1 = organArea.substring(0, 6);
        jzfaDataset.setParameter("SAM_PLAN.PLAN_ORGAN_REGION@like", organArea1);
    }
    else if (organArea.substring(9, 12) == "000")
    {
         organArea1 = organArea.substring(0, 6);
       jzfaDataset.setParameter("SAM_PLAN.PLAN_ORGAN_REGION@like", organArea1);
    } else if (!organArea.substring(9, 12) == "000")
    {
         organArea1 = organArea.substring(0, 6);
       jzfaDataset.setParameter("SAM_PLAN.PLAN_ORGAN_REGION@like", organArea1);
   }
    //数据过滤，上级能查看下级数据
    if (planname == "") planname = undefined;
    ds.setParameter("PLAN_NAME@=", planname);
    sjtjDataset.setParameter("PLAN_NAME",planname);
    	
    if (plantype == "") plantype = undefined;
    ds.setParameter("PLAN_TYPE@=", plantype);
    sjtjDataset.setParameter("PLAN_TYPE",plantype);
    
    if (planbegin == "") planbegin = undefined;
    ds.setParameter("PLAN_BEGIN@>=", planbegin);
    sjtjDataset.setParameter("PLAN_BEGIN",planbegin);
    
    if (planend == "") planend = undefined;
    ds.setParameter("PLAN_END@<=", planend);
    sjtjDataset.setParameter("PLAN_END",planend);
    
    if (lrrqQ == "") lrrqQ = undefined;
    ds.setParameter("REG_TIME@>=", lrrqQ);
    sjtjDataset.setParameter("REG_TIME",lrrqQ);
    
    if (lrrqZ == "") lrrqZ = undefined;
    ds.setParameter("REG_TIME@<=", lrrqZ);
    sjtjDataset.setParameter("REG_TIME",lrrqZ);
    
    if(lrdwId=="") lrdwId=undefined;
	ds.setParameter("REG_ORGAN_ID@=",lrdwId);
	sjtjDataset.setParameter("REG_ORGAN_ID",lrdwId);
  	
  	sjtjDataset.setParameter("REG_ORGAN_TYPE",'A1');
    sjtjDataset.setParameter("ORGANAREA1",organArea1);
    ds.load();
    sjtjDataset.load();
}
/******************************************救助方案查询licb结束************************************************************/
/**
*时间处理：点击查看按钮
*
**/
function query2(){
	var jzfaGrid=L5.getCmp('jzfaGrid');
	var selected=jzfaGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.MessageBox.alert('提示','请选择要查看的一条记录');
		return false;
	}
	var ds = L5.DatasetMgr.lookup("jzfaUpdateDataset");
	ds.setParameter("PLAN_ID@=",selected[0].get("planId"));
	ds.load();
	
	var win=L5.getCmp("jzfaWin");
	win.show(this);
	
}

// 修改救助方案
function forupdate(){
	var jzfaGrid=L5.getCmp('jzfaGrid');
	var selected=jzfaGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.MessageBox.alert('提示','请选择要修改的一条记录');
		return false;
	}
	var ds = L5.DatasetMgr.lookup("jzfaUpdateDataset");
	ds.setParameter("PLAN_ID@=",selected[0].get("planId"));
	ds.load();
	
	var win=L5.getCmp("jzfaUpdateWin");
	win.show(this);
	
}

//事件处理：点击修改按钮。
function update(){
	var ds = L5.DatasetMgr.lookup("jzfaUpdateDataset");
	ds.set('regOrganType',document.getElementById("regOrganType").value);
	var planName=ds.get("planName");
	var planType=ds.get("planType");
	var planBegin=ds.get("planBegin");
	var planEnd=ds.get("planEnd");
	if(planName==""){
		L5.Msg.alert("提示","救助方案名称为空！");
		return;
	}
	
	if(planName.length>25){
		L5.Msg.alert("提示","救助方案名称过长！");
		return;
	}
	if(planType==""){
		L5.Msg.alert("提示","请选择救助类型！");
		return;
	}
	if(planBegin==""){
		L5.Msg.alert("提示","起始时间为空！");
		return;
	}
	if(planEnd==""){
		L5.Msg.alert("提示","截止时间为空！");
		return;
	}
	if(planBegin>planEnd){
		L5.Msg.alert("提示","起始时间大于截止时间，请重新输入！");
		return;
	}
	var command = new L5.Command("com.inspur.sdmz.jzfa.cmd.PlanCmd"); 
	command.setParameter("jzfa1", ds.getCurrent().toBean("com.inspur.sdmz.jzfa.data.Plan"));
	command.execute("updateJzfa");
	var win=L5.getCmp("jzfaUpdateWin");
	win.hide(this);
	lod();
	if (!command.error) {
		L5.MessageBox.alert('提示',"更新成功！");
	}else{
		L5.MessageBox.alert('警告',command.error);
	}
}

// 关闭窗口2
function hideUpdateWin(){
	var win=L5.getCmp("jzfaUpdateWin");
	win.hide(this);
}

//dataset加载时 根据登录单位的行政区划过滤：只能上级看到下级，
function lod(){
var ds =L5.DatasetMgr.lookup("jzfaDataset");
	if(organArea.substring(4,12)=="00000000")
	{	
		var organArea1=organArea.substring(0,4);
		ds.setParameter("SAM_PLAN.PLAN_ORGAN_REGION@like",organArea1);		
	}else if(organArea.substring(6,12)=="000000")
	{
		 var organArea1=organArea.substring(0,6);
		 ds.setParameter("SAM_PLAN.PLAN_ORGAN_REGION@like",organArea1);
	}
	else if(organArea.substring(9,12)=="000")
	{
		var  organArea1=organArea.substring(0,6);
		 ds.setParameter("SAM_PLAN.PLAN_ORGAN_REGION@like",organArea1);
	}else if(!organArea.substring(9,12)=="000")
	{
		var organArea1=organArea.substring(0,6);
		ds.setParameter("SAM_PLAN.PLAN_ORGAN_REGION@like",organArea1);
	}
	ds.load();
}