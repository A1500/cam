function init() {
	var currentDate = getCurDate().substr(0,4);
	document.getElementById("startYear").value = currentDate +'-01-01';
	document.getElementById("endYear").value = currentDate +'-12-31';
	if(organType!='13'){
	      document.getElementById("insert").style.visibility="hidden";
	      document.getElementById("update").style.visibility="hidden";
	      document.getElementById("delete").style.visibility="hidden";
	      document.getElementById("grantConfirm").style.visibility="hidden";
	      return false;
	   }
	L5.QuickTips.init();
};

//确认发放
function grantConfirm(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
       L5.Msg.alert('提示',"请选择一条记录!");
	   return false;
	}
	if(!totalCancel(selected[0].get("registerName"))){
		return false;
	}
	var grantSureDate = selected[0].get('grantSureDate');
	if(grantSureDate!=''){
		L5.Msg.alert('提示',"此条记录已确认！");
		return false;
	}
	selected[0].set('grantSureDate',getCurDate());
	var DisabilityGrantSumDataset = L5.DatasetMgr.lookup("ds");
	var win = L5.getCmp("grantConfirmWindow");
	win.show(this);
}

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	return value;
}
function query(){
	var startYear = getParam("startYear");
	var endYear = getParam("endYear");
    if(startYear==""&&endYear =="")
	{
		L5.Msg.alert('提示',"请输入发放日期 起、至 时间!");
	   	return false;
	}
	if(startYear!=''&&!validateDateFormat(startYear)){
		L5.Msg.alert("提示","发放日期(起)格式不正确！");
		return false;
	}
	if(endYear!=''&&!validateDateFormat(endYear)){
		L5.Msg.alert("提示","发放日期(止)格式不正确！");
		return false;
	}
	ds.setParameter("organCode",getParam("domicileCode"));
	ds.setParameter("userOrganCode",organCode);		
	ds.setParameter("startDate",getParam("startYear"));		
	ds.setParameter("endDate",getParam("endYear"));
	ds.setParameter("registerType","41");		
	ds.load();
	noReclick(ds,"search");//防止重复提交
}

//明细
function detail(){
    var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
       L5.Msg.alert('提示',"请选择一条记录!");
	   return false;
	}
	if(!totalCancel(selected[0].get("registerName"))){
		return false;
	}
	var width = screen.width-200;
    var height = screen.height-200;
    var registerId = selected[0].get('registerId');
	var url = "demobilizedDetail.jsp?registerId="+registerId;
	var win = window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
	init();
}

function changeDetail(){
    var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
       L5.Msg.alert('提示',"请选择一条记录!");
	   return false;
	}
	if(!totalCancel(selected[0].get("registerName"))){
		return false;
	}
	var width = screen.width-200;
    var height = screen.height-200;
    var registerId = selected[0].get('registerId');
	var url = "grantChangeDetail.jsp?registerId="+registerId;
	var win = window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
	init();
}

function insert() {
	var width = screen.width-200;
    var height = screen.height-200;
	var url = "demobilizedAdd.jsp?method=INSERT";
	var win = window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
	init();
}

//修改
function update(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	if(!totalCancel(selected[0].get("registerName"))){
		return false;
	}
	var grantSureDate = selected[0].get('grantSureDate');
	if(grantSureDate!=''){
		L5.Msg.alert('提示',"此条记录已确认，不能修改！");
		return false;
	}
	var width = screen.width-200;
    var height = screen.height-200;
    var registerId = selected[0].get('registerId');
	var url = "demobilizedEdit.jsp?method=UPDATE&registerId="+registerId;
	var win = window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
	init();
}

function del(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	if(!totalCancel(selected[0].get("registerName"))){
		return false;
	}
	for(var i=0;i<selected.length;i++){
		var grantSureDate = selected[i].get('grantSureDate');
		if(grantSureDate!=''){
			L5.Msg.alert('提示',"所选记录已确认，不能删除！");
			return false;
		}
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var  delIds=[];
			for(var i=0;i<selected.length;i++){
				delIds[i]=selected[i].get("registerId");
			}
			var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptCapitalSummaryCommand");
			command.setParameter("delIds", delIds);
			command.execute("delete");
			if (!command.error) {
				for(var i=0;i<selected.length;i++){
			    	ds.remove(selected[i]);
				}
				ds.commitChanges();
			}else{
				L5.Msg.alert('提示',"保存时出现错误！"+command.error);
			}
		}else{
			return false;
		}
	});
}

//确认发放保存
function grantConfirmSave(){
	var grantSureDate = _$("grantSureDate");
	var feedbackNumber = _$("feedbackNumber");
	var grantMonSum = _$("grantMonSum");
	if(grantSureDate==''){
		L5.Msg.alert("提示","确认日期不能为空！");
		return false;
	}
	if(feedbackNumber==''){
		L5.Msg.alert("提示","对账单编号不能为空！");
		return false;
	}
	if(grantMonSum==''){
		L5.Msg.alert("提示","发放资金总额不能为空！");
		return false;
	}
	if(!isFloat(grantMonSum)){
		L5.Msg.alert("提示","发放资金总额必须为数字！");
		return false;
	}
	var GrantSureRecord = ds.getCurrent();
	var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptCapitalSummaryCommand");
	command.setParameter("record",GrantSureRecord);
	command.execute("grantSumConfirm");
	if (!command.error) {
		var win = L5.getCmp("grantConfirmWindow");
		win.hide(this);
		query();
	}else{
		L5.MessageBox.alert('警告',command.error);
	}
}

//确认发放关闭
function grantConfirmClose(){
	var DisabilityGrantSumDataset = L5.DatasetMgr.lookup("ds");
	var win = L5.getCmp("grantConfirmWindow");
	win.hide(this);
	query();
}

/**
 * 跳入导入excel页面
 */
function impExcel() {
	var url=L5.webPath+"/jsp/cams/bpt/capital/excel/imp_disablity.jsp?registerType=41" ;
	var width = screen.width-100;
   	var height = screen.height-140;
   	var msg = window.showModalDialog (url,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	query();
}

//导出Excel
function expExcel(){
	var DemobilizedExportDataset = L5.DatasetMgr.lookup("DemobilizedExportDataset");
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	if(!totalCancel(selected[0].get("registerName"))){
		return false;
	}
	var registerId = selected[0].get('registerId'); 
	DemobilizedExportDataset.setParameter("registerId",registerId);
	DemobilizedExportDataset.load();
	DemobilizedExportDataset.on("load",function(){
		L5.dataset2excel(DemobilizedExportDataset,"/jsp/cams/bpt/capital/writeregister/demobilizedgrant/expDemoGrantToExcel.jsp?pageIndex="+ds.pageInfo.pageIndex);
	});
}