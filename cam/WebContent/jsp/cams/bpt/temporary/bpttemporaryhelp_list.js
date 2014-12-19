function init() {
	query();
	hideButton("editGridPanel",[5],[],[1,2,4,5],[1,2,4,5]);
}
//根据区划级别隐藏按钮
function hideButton( grid,jbuts,qbuts,citybuts,sbuts){//街道,区县,市,省
	if(organType=='14'){//街道
		for(var i=0;i<jbuts.length;i++){
			L5.getCmp(grid).getTopToolbar().items.items[jbuts[i]].hide();
		}
	}else if(organType=='13'){//区县
		for(var i=0;i<qbuts.length;i++){
			L5.getCmp(grid).getTopToolbar().items.items[qbuts[i]].hide();
		}
	}else if(organType=='12'){//市
		for(var i=0;i<citybuts.length;i++){
			L5.getCmp(grid).getTopToolbar().items.items[citybuts[i]].hide();
		}
	}else if(organType=='11'){//省
		for(var i=0;i<sbuts.length;i++){
			L5.getCmp(grid).getTopToolbar().items.items[sbuts[i]].hide();
		}
	}
}

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	ds.setParameter("domicileCode",getParam("domicileCode"));
	ds.setParameter("objectType",getParam("objectType"));		
	ds.setParameter("helpType",getParam("helpType"));	
	ds.setParameter("submitFlag","0");		
	ds.setParameter("organCode",organCode);	
	ds.load();
}
/**
 * 所属机构窗口
 */
function forHelp(){
		//var struId='<%=struId%>';
		var revalue=window.showModalDialog(L5.webPath+"/jsp/bsp/organization/getselect_code.jsp?rootId="+struId+"&showOrganType=1&organType=1&isExact=0&isCheckBox=0&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
		
		if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
		document.getElementById("domicileCode").value = list[0];
		document.getElementById("domicileName").value = list[1];
		}
}
function insert() {
	/*var data = new L5.Map();
	data.put("method","INSERT");
	var url='jsp/cams/bpt/temporary/temporaryHelp.jsp';
	var text = '增加BPT_TEMPORARY_HELP';
	L5.forward(url,text,data);*/
	var width = screen.width-100;
    var height = screen.height-140;
	var url='temporaryHelpAdd.jsp?method=ADD';
	var winReturn = window.showModalDialog (url,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	if (winReturn!=""&winReturn!=undefined) {
		var list = winReturn.split(";");
		var applyId = list[2];
		var objectType = list[3];
		var peopleId = list[0];
		var familyId = list[1];
		var width = screen.width-100;
	    var height = screen.height-140;
		var url='peopleInfoDetail.jsp?peopleId='+peopleId+'&method=UPDATE&objectType='+objectType+'&applyId='+applyId+'&familyId='+familyId;
		var win = window.showModalDialog (url,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
		if (win=="createSend") {
			submitById(applyId);
		}
		query();
		return;
	}

}
function edit(){
    var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	/*var data = new L5.Map();
	data.put("method","DETAIL");
	data.put("id",selected[0].get("id"));
	var url='jsp/cams/bpt/temporary/bpttemporaryhelpDetail.jsp';
	var text = '修改BPT_TEMPORARY_HELP';
	L5.forward(url,text,data);*/
	var applyId=selected[0].get("APPLY_ID");
	 var objectType = selected[0].get('OBJECT_TYPE');
	var peopleId = selected[0].get('PEOPLE_ID');
	var familyId = selected[0].get('FAMILY_ID');
	var width = screen.width-100;
    var height = screen.height-140;
	var url='peopleInfoDetail.jsp?peopleId='+peopleId+'&method=UPDATE&objectType='+objectType+'&applyId='+applyId+'&familyId='+familyId;
	var win = window.showModalDialog (url,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	if (win=="createSend") {
		submit();
	}else{
		query();
		return;
	}
}

function detail(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	var applyId=selected[0].get("APPLY_ID");
	var objectType = selected[0].get('OBJECT_TYPE');
	var peopleId = selected[0].get('PEOPLE_ID');
	var familyId = selected[0].get('FAMILY_ID');
	var width = screen.width-100;
    var height = screen.height-140;
	var url='peopleInfoDetail.jsp?peopleId='+peopleId+'&method=DETAIL&objectType='+objectType+'&applyId='+applyId+'&familyId='+familyId;
	var win = window.showModalDialog (url,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	if (win==null) {
		return;
	}
}
function submit(){

	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	
	if(selected.length < 1) {
		L5.Msg.alert("提示","请选择要提交的记录");
		return false;
	}
	for(var i=0;i<selected.length;i++){
		var record=selected[i];
		if(!checkSubmit(record.get("APPLY_ID"))){
			return;
		}
	}
	L5.getCmp("submitButton").setDisabled(true);
	var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptTemporaryHelpCommand"); 
	command.setParameter("records",selected);
	command.execute("submit");	
	if (!command.error) {
		L5.Msg.alert('提示',"审批成功!",function(){
			query();
		});
	}else {
		L5.Msg.alert('提示',"审批时出现错误！"+command.error);
	}
	L5.getCmp("submitButton").setDisabled(false);
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
				delIds[i]=selected[i].get("APPLY_ID");
			}
			var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptTemporaryHelpCommand");
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

//插入时直接提交
function submitById(applyId){
	if(!checkSubmit(applyId)){
		return;
	}
	var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptTemporaryHelpCommand"); 
	command.setParameter("applyId",applyId);
	command.execute("submitById");	
	if (!command.error) {
		L5.Msg.alert('提示',"审批成功!",function(){
			query();
		});
	}else {
		L5.Msg.alert('提示',"审批时出现错误！"+command.error);
	}
}

function checkSubmit(applyId){	
	
	var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptTemporaryHelpCommand"); 
	command.setParameter("applyId",applyId);
	command.execute("queryAdvice");	
	
	var  flag = command.getReturn("flag");
	
	//var verifyAdvice = record.get("VERIFY_ADVICE");
	if(!flag){
		L5.Msg.alert("提示","请先填写县级审批意见！");
		return false;
	}
	return true;
}