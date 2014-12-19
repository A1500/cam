/**
*
*初始化 根据救助类型过滤查询
*根据当前登录单位的行政区划过滤查询条件 只能上级看到下级
*
*/
function init() {
	var ds =L5.DatasetMgr.lookup("jzfaDataset");
	var sjtjDataset=L5.DatasetMgr.lookup("sjtjDataset");
	if(organArea.substring(4,12)=="00000000")
	{	
		var organArea1=organArea.substring(0,4);
		ds.setParameter("SAM_PLAN.PLAN_ORGAN_REGION@like",organArea1);		
		 
	}else if(organArea.substring(6,12)=="000000"){	
		 var organArea1=organArea.substring(0,6);
		 ds.setParameter("SAM_PLAN.PLAN_ORGAN_REGION@like",organArea1);
	}else if(organArea.substring(9,12)=="000"){
		var  organArea1=organArea.substring(0,6);
		ds.setParameter("SAM_PLAN.PLAN_ORGAN_REGION@like",organArea1);
		
	}else if(!organArea.substring(9,12)=="000")
	{
		var organArea1=organArea.substring(0,6);
	    ds.setParameter("SAM_PLAN.PLAN_ORGAN_REGION@like",organArea1);
	}
	sjtjDataset.setParameter("REG_ORGAN_TYPE",'A1');
	sjtjDataset.setParameter("organArea",organArea);
	ds.load();
	sjtjDataset.load();
	
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
// 执行查询 设置参数过滤
/***********************************救助方案查询调整 Slicb 20110628*************************************/
function query() {
    var ds = L5.DatasetMgr.lookup("jzfaDataset");//救助方案
    var sjtjDataset = L5.DatasetMgr.lookup("sjtjDataset");//数据统计
    var planName = document.getElementById("planName").value;//救助方案名称
    var planType = document.getElementById("planType").value;//救助类型代码
    var planBegin = document.getElementById("planBegin").value;//救助开始日期S
    var planEnd = document.getElementById("planEnd").value;//救助开始日期T
    var lrrqQ = document.getElementById("lrrqQ").value;//录入日起S
    var lrrqZ = document.getElementById("lrrqZ").value;//录入日起T
    var organArea1="";
    //数据过滤，上级能查看下级数据
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
    
    if (planName == "") planName = undefined;
    ds.setParameter("PLAN_NAME@=", planName);
    sjtjDataset.setParameter("PLAN_NAME",planName);
    	
    if (planType == "") planType = undefined;
    ds.setParameter("PLAN_TYPE@=", planType);
    sjtjDataset.setParameter("PLAN_TYPE",planType);
    
    if (planBegin == "") planBegin = undefined;
    ds.setParameter("PLAN_BEGIN@>=", planBegin);
    sjtjDataset.setParameter("PLAN_BEGIN",planBegin);
    
    if (planEnd == "") planEnd = undefined;
    ds.setParameter("PLAN_END@<=", planEnd);
    sjtjDataset.setParameter("PLAN_END",planEnd);
    
    if (lrrqQ == "") lrrqQ = undefined;
    ds.setParameter("REG_TIME@>=", lrrqQ);
    sjtjDataset.setParameter("REG_TIME",lrrqQ);
    
    if (lrrqZ == "") lrrqZ = undefined;
    ds.setParameter("REG_TIME@<=", lrrqZ);
    sjtjDataset.setParameter("REG_TIME",lrrqZ);
    
 	sjtjDataset.setParameter("REG_ORGAN_TYPE",'A1');
	sjtjDataset.setParameter("organArea",organArea);
    ds.load();
    sjtjDataset.load();
}
/***********************************救助方案查询调整 T licb 20110628*************************************/
//点击明细按钮 转向救助方案明细。
function detail(){

	var jzfaDataset = L5.DatasetMgr.lookup("jzfaDataset");
	var jzfaGrid=L5.getCmp('jzfaGrid');
	var selected=jzfaGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert("提示","请选择一条记录查询！");
		return false;
	}
	var rec=jzfaDataset.getCurrent()
	var data = new L5.Map();
	
	var planbegin=rec.get("planBegin");
	var planend=rec.get("planEnd");
	data.put("planBegin",planbegin);
	data.put("planEnd",planend);
	data.put("planId",selected[0].get('planId'));
	data.put("returnJsp","jzfaQuery.jsp");
	var url='jsp/sdmz/jzfa/jzfamxQuery.jsp';
	var text = '救助方案明细';
	L5.forward(url,text,data);

}
// 增加救助方案
function forinsert(){
	var ds = L5.DatasetMgr.lookup("jzfaDatasetNew");

	var win=L5.getCmp("jzfaWin");
	win.show(this);
	document.getElementById("jzzjJeInsert").setAttribute("disabled","true");
	document.getElementById("jzhsInsert").setAttribute("disabled","true");
	document.getElementById("jzrsInsert").setAttribute("disabled","true");
	lod();
	 jzfaDatasetNew.newRecord({
        planOrgName: organName
    });
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
	document.getElementById("jzzjJeEdit").setAttribute("disabled","true");
	document.getElementById("jzhsEdit").setAttribute("disabled","true");
	document.getElementById("jzrsEdit").setAttribute("disabled","true");
	
}
// 保存救助方案
function insert(){
	var ds = L5.DatasetMgr.lookup("jzfaDatasetNew");
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
		L5.Msg.alert("提示","救助方案过长！");
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
		L5.Msg.alert("提示","起始时间大于截止时间，请从新输入！");
		return;
	}
	
	
	var command = new L5.Command("com.inspur.sdmz.jzfa.cmd.PlanCmd"); 
	command.setParameter("jzfa", ds.getCurrent().toBean("com.inspur.sdmz.jzfa.data.Plan"));
	command.execute("addJzfa");
	if (!command.error) {
		var win=L5.getCmp("jzfaWin");
		win.hide(this);
		lod();
		var sjtjDataset=L5.DatasetMgr.lookup("sjtjDataset");
		sjtjDataset.setParameter("organArea",organArea);
		sjtjDataset.load();
	}else{
		L5.MessageBox.alert('警告',command.error);
	}
	var ds =L5.DatasetMgr.lookup("jzfaDataset");
	ds.load;
}
// 关闭窗口1
function hideWin(){
	var win=L5.getCmp("jzfaWin");
	win.hide(this);
}
// 关闭窗口2
function hideUpdateWin(){
	var win=L5.getCmp("jzfaUpdateWin");
	win.hide(this);
}
//点击删除按钮执行删除操作
function del(){
	var jzfaGrid=L5.getCmp('jzfaGrid');
	var selected=jzfaGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.MessageBox.alert('删除','请选择要删除的记录');
		return false;
	}
	L5.MessageBox.confirm('警告', '方案与其救助信息将一起删除，并不可恢复，是否继续？',
		function(sta){
			if(sta=="yes"){
				var jzfaids=[];
				for(var i=0;i<selected.length;i++){
					jzfaids[i]=selected[i].get("planId");
				}
				var command = new L5.Command("com.inspur.sdmz.jzfa.cmd.PlanCmd"); 
				command.setParameter("jzfaids", jzfaids);
				command.execute("deleteJzfa");
				if (!command.error) {
					for(var i=0;i<selected.length;i++){
						jzfaDataset.remove(selected[i]);
					}
					var sjtjDataset=L5.DatasetMgr.lookup("sjtjDataset");
					sjtjDataset.setParameter("organArea",organArea);
					sjtjDataset.load();
					
				}else{
					L5.MessageBox.alert('警告',command.error);
				}
			} else return ;
		}
	);
}
//点击实施按钮 执行实施操作
function pass(){
	var jzfaGrid=L5.getCmp('jzfaGrid');
	var selected=jzfaGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.MessageBox.alert('实施','请选择要实施的记录');
		return false;
	}
	L5.MessageBox.confirm('提示', '是否实施选中方案！',
		function(sta){
			if(sta=="yes"){
				var jzfaids=[];
				for(var i=0;i<selected.length;i++){
					jzfaids[i]=selected[i].get("planId");
				}
				var command = new L5.Command("com.inspur.sdmz.jzfa.cmd.PlanCmd"); 
				command.setParameter("jzfaids", jzfaids);
				command.execute("passJzfa");
				if (!command.error) {
					for(var i=0;i<selected.length;i++){
						jzfaDataset.remove(selected[i]);
					}
				}else{
					L5.MessageBox.alert('警告',command.error);
				}
			} else return ;
		}
	);
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