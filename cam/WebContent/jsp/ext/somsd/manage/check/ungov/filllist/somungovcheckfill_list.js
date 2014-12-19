function init() {
	ds.setParameter("FILL_PEOPLE_ID", userId);
	ds.setParameter("SORG_TYPE", "M");
	ds.setParameter("BATCH_YEAR", year);
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
	ds.setParameter("BATCH_YEAR@=",getParam("batchYear"));		
	ds.setParameter("STATUS@=",getParam("status"));		
	ds.setParameter("SORG_TYPE@=","M");
	ds.setParameter("FILL_PEOPLE_ID@=",userId);
	//ds.setParameter("CHECK_YEAR", year);
	ds.load();
}

function insert() {
	var allrecords = ds.getAllRecords();
	/*
	for(i=0;i<allrecords.length;i++)
	{
		var record=allrecords[i];
		var status=record.get("status");
		if(status!='0' && status!='4'){
			L5.Msg.alert('提示',"已经存在上报的数据，不能继续增加年检数据!");
			return false;
		}
	}
	*/
	var data = new L5.Map();
	data.put("method","INSERT");
	var url='jsp/ext/somsd/manage/check/ungov/edit/ungovCheckEdit1.jsp';
	var text = '增加年检';
	L5.forward(url,text,data);
}

function update(){
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
	var url='jsp/ext/somsd/manage/check/ungov/edit/ungovCheckEdit1.jsp';
	var text = '修改年检';
	L5.forward(url,text,data);
}

function detail(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	var data = new L5.Map();
	data.put("method","DETAIL");
	data.put("taskCode",selected[0].get('taskCode'));
	var url='jsp/ext/somsd/manage/check/ungov/detail/ungovCheckDetail1.jsp';
	var text = '年检明细';
	L5.forward(url,text,data);
}
//上报功能
function report(){
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
		var cmd = new L5.Command("com.inspur.cams.sorg.check.manage.SomCheckManageCommand");
		cmd.setParameter("sorgType", "ungov_");
		cmd.setParameter("taskCode", selected[0].get('taskCode'));
		cmd.afterExecute = function(){
			var flag =cmd.getReturn('flag');
			if(flag == 'true'){
				var command = new L5.Command("com.inspur.cams.sorg.check.manage.SomCheckManageCommand");
				command.setParameter("taskCode", selected[0].get('taskCode'));
				command.setParameter("status", "1");
				command.execute("submit");
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



