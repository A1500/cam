function init(){
	var daiBanDataset = L5.DatasetMgr.lookup("daiBanDataset");
	daiBanDataset.setParameter("organCode",organCode);
	daiBanDataset.load();
}

//重置
function resetClick() {
	document.getElementById("queryCemeName").value = '';
	document.getElementById("queryTime").value = '';
	document.getElementById("checkResult").value = '';
}
function queryDaiban(){
	var daiBanDataset = L5.DatasetMgr.lookup("daiBanDataset");
	var queryCemeName=document.getElementById("queryCemeName").value;
	var queryTime=document.getElementById("queryTime").value;
	var checkResult=document.getElementById("checkResult").value;
	daiBanDataset.setParameter("Name",'%'+queryCemeName+'%');
	daiBanDataset.setParameter("queryTime",queryTime);
	daiBanDataset.setParameter("checkResult",checkResult);
	daiBanDataset.setParameter("organCode",organCode);
	daiBanDataset.load();
}

function detail(){
	var editGrid=L5.getCmp('daiBanTaskGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	var data = new L5.Map();
	data.put("method","DETAIL");
	data.put("organId",selected[0].get('ORGAN_ID'));
	data.put("recordId",selected[0].get('RECORD_ID'));
	data.put("scoreId",selected[0].get('SCORE_ID'));
	data.put("primaryKey",selected[0].get('CEME_APPLY_ID'));
	var url='jsp/cams/fis/wf/check/fisCemeYearlyCheckDetail.jsp';
	var text = '经营性公墓年检';
	L5.forward(url,text,data);
	
}

//新增年检,仅县级可用，弹出本级下的公墓名称
function add(){
	var CemeInfoDs = L5.DatasetMgr.lookup("CemeInfoDs");
	CemeInfoDs.setParameter("MANA_LEVEL_ID",organCode);
	CemeInfoDs.setParameter("PROP","1");
	CemeInfoDs.load(true);
	if(CemeInfoDs.getCount() == 0){
		L5.Msg.alert('提示', "该区划下没有可参检的公益性公墓信息!");
		return false;
	}
	var data = new L5.Map();
	if(organType=="13"){
		data.put("method","INSERT");
		data.put("prop","1");//公益性
		var url='jsp/cams/fis/wf/check/fisCheck.jsp';
		var text = '公益性公墓年检';
		L5.forward(url,text,data);
	}

}

//年检修改，判断是否县级 并且未上报
function edit(){
	var editGrid=L5.getCmp('daiBanTaskGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	//分析处理前状态4：未报，0：已报 2:市级驳回
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	if(organType=="13"){
		if(selected[0].get("IS_REPORT")=="4"){
			
			var data = new L5.Map();
			data.put("method","UPDATE");
			data.put("prop","1");
			data.put("taskCode",selected[0].get('CEME_APPLY_ID'));
			data.put("organId",selected[0].get('ORGAN_ID'));
			data.put("scoreId",selected[0].get('SCORE_ID'));
			var url='jsp/cams/fis/wf/check/fisCheck.jsp';
			var text = '经营性公墓年检';
			L5.forward(url,text,data);
		}else{
			L5.Msg.alert('提示',"该记录还没有进行检查!");
		}
	}
	if(selected[0].get("IS_REPORT")=="0"){
		L5.Msg.alert('提示',"已经上报，不能修改!");
		return false;
	}
	if(!(organType =="13")){
		L5.Msg.alert('提示',"非县级账号不可修改");
		return false;
	}
}
//公益性县级提交上级
function submit(){
	var editGrid=L5.getCmp('daiBanTaskGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	if(selected[0].get("IS_REPORT") == "0"){
		L5.Msg.alert('提示',"该记录已经上报成功!");
		return false;
	}
	
	var historyDataSet = L5.DatasetMgr.lookup("historyDataSet");
	historyDataSet.setParameter("CEME_APPLY_ID",selected[0].get("CEME_APPLY_ID"));
	historyDataSet.load(true);
	var historyRecord = historyDataSet.getCurrent();
	if(organType=="13"){
			L5.MessageBox.confirm('确定', '确定要上报选中的记录吗?上报后不可更改!',function(state){
				if(state=="yes"){
					var command=new L5.Command("com.inspur.cams.fis.base.cmd.FisCemeApplyInfoCmd");
					command.setParameter("record",selected[0]);
					command.setParameter("organType",organType);
					command.setParameter("hisRecord",historyRecord);
					command.setParameter("prop","1");
					command.execute("createAndSendYearlyCheck");
					if(!command.error){
						L5.Msg.alert('提示',"上报成功");
						init();
					}else{
						L5.Msg.alert('提示',"上报时出现错误！"+command.error);
					}
					
				}else{
					return false;
				}
			});
	}
}

function del(){
	var editGrid=L5.getCmp('daiBanTaskGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	
	if(!(organType =="13")){
		L5.Msg.alert('提示',"非县级账号不可删除");
		return false;
	}
	if(organType=="13"){
		if(selected[0].get("IS_REPORT")=="4") {
			L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
				if(state=="yes"){
					var taskCode=selected[0].get("CEME_APPLY_ID");
					var scoreId=selected[0].get("SCORE_ID");
					var command=new L5.Command("com.inspur.cams.fis.base.cmd.FisCemeApplyInfoCmd");
					command.setParameter("cemeApplyId",taskCode);
					command.setParameter("scoreId",scoreId);
					command.execute("deleteAll");
					if(!command.error){
						L5.Msg.alert('提示',"删除成功");
						init();
					}else{
						L5.Msg.alert('提示',"删除时出现错误！"+command.error);
					}
					
				}else{
					return false;
				}
			});
		}
		else{
			L5.Msg.alert('提示',"已经提交的业务不能删除！");
		}
	}
	
}

//选择公墓名称
function forCemeSelect(){
	var reValue = openCemeChoose();
	if (reValue != "" && reValue != undefined) {
		var arrs = reValue.split(",");
		document.getElementById("queryCemeName").value = arrs[1];
	}
}
function openCemeChoose(){
	return window.showModalDialog("../fisCemeInfomation.jsp?manaCode="+organCode+"&prop=1", "","dialogHeight:400px;dialogWidth:400px;resizable:yes;scroll:yes;status:no;");
}
