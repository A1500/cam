/**
 * @title:
 * @description:初始化的时候根据行政区划进行过滤 上级看下级
 * @author:
 * @since:2011-06-08
 * @version:1.0
*/

function init() {
	var grid=L5.getCmp('editGridPanel');
	//给grid增加双击侦听事件。
	grid.on("rowdblclick",griddbclick);
	L5.QuickTips.init();
	//L5.DatasetMgr.lookup("ds").load();
	var ds =L5.DatasetMgr.lookup("ds");
	if(organArea.substring(4,12)=="00000000")
	{	
		var organArea1=organArea.substring(0,4);
		ds.setParameter("SAM_APPLY.CURRENT_ORG_AREA@like",organArea1);		
	}else if(organArea.substring(6,12)=="000000")
	{
		 var organArea1=organArea.substring(0,6);
		 ds.setParameter("SAM_APPLY.CURRENT_ORG_AREA@like",organArea1);
	}
	else if(organArea.substring(9,12)=="000")
	{
		var  organArea1=organArea.substring(0,9);
		 ds.setParameter("SAM_APPLY.CURRENT_ORG_AREA@like",organArea1);
	}else if(!organArea.substring(9,12)=="000")
	{
		var organArea1=organArea;
		 ds.setParameter("SAM_APPLY.CURRENT_ORG_AREA@like",organArea1);
	}
	ds.load();
}
//加载的时根据登录单位的行政区划过滤 ：上级看到下级

function load(){
	var ds =L5.DatasetMgr.lookup("ds");
	if(organArea.substring(4,12)=="00000000")
	{	
		var organArea1=organArea.substring(0,4);
		
		ds.setParameter("SAM_APPLY.CURRENT_ORG_AREA@like",organArea1);		
		
	}else if(organArea.substring(6,12)=="000000")
	{
		
		 var organArea1=organArea.substring(0,6);
		
		 ds.setParameter("SAM_APPLY.CURRENT_ORG_AREA@like",organArea1);
	}
	else if(organArea.substring(9,12)=="000")
	{
		var  organArea1=organArea.substring(0,9);
		 ds.setParameter("SAM_APPLY.CURRENT_ORG_AREA@like",organArea1);
	}else if(!organArea.substring(9,12)=="000")
	{
		var organArea1=organArea;
		 ds.setParameter("SAM_APPLY.CURRENT_ORG_AREA@like",organArea1);
	}
	ds.load();
}
/**
 * @title:
 * @description:根据组件的Id得到组件的值；
 * @author:
 * @since:2011-06-08
 * @version:1.0
*/

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
/**
 * @title:
 * @description:点击查询按钮 ，赋予的过滤条件；
 * @author:
 * @since:2011-06-08
 * @version:1.0
*/

function query(){
	var ds =L5.DatasetMgr.lookup("ds");
	ds.setParameter("sam_apply.APPLY_PEOPLE@=",getParam("qapplyPeople"));	
	ds.setParameter("sam_apply.APPLY_DATE@>=",getParam("qapplyDate"));
	ds.setParameter("sam_apply.APPLY_DATE@<=",getParam("qapplypeopleqend"));
	ds.setParameter("sam_apply.APPLY_WAY@=",getParam("qapplyWay"));
	ds.setParameter("sam_apply.RETURN_VISIT@=",getParam("qReturnVisit"));	
	ds.setParameter("sam_apply.HANDLE_SIGN@=",getParam("qhandleSign"));		
	load();
}
/**
 * @title:
 * @description:双击事件触发的函数 显示明细窗口
 * @author:
 * @since:2011-06-08
 * @param
*/
function griddbclick(grid,index,e){
	var win=L5.getCmp('mingxi');
	win.show(grid.el.dom);
}
function mingxiWin(grid,index,e){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert("提示","请选择一条记录");
		return false;
	}else{
	var win=L5.getCmp('mingxi');
	win.show(grid.el.dom);
	}
}
/**
 * @title:
 * @description:点击回访按钮  
 * @author:
 * @since:2011-06-08
 * @param
*/
function hfwin(grid,index,e){
	var dsDataset = L5.DatasetMgr.lookup("ds");
	var dsRecord=dsDataset.getCurrent();
	//alert(dsRecord.get("applyPeople"));
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	var hfFlag=[];
	var blbzFlag=[];
    for(var i=0;i<selected.length;i++){
		hfFlag[i]=selected[i].get("returnVisit");
		blbzFlag[i]=selected[i].get("handleSign");
		if(hfFlag[i]=="1"){
		L5.Msg.alert("信息","已回访,请重新选择！");
		load();
		return;
		}else if(blbzFlag[i]!="2"){
			L5.Msg.alert("信息","未办理完结,请重新选择！");
			load();
			return;
		}
    }
    
	
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert("提示","请选择回访记录");
		return false;
	}else{var win=L5.getCmp('huifang');
	win.show(grid.el.dom);}
	
	
}
/**
 * @title:
 * @description:点击回访窗口的确定按钮的处理函数
 * @author:
 * @since:2011-06-08
 * @param
*/
function ywhf(){
	var hfDataset = L5.DatasetMgr.lookup("hfDataset");
	var hfRecord=hfDataset.getCurrent();
	var value=hfRecord.get("satisDegree");
	
	if(value==""){
		L5.Msg.alert("信息","请选择满意度！");
		return false;
	}
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	
	
	var applyIds=[];
	for(var i=0;i<selected.length;i++){
				applyIds[i]=selected[i].get("applyId");
			}
			var command=new L5.Command("com.inspur.sdmz.apply.cmd.SamApplySaveCmd"); 
			command.setParameter("ywhfRecord", hfRecord.toBean("com.inspur.sdmz.apply.data.SamApply"));
			command.setParameter("delIds", applyIds);
			command.execute("ywhf");
			if (!command.error) {
				L5.Msg.alert("信息","回访成功！");
				hide();
			}else{
				L5.Msg.alert("错误",command.error);
			}
	load();
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
	data.put("returnPage","assistanceList.jsp");
	var url='jsp/sdmz/apply/applyHistory.jsp';
	var text = '';
	L5.forward(url,text,data);
}
/**
 * @title:
 * @description:隐藏窗口函数
 * @author:
 * @since:2011-06-08
 * @param
*/
function hide()
{
var win=L5.getCmp('huifang');
win.hide();
}