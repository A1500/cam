function init() {
	var geroApplyDs = L5.DatasetMgr.lookup("geroApplyDs");
	geroApplyDs.setParameter("areaLevelId",organCode);
	geroApplyDs.load();
}
function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	var geroApplyDs = L5.DatasetMgr.lookup("geroApplyDs");	
	geroApplyDs.setParameter("gerocomiumName",getParam("gerocomiumNameQuery"));	
	geroApplyDs.setParameter("clothDate",getParam("clothDateQuery"));
	geroApplyDs.setParameter("clothType",getParam("clothTypeQuery"));
	geroApplyDs.setParameter("areaLevelId",organCode);	
	geroApplyDs.load();
}
function resetQ(){
	document.getElementById("gerocomiumName").reset();
	document.getElementById("clothDate").reset();
	document.getElementById("manaLevel").value=organName;
	document.getElementById("manaLevelId").value=organCode;
}
//新增发放计划
function openApplyWin(){
	//var geroApplyDs = L5.DatasetMgr.lookup("geroApplyDs");
	//geroApplyDs.removeAll();
	//geroApplyDs.newRecord({"pocketStatus":"00","areaLevelId":organArea,applyType:"02","areaLevelId":organArea,"areaLevelId":organArea,"areaLevelId":organName});//默认状态为名册生成中
	var win = L5.getCmp("applyWin");
	win.show();
	document.getElementById("gerocomiumName").value='';
	document.getElementById("clothDate").value='';
	document.getElementById("clothNum").value='';
	document.getElementById("clothType").value='';
	var samGeroDataSet=L5.DatasetMgr.lookup("samGeroDataSet");
	if(organArea.substr(2,10)=="0000000000"){
		samGeroDataSet.setParameter("filterSql","SUBSTR(AREA_LEVEL_ID,1,2) LIKE '%" + organArea.substring(0, 2) + "%' AND IF_CURRENT='1'");
	}else if(organArea.substr(4,8)=="00000000"){
		samGeroDataSet.setParameter("filterSql","SUBSTR(AREA_LEVEL_ID,1,4) LIKE '%" + organArea.substring(0, 4) + "%' AND IF_CURRENT='1'");
	}else if(organArea.substr(6,6)=="000000"){
		samGeroDataSet.setParameter("filterSql","SUBSTR(AREA_LEVEL_ID,1,6) LIKE '%" + organArea.substring(0, 6) + "%' AND IF_CURRENT='1'");
	}
	samGeroDataSet.load();
}
//检查敬老院供养人员是否为空
var flag=true;//敬老院是否有在院供养对象的标志
function testCheck(){
	var gerocomiumName=document.getElementById("gerocomiumName").value;
	var keptPersonDs=L5.DatasetMgr.lookup("keptPersonDs");
	keptPersonDs.setParameter("GEROCOMIUM_ID@=",gerocomiumName);
	keptPersonDs.setParameter("IS_STATUS@=","1");
	keptPersonDs.load();
	keptPersonDs.on('load',function(){
		if(keptPersonDs.getCount()==0){
			L5.Msg.alert("提示","此敬老院无供养对象！");
			flag=false;
			return ;
		}else{
			flag=true;
		}
	});
}
//保存发放计划
function saveApply(){	
	var gerocomiumName= getParam("gerocomiumName");
	var clothDate= getParam("clothDate");
	//var pocketStatus= getParam("pocketStatus");
	var clothNum= getParam("clothNum");
	var clothType= getParam("clothType");
	if(gerocomiumName==""||gerocomiumName==null){
		L5.Msg.alert('提示',"敬老院不能为空！");
		return;
	}
	if(clothDate==""||clothDate==null){
		L5.Msg.alert('提示',"发放日期不能为空！");
		return;
	}
	if(clothNum==""||clothNum==null){
		L5.Msg.alert('提示',"发放套数不能为空！");
		return;
	}
	if(clothType==""||clothType==null){
		L5.Msg.alert('提示',"发放套数不能为空！");
		return;
	}
	if(flag==false){
		L5.Msg.alert("提示","此敬老院无供养对象！");
		return ;
	}
	var geroApplyDs=L5.DatasetMgr.lookup("geroApplyDs");
	var records=geroApplyDs.getAllRecords();
	if(records.length!=0){
		for(var i=0;i<records.length;i++){
			if(records[i].get("GEROCOMIUM_ID")==gerocomiumName && records[i].get("CLOTH_DATE")==clothDate){
				L5.Msg.alert("提示","名册已登记！");
				return;
			}
		}
	}
	var command=new L5.Command("com.inspur.cams.drel.samu.cmd.SamGeroApplyCmd");
	command.setParameter("gerocomiumName", gerocomiumName);
	command.setParameter("clothDate", clothDate);
	//command.setParameter("pocketStatus", pocketStatus);
	command.setParameter("clothNum", formatNum(clothNum));
	command.setParameter("clothType", clothType);
	command.execute("insertSaveCloth");
	if (!command.error) {
		L5.Msg.alert('提示',"保存成功！",function(){
			closeApplyWin();
			
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
//关闭增加窗口
function closeApplyWin(){
	var win = L5.getCmp("applyWin");
	win.setVisible(false);
	query();
}
//维护名册
function chooseAssPeople(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}

	if(selected[0].get("CLOTH_STATUS")=="1"){
		L5.Msg.alert('提示',"名册已确认，不能继续维护!");
		return false;
	}
	openChooseAssWin(selected[0]);
}
function openChooseAssWin(rec){
var width = screen.width-200;
    var height = 492;
	var url = "clothApplyDetailEdit.jsp?GEROCOMIUM_ID="+rec.get('GEROCOMIUM_ID')+"&CLOTH_DATE="+rec.get("CLOTH_DATE")+"&CLOTH_TYPE="+rec.get('CLOTH_TYPE')+"&CLOTH_STATUS="+rec.get('CLOTH_STATUS');
	var win = window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");

}


//确认名册
function confirmApply(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	
	if(selected[0].get("CLOTH_STATUS")=="1"){
		L5.Msg.alert('提示',"名册已确认，请不需要重复确认!");
		return false;
	}
	L5.MessageBox.confirm('确定', '名册确认后不能修改，确定要确认名册吗？', function(state) {
		if(state=="yes"){
			var command=new L5.Command("com.inspur.cams.drel.samu.cmd.SamGeroApplyCmd");
			command.setParameter("gerocomiumId", selected[0].get('GEROCOMIUM_ID'));
			command.setParameter("clothDate", selected[0].get('CLOTH_DATE'));
			command.setParameter("clothStatus", selected[0].get('CLOTH_STATUS'));
			command.execute("confirmCloth");
			if (!command.error) {
				L5.Msg.alert('提示',"名册已确认！");
				geroApplyDs.reload();
			}else{
				L5.Msg.alert('提示',"确认时出现错误！"+command.error);
			}
		}else{
			return false;
		}
	});
//	var width = screen.width-200;
//    var height = 400;
//	var url = "samReleaseDetaiConfirm.jsp?releaseId="+selected[0].get('releaseId');
//	var win = window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
}
//删除名册
function del(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	//校验，已确认的名册不能删除
	if(selected[0].get("CLOTH_STATUS")=="1"){
		L5.Msg.alert('提示',"名册已确认，不能删除!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var command=new L5.Command("com.inspur.cams.drel.samu.cmd.SamGeroApplyCmd");
			command.setParameter("gerocomiumId", selected[0].get('GEROCOMIUM_ID'));
			command.setParameter("clothDate", selected[0].get('CLOTH_DATE'));
			command.setParameter("clothStatus", selected[0].get('CLOTH_STATUS'));
			command.execute("deleteCloth");
			if (!command.error) {
				for(var i=0;i<selected.length;i++){
			    	geroApplyDs.remove(selected[i]);
				}
				geroApplyDs.commitChanges();
			}else{
				L5.Msg.alert('提示',"保存时出现错误！"+command.error);
			}
		}else{
			return false;
		}
	});
}
function detailRender(value, cellmeta, record, rowindex, colindex, dataset) {
	return '<a href="javascript:detail(\'' + record.get('GEROCOMIUM_ID')+'\',\''+ record.get('CLOTH_DATE')+'\',\''+ record.get('CLOTH_STATUS') + '\')">'
			+ value + '</a>';
}
// 查看明细
function detail(gerocomiumId,clothDate,clothStatus) {
	var width = screen.width - 200;
	var height = 492;
	var url = "clothApplyDetail.jsp?gerocomiumId=" + gerocomiumId+"&clothDate="+clothDate+"&clothStatus="+clothStatus;
	var win = window.showModalDialog(url, window,
			"scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:1");
}
//弹出敬老院
function func_ForGeroSelect(){
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/drel/samu/geroTree/geroTree.jsp?radioMaxlevel=0&organCode="
					+ organArea + "&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("gerocomiumIdQuery").value = list[0];
		document.getElementById("gerocomiumNameQuery").value = list[1];
	}
}