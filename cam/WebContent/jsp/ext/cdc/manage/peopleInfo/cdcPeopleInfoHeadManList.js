function init(){
	var cdcPeopleInfoDataSet=L5.DatasetMgr.lookup("cdcPeopleInfoDataSet");
	cdcPeopleInfoDataSet.setParameter("IF_GROUP_HEADMAN@=","1");
	cdcPeopleInfoDataSet.setParameter("ORGAN_CODE@=",organCode);
	cdcPeopleInfoDataSet.load();
}
function query(){
	var cdcPeopleInfoDataSet=L5.DatasetMgr.lookup("cdcPeopleInfoDataSet");
	cdcPeopleInfoDataSet.setParameter("IF_GROUP_HEADMAN@=","1");
	cdcPeopleInfoDataSet.setParameter("ORGAN_CODE@=",organCode);
	cdcPeopleInfoDataSet.setParameter("NAME@Like",getParam("query_name"));
	cdcPeopleInfoDataSet.load();
}
function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function insert(){
	var data=new L5.Map();
	data.put("method","INSERT");
	var url="jsp/ext/cdc/manage/peopleInfo/cdcPeopleInfoHeadManEdit.jsp";
	L5.forward(url,'',data);
}
function update(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var data=new L5.Map();
	data.put("method","UPDATE");
	data.put("peopleId",records[0].get("peopleId"));
	var url="jsp/ext/cdc/manage/peopleInfo/cdcPeopleInfoHeadManEdit.jsp";
	L5.forward(url,'',data);
}
function detail(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var data=new L5.Map();
	data.put("peopleId",records[0].get("peopleId"));
	var url="jsp/ext/cdc/manage/peopleInfo/cdcPeopleInfoHeadManDetai.jsp";
	L5.forward(url,'',data);
}
function del(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length!=1){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	L5.MessageBox.confirm("提示", "是否删除该数据？",function(sta){
		if(sta=="yes"){
			var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcPeopleInfoCmd");
			command.setParameter("peopleId",records[0].get("peopleId"));
			command.execute("delete");
			if (!command.error){
				var cdcPeopleInfoDataSet=L5.DatasetMgr.lookup("cdcPeopleInfoDataSet");
				cdcPeopleInfoDataSet.load();
			}else{
				L5.Msg.alert("提示","删除出错！");
			}
		}
	});
}

function getAge(value,cellmeta,record,rowindex,colindex,dataset){
	if(value !=""){
		var time = new Date();
		var time_d = time.format("d");
		var time_m = time.format("m");
		var time_y = time.format("Y");
		var age_y = value.split('-')[0];
		var age_m = value.split('-')[1];
		if(age_m>time_m){
			return time_y-age_y-1;
		}else if(age_m=time_m){
			if(time_d>value.split('-')[2]){
				return time_y-age_y;
			}else{
				return time_y-age_y-1;
			}
		}else{
			return time_y-age_y;
		}
	}else{
		return ""
	}
}