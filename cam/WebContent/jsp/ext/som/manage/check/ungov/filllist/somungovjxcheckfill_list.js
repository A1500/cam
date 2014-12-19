function init() {
	ds.setParameter("FILL_PEOPLE_ID", userId);
	ds.setParameter("SORG_TYPE", "M");
	ds.setParameter("CHECK_YEAR", year);
	ds.load();
	dsOnload();
};
function dsOnload(){
	ds.on('load',function(){
		ds.each(function(record, index){
				if(record.get('status') != "8"){
					record.set("checkResult","");
				}
			});
	});
	ds.commitChanges();
}
function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	if( ifFreeze == '1'){
		L5.Msg.alert('提示',"您的账户已被冻结！\n请电话联系省民管局工作人员。");
		return false;
	}
	ds.setParameter("SOM_JX_CHECK.CHECK_YEAR@=",getParam("batchYear"));		
	ds.setParameter("SOM_JX_CHECK.SORG_TYPE@=","M");
	ds.setParameter("SOM_JX_CHECK.FILL_PEOPLE_ID@=",userId);
	//ds.setParameter("CHECK_YEAR", year);
	ds.load();
}

function insert() {
	if( ifFreeze == '1'){
		L5.Msg.alert('提示',"您的账户已被冻结！\n请电话联系省民管局工作人员。");
		return false;
	}
	var allrecords = ds.getAllRecords();
	for(i=0;i<allrecords.length;i++)
	{
		var record=allrecords[i];
		var checkY= record.get('checkYear');
		if(year == checkY){
			L5.Msg.alert('提示',"您已经填写了一条年检信息，不能继续增加年检信息!");
			return false;
		}
	}
	var data = new L5.Map();
	data.put("method","INSERT");
	var url='jsp/ext/som/manage/check/ungov/edit/ungovJXCheckEdit1.jsp';
	var text = '增加年检';
	L5.forward(url,text,data);
}

function update(){
	if( ifFreeze == '1'){
		L5.Msg.alert('提示',"您的账户已被冻结！\n请电话联系省民管局工作人员。");
		return false;
	}
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	if(selected[0].get('status')!='0' && selected[0].get('status')!='4'){
		L5.Msg.alert('提示',"已经上报的数据不能修改!");
		return false;
	}
	var data = new L5.Map();
	data.put("method","UPDATE");
	data.put("taskCode",selected[0].get('taskCode'));
	var url='jsp/ext/som/manage/check/ungov/edit/ungovJXCheckEdit1.jsp';
	var text = '修改年检';
	L5.forward(url,text,data);
}

