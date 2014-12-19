function init() {
	var ds = L5.DatasetMgr.lookup("ds");
	ds.baseParams["KS_SIGN@="]="0";//0:登记员
	ds.on("load", function onDsLoad() {
		if (ds.getTotalCount() == 0) {
			//L5.Msg.alert("提示", "无符合条件的结果！");
		}else {
			var qrToolbar = L5.getCmp("qrToolbar");
			qrToolbar.setText("合计：共" + ds.getTotalCount() + "期");
		}
	});
	ds.load();
//	L5.DatasetMgr.lookup("ndYearDataset").load();
	var ndYearDataset = L5.DatasetMgr.lookup("ndYearDataset");
	ndYearDataset.baseParams["filterSql"]=" ks_sign = '0'";//1:登记员
	ndYearDataset.load();
	L5.QuickTips.init();
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	ds.setParameter("MRM_EXAM_SCHEDULE.ND_YEAR@=",getParam("ndYear"));		
	ds.setParameter("MRM_EXAM_SCHEDULE.KSQS@=",getParam("ksqs"));		
	ds.setParameter("MRM_EXAM_SCHEDULE.KS_ADD@=",getParam("ksAdd"));
	ds.setParameter("MRM_EXAM_SCHEDULE.KS_SIGN@=",0);		
	ds.load();
}

function insert() {
	var data = new L5.Map();
	data.put("method","INSERT");
	var url='jsp/cams/marry/person/mrmexamschedule_edit.jsp';
	var text = '增加登记员资格考试安排表';
	L5.forward(url,text,data);

}

function update(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	var data = new L5.Map();
	data.put("method","UPDATE");
	data.put("dataBean",selected[0].get('ksapId'));
	var url='jsp/cams/marry/person/mrmexamschedule_edit.jsp';
	var text = '修改登记员资格考试安排表';
	L5.forward(url,text,data);
}

//开启
function startExam(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录开启!");
		return false;
	}
	var command=new L5.Command("com.inspur.cams.marry.base.cmd.MrmExamScheduleCommand"); 
	selected[0].set("ksYn","01");
	command.setParameter("record",selected[0]);
	command.execute("update");
	if (!command.error) {
		L5.Msg.alert('提示',"开启成功!");
		ds.load();
	}else{
		L5.Msg.alert('提示',"开启失败！"+command.error);
	}
}
//结束
function endExam(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录结束!");
		return false;
	}
	var command=new L5.Command("com.inspur.cams.marry.base.cmd.MrmExamScheduleCommand"); 
	selected[0].set("ksYn","02");
	command.setParameter("record",selected[0]);
	command.execute("update");
	if (!command.error) {
		L5.Msg.alert('提示',"结束成功!");
		;
	}else{
		L5.Msg.alert('提示',"结束失败！"+command.error);
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
				delIds[i]=selected[i].get("ksapId");
			}
			var command=new L5.Command("com.inspur.cams.marry.base.cmd.MrmExamScheduleCommand");
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

function detail(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	var data = new L5.Map();
	data.put("method","UPDATE");
	data.put("dataBean",selected[0].get('ksapId'));
	var url='jsp/cams/marry/person/mrmexamschedule_detail.jsp';
	var text = '修改登记员资格考试安排表';
	L5.forward(url,text,data);
}

function rest(){
	document.getElementById("ndYear").value = ''; 
	document.getElementById("ksqs").value = ''; 
	document.getElementById("ksAdd").value = ''; 
}


