function init() {
	var cdcNoticeDataset=L5.DatasetMgr.lookup("cdcNoticeDataset");
	cdcNoticeDataset.setParameter("organCode",organCode);
	cdcNoticeDataset.setParameter("level",organLevel);
	cdcNoticeDataset.load();
	L5.QuickTips.init();
}

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	var cdcNoticeDataset=L5.DatasetMgr.lookup("cdcNoticeDataset");	
	cdcNoticeDataset.setParameter("organCode",organCode);
	cdcNoticeDataset.setParameter("name",getParam("name"));
	cdcNoticeDataset.setParameter("createTime",getParam("createTime"));
	cdcNoticeDataset.setParameter("level",organLevel);	
	cdcNoticeDataset.setParameter("organName",getParam("organName"));	
	cdcNoticeDataset.load();
}
function queryN(){
	var cdcNoticeDataset=L5.DatasetMgr.lookup("cdcNoticeDataset");	
	cdcNoticeDataset.setParameter("organCode",organCode);
	cdcNoticeDataset.setParameter("name",getParam("name"));
	cdcNoticeDataset.setParameter("flag",getParam("noticeFlag"));	
	cdcNoticeDataset.setParameter("create_Time",getParam("createTime"));	
	cdcNoticeDataset.load();
}
function reset(){
	document.getElementById("noticeFlag").value = "";
	document.getElementById("name").value = "";
	document.getElementById("noticeFlag").value = "";
	document.getElementById("createTime").value = "";
	document.getElementById("organArea").value = "";
}
function resetN(){
	document.getElementById("noticeFlag").value = "";
	document.getElementById("name").value = "";
	document.getElementById("noticeFlag").value = "";
	document.getElementById("createTime").value = "";
	document.getElementById("organArea").value = "";
}


function insertReport(){

	var data=new L5.Map();
	data.put("method","insert");
	data.put("noticeType",'2');
	var url="jsp/ext/cdc/manage/reportAndNotice/cdcReportNoticeEdit.jsp";
	L5.forward(url,'',data);
}
function insertNotice(){

	var data=new L5.Map();
	data.put("method","insert");
	data.put("noticeType",'1');
	var url="jsp/ext/cdc/manage/reportAndNotice/cdcReportNoticeEdit.jsp";
	L5.forward(url,'',data);
}
function update(){
	var grid=L5.getCmp("editGridPanel");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	if(records[0].get("status")=="1"){
		L5.Msg.alert("提示","已经上报，不允许修改!");
		return;
	}
	var data=new L5.Map();
	data.put("method","update");
	data.put("noticeId",records[0].get("NOTICE_ID"));
	var url="jsp/ext/cdc/manage/reportAndNotice/cdcReportNoticeEdit.jsp";
	L5.forward(url,'',data);
}
function detail(){
	var grid=L5.getCmp("editGridPanel");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var cdcNoticeCheckDataset=L5.DatasetMgr.lookup("cdcNoticeCheckDataset");
	cdcNoticeCheckDataset.setParameter("ORGAN_CODE@=",organCode);
	cdcNoticeCheckDataset.setParameter("NOTICE_ID@=",records[0].get("NOTICE_ID"));
	cdcNoticeCheckDataset.on("load",function(){
		if(cdcNoticeCheckDataset.getCount()<=0){
			cdcNoticeCheckDataset.newRecord({"organCode":organCode,"organName":organName,"noticeId":records[0].get("NOTICE_ID"),
				"createTime":getCurDate()});
			var record = cdcNoticeCheckDataset.getCurrent();
			var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcNoticeCheckCommand");
			command.setParameter("record",record);
			command.execute("save");
		}
		var data=new L5.Map();
		data.put("noticeId",records[0].get("NOTICE_ID"));
		data.put("fileId",records[0].get("FILE_ID"));
		var url="jsp/ext/cdc/manage/reportAndNotice/cdcNoticeDetail.jsp";
		L5.forward(url,'',data);
	});
	cdcNoticeCheckDataset.load();
}
function report(){
	var grid=L5.getCmp("editGridPanel");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	if(records[0].get("flag")=="2"){
		L5.Msg.alert("提示","该数据已经上报!");
		return;
	}
	L5.MessageBox.confirm("提示", "是否上报该数据？",function(sta){
		if(sta=="yes"){
			var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcNoticeInfoCmd");
			command.setParameter("record", records[0]);
			command.execute("report");
			if (!command.error){
				L5.Msg.alert("提示","上报成功！");
				query();
			}else{
				L5.Msg.alert("提示","上报出错！");
			}
		}
	});
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
			var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcNoticeInfoCmd");
			command.setParameter("records", selected);
			command.execute("delete");
			if (!command.error) {
				var cdcNoticeDataset=L5.DatasetMgr.lookup("cdcNoticeDataset");
				for(var i=0;i<selected.length;i++){
			    	cdcNoticeDataset.remove(selected[i]);
				}
				cdcNoticeDataset.commitChanges();
			}else{
				L5.Msg.alert('提示',"删除时出现错误！"+command.error);
			}
		}else{
			return false;
		}
	});
}

/**
 * 所属机构窗口
 */
function forHelp(){
		//var struId='<%=struId%>';
		var revalue=window.showModalDialog("../../../../../jsp/bsp/organization/getselect_code.jsp?rootId="+struId+"&showOrganType=11,12,13&organType=0&isExact=1&isCheckBox=0&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
		
		if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
		document.getElementById("domicileCode").value = list[0];
		document.getElementById("domicileName").value = list[1];
		}
}