function detail(){
	if( ifFreeze == '1'){
		L5.Msg.alert('提示',"您的账户已被冻结！\n请电话联系省民管局工作人员。");
		return false;
	}
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	var data = new L5.Map();
	data.put("method","DETAIL");
	data.put("taskCode",selected[0].get('taskCode'));
	var url='jsp/ext/som/manage/check/ungov/detail/ungovJXCheckDetail1.jsp';
	var text = '年检明细';
	L5.forward(url,text,data);
}
function print(){
	if( ifFreeze == '1'){
		L5.Msg.alert('提示',"您的账户已被冻结！\n请电话联系省民管局工作人员。");
		return false;
	}
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	var command = new L5.Command("com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckCommand");
	command.setParameter("taskCode",selected[0].get('taskCode'));
	command.execute("printCheck");
	var flag= command.getReturn("flag");
	if(flag == "Y"){
		var data = new L5.Map();
		data.put("method","DETAIL");
		data.put("taskCode",selected[0].get('taskCode'));
		var url='jsp/ext/som/manage/check/ungov/print/ungovJXCheckPrint1.jsp';
		var text = '年检明细';
		L5.forward(url,text,data);
	}else{
		L5.Msg.alert("提示",flag);
		return;
	}
}
function printNull(){
	if( ifFreeze == '1'){
		L5.Msg.alert('提示',"您的账户已被冻结！\n请电话联系省民管局工作人员。");
		return false;
	}
	var data = new L5.Map();
	data.put("method","DETAIL");
	data.put("taskCode",'null');
	var url='jsp/ext/som/manage/check/ungov/print/ungovJXCheckPrint1.jsp';
	var text = '年检明细';
	L5.forward(url,text,data);
}
//上报功能
function report(){
	if( ifFreeze == '1'){
		L5.Msg.alert('提示',"您的账户已被冻结！\n请电话联系省民管局工作人员。");
		return false;
	}
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录进行上报!");
		return false;
	}
	var allrecords = ds.getAllRecords();
	
	for(i=0;i<allrecords.length;i++)
	{
		var record=allrecords[i];
		var status=record.get("status");
		if(status!='0' && status!='4'){
			L5.Msg.alert('提示',"已经存在上报的数据，不能继续上报年检数据!");
			return false;
		}
	}
	
	if(selected[0].get('status')=='0' || selected[0].get('status')=='4'){
		var cmd = new L5.Command("com.inspur.cams.sorg.jxcheck.manage.SomJxCheckManageCommand");
		cmd.setParameter("sorgType", "ungov_");
		cmd.setParameter("taskCode", selected[0].get('taskCode'));
		//cmd.setParameter("taskCode","8a898b9635f6b4990135f6b499b80000");
		cmd.afterExecute = function(){
			var flag =cmd.getReturn('flag');
			if(flag == 'true'){
				var command = new L5.Command("com.inspur.cams.sorg.jxcheck.manage.SomJxCheckManageCommand");
				command.setParameter("taskCode", selected[0].get('taskCode'));
				command.setParameter("status", "1");
				command.execute("updateStatus");
				if (!command.error) {
					L5.Msg.alert("提示","上报后，请及时注意校对结果。\n如果校对通过，请打印纸制年检报告书一式三份，\n报业务主管单位初审盖章后，携财务审计报告到省民政厅盖章！\n如果校对不通过，请电话联系省民管局工作人员。",function(){
						L5.Msg.alert('提示',"上报成功!",function (){
							init();
						});
					});				
				}else{
					L5.Msg.alert('提示',"上报时出现错误！"+command.error);
				}
			}else{
				L5.Msg.alert('提示',flag+"无法上报！");
			}
		};
		cmd.execute("queryForReport");
	}else{
		L5.Msg.alert('提示',"该数据不能上报!");
		return false;
	}
}
function del(){
	if( ifFreeze == '1'){
		L5.Msg.alert('提示',"您的账户已被冻结！\n请电话联系省民管局工作人员。");
		return false;
	}
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var  delIds=[];
			for(var i=0;i<selected.length;i++){
				delIds[i]=selected[i].get("taskCode");
			}
			var command=new L5.Command("com.inspur.cams.sorg.check.somcheck.cmd.SomCheckCommand");
			command.setParameter("delIds", delIds);
			command.execute("delete");
			if (!command.error) {
				for(var i=0;i<selected.length;i++){
			    	ds.remove(selected[i]);
				}
				ds.commitChanges();
			}else{
				L5.Msg.alert('提示',"删除时出现错误！"+command.error);
			}
		}else{
			return false;
		}
	});
}
function clickShowHref(value,cellmeta,record,rowindex,colindex,dataset){
	if(record.get("status")=="4"){
		return '<a href="javascript:clickShow(\''+rowindex+'\')">' + '点击查看' + '</a>';
	}else{
		return '';
	}
}
function clickShow(index){
    var record= ds.getAt(index);
	var correctNotReason = record.get("correctNotReason");
	var win = L5.getCmp("correctNotPassReasonWin");
	win.show();
	document.getElementById("correctNotReason").value=correctNotReason;
}
function closeCorrectNotPassReasonWin(){
	var win = L5.getCmp("correctNotPassReasonWin");
	win.hide();
}
function changeColor(value,cellmeta,record,rowindex,colindex,dataset){
	var returnText = "";
	somCheckStatus.each(function(record){
		if(value && value==record.get("value")){
			returnText = record.get("text");
			return false;
		}		
	});
	if(value=="4"){
		return "<label style='color:red'>"+returnText+"</label>";
	}else{
		return returnText;
	}
}
function changeStatus1(value,cellmeta,record,rowindex,colindex,dataset){
	if(record.get('status') == '0'){
		return "未上报";
	}else{
		return "已上报";
	}
}
function changeStatus2(value,cellmeta,record,rowindex,colindex,dataset){
	if(record.get('status') == '3' || record.get('status') == '8'){
		return "校对通过";
	}else if(record.get('status') == '4'){
		return "<label style='color:red'>校对不通过</label>";
	}else{
		return "未校对";
	}
}


