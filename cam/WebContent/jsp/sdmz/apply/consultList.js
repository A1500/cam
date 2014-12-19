/**
 * @title:
 * @description:初始化 时 根据不同登录单位的行政区划 调用不同的处理方法
 * @author:
 * @since:2011-06-08
 * @param
*/

function init() {
	var grid=L5.getCmp('editGridPanel');
	//给grid增加双击侦听事件。
	grid.on("rowdblclick",griddbclick);
	//L5.DatasetMgr.lookup("ds").load();
	var ds =L5.DatasetMgr.lookup("ds");
	if(organArea.substring(4,12)=="00000000")//市用户
	{	
		var organArea1=organArea.substring(0,4);
		
		ds.setParameter("SAM_APPLY.CURRENT_ORG_AREA@like",organArea1);		
		
		
		
	}else if(organArea.substring(6,12)=="000000")//区用户
	{
		
		 var organArea1=organArea.substring(0,6);
		
		 ds.setParameter("SAM_APPLY.CURRENT_ORG_AREA@like",organArea1);
	}
	else if(organArea.substring(9,12)=="000")//街道用户
	{
		
		var  organArea1=organArea.substring(0,9);
		
		 ds.setParameter("SAM_APPLY.CURRENT_ORG_AREA@like",organArea1);
		
	}else if(!organArea.substring(9,12)=="000")//村委会用户
	{
		
		
		var organArea1=organArea;
		
		 ds.setParameter("SAM_APPLY.CURRENT_ORG_AREA@like",organArea1);
		
	}
	ds.load();
	L5.QuickTips.init();
};
//根据当前登录单位的行政区划过滤 上级看到下级
function lod(){

var ds =L5.DatasetMgr.lookup("ds");
	if(organArea.substring(4,12)=="00000000")//市用户
	{	
		var organArea1=organArea.substring(0,4);
		
		ds.setParameter("SAM_APPLY.CURRENT_ORG_AREA@like",organArea1);		
		
		
		
	}else if(organArea.substring(6,12)=="000000")//区用户
	{
		
		 var organArea1=organArea.substring(0,6);
		
		 ds.setParameter("SAM_APPLY.CURRENT_ORG_AREA@like",organArea1);
	}
	else if(organArea.substring(9,12)=="000")//街道用户
	{
		
		var  organArea1=organArea.substring(0,9);
		
		 ds.setParameter("SAM_APPLY.CURRENT_ORG_AREA@like",organArea1);
		
	}else if(!organArea.substring(9,12)=="000")//村委会用户
	{
		
		
		var organArea1=organArea;
		
		 ds.setParameter("SAM_APPLY.CURRENT_ORG_AREA@like",organArea1);
		
	}
	ds.load();
}
//根据组件的Id得到组件的value值
function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
//点击回访按钮 校验是否能够回访并 弹出回访窗口
function huiFang(grid,index,e){ 
var dsDataset = L5.DatasetMgr.lookup("ds");
var dsRecord=dsDataset.getCurrent();

var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	var hfFlag=[];
	var blbzFlag=[];
    for(var i=0;i<selected.length;i++){
		hfFlag[i]=selected[i].get("returnVisit");
		blbzFlag[i]=selected[i].get("handleSign");
		if(hfFlag[i]=="1"){
		L5.Msg.alert("信息","已回访,请重新选择！");
		dsDataset.load();
		return;
		}else if(blbzFlag[i]!="2"){
			L5.Msg.alert("信息","未办理完结,请重新选择！");
			lod();
			return;
		}
    }
var hfDataset = L5.DatasetMgr.lookup("hfDataset");
var applyGrid=L5.getCmp('editGridPanel');
var selected=applyGrid.getSelectionModel().getSelections();
if(selected.length<1){
L5.Msg.alert("提示","请选择至少一条回访记录");
	return false;
}
	hfDataset.load();
	var win=L5.getCmp('hfWin');
	
	win.show(grid.el.dom);
}
	//隐藏窗口
function hide()
{
var win=L5.getCmp('hfWin');
win.hide();
}
//增加保存满意度
function mydInsert()
{
	var hfDataset = L5.DatasetMgr.lookup("hfDataset");
	var applyGrid=L5.getCmp('editGridPanel');
	var selected=applyGrid.getSelectionModel().getSelections();
	
	var hfRecord=hfDataset.getCurrent();
	var satisDegree=hfRecord.get("satisDegree");
	
	if(satisDegree==""){
		L5.Msg.alert("信息","请选择满意度！");
		return false;
	}
	
	
	var command = new L5.Command("com.inspur.sdmz.apply.cmd.SamApplySaveCmd");
	command.setParameter("ywhfRecord", hfRecord.toBean("com.inspur.sdmz.apply.data.SamApply"));
	delId=[];
	for(var i=0;i<selected.length;i++)
	{
		delId[i]=selected[i].get('applyId')
	}
	command.setParameter("delIds",delId);
	command.execute("ywhf");
	if (!command.error) {
   		var text = '困难户信息查询';
   		L5.Msg.alert("提示","保存成功！",hide());
   		lod();
	}else{
		L5.Msg.alert("错误",command.error);
	}
}
//点击查询按钮 传递的参数设置
function query(){
	var ds =L5.DatasetMgr.lookup("ds");
	ds.setParameter("sam_apply.APPLY_PEOPLE@=",getParam("qapplyPeople"));		
	ds.setParameter("sam_apply.APPLY_DATE@>=",getParam("qapplyDate"));	
	ds.setParameter("sam_apply.APPLY_DATE@<=",getParam("qapplypeopleqend"));
	ds.setParameter("sam_apply.APPLY_WAY@=",getParam("qapplyWay"));		
	ds.setParameter("sam_apply.HANDLE_SIGN@=",getParam("qhandleSign"));		
	lod();
}


//双击侦听事件调用的函数 及点击查看明细时调用的函数
function griddbclick(grid,index,e){
var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert("提示","请选择一条记录查询！");
		return false;
	}
	var win=L5.getCmp('mingxi');
	win.show(grid.el.dom);
	
}
/** 查询历史明细按钮的处理函数。
 */
function ywlsQuery(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert("提示","请选择一条记录查询！");
		return false;
	}
	var data = new L5.Map();
	data.put("applyId",selected[0].get('applyId'));
	data.put("returnPage","consultList.jsp");
	var url='jsp/sdmz/apply/applyHistory.jsp';
	var text = '';
	L5.forward(url,text,data);
}