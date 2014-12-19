
function init() {
	//L5.DatasetMgr.lookup("ds").load();
	query();
	L5.QuickTips.init();
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	var ds =L5.DatasetMgr.lookup("ds");
	ds.setParameter("PUB_STRU_TYPE.in_Use@=","1");
	ds.load();
}

function insert() {
	var record=ds.newRecord();
	record.set("inUse","1");
	record.set("isDefault","0");
	ds.moveLast();
	L5.getCmp("detail").hide();
	L5.getCmp("insert").show();

}

function del(){
	var list="";
	var userGrid=L5.getCmp('editGridPanel');
	//判断是否选择了要删除的记录
	var selected = userGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert(messTypePrompt,deletePleaseSelectData);
		return false;
	}else
	{
		//下面是一个提示框，如果用户点击是，那么就执行删除，否则不执行。
		L5.MessageBox.confirm(messType, deleteSelectDataMess,
			function(sta){
				if(sta=="yes"){
					for(var i=0;i<selected.length;i++){
						var record =selected[i];
						var recordState=record.state;
						if(recordState=="1"){//如果是新增加的记录，直接移除
							ds.remove(record);
							L5.Msg.alert('提示','删除成功!');
						}else{
							list=list+record.get("struType");
							if(i<selected.length-1)
							  list+=";";
						}
					}
				if(list!==""){
					var ids=list.split(";");
					var command = new L5.Command("org.loushang.bsp.organization.cmd.PubStruTypeCommand");
					command.setParameter("ids",ids);
					command.execute("delete");
					//init();
					if(!command.error){
	   					L5.Msg.alert('提示','删除成功!');
	   					for(var i=0;i<selected.length;i++){
	   						var record =selected[i];
							var recordState=record.state;
							if(recordState!=1){
								ds.remove(record);
							}
	   					}
	   				}else{
	   					L5.Msg.alert('提示',command.error);
	   				}
	   		      }
				}

				else return ;
			}

		);
	}
}
function save() {
	var records = ds.getAllChangedRecords();
	if(records.length<1){
		L5.Msg.alert(messTypePrompt,saveNoDataMess);
		return false;
	}
	var isValidate = ds.isValidate();
	if(isValidate != true){
		L5.Msg.alert(messTypePrompt,saveValidateMess+isValidate);
		return false;
	}
	var leng = records.length;
	for(var i=0; i<leng; i++) {
		var strutype = records[i].get('struType');
		var valid_seq_reg=/^[A-Za-z0-9]+$/;
	    if(!strutype.match(valid_seq_reg)){
	    	L5.MessageBox.alert("提示",'组织视角代码不能包含特殊字符或汉字');
			return;
	    }	
//		var catched = strutype.match((/\$|#|&|@|\*|\?/g));//组织视角代码不能包含特殊字符
//		if(  catched != null) {
//			var typeName = records[i].get('typeName');
//			L5.MessageBox.alert(messTypePrompt,typeName+":"+msg_has_unlegal_char+catched);
//			return;
//		}
	}
	var command = new L5.Command("org.loushang.bsp.organization.cmd.PubStruTypeCommand");
	command.setParameter("records", records);
	command.execute("save");
	if (!command.error) {
		ds.commitChanges();
		L5.Msg.alert(messTypePrompt,saveSuccessMess);
		L5.getCmp("detail").show();
	L5.getCmp("insert").hide();
	}else{
		L5.Msg.alert(messTypePrompt,command.error);
	}
}
function reset() {
	ds.rejectChanges();
}

function manager(){
	var userGrid=L5.getCmp('editGridPanel');
	//判断是否选择了要管理的记录
	var selected = userGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert("提示","请选择一条记录");
		return false;
	}
	if(selected.length>1){
		L5.Msg.alert("提示","请只选择一条记录");
		return false;
	}
	var records =selected[0];
	if(records.state=="1"){
		L5.Msg.alert('提示',"所选组织结构视角未保存，不能进行维护操作！");
		return false;
	}
	var struTypeId=selected[0].get('struType');
	var struTypeName=selected[0].get('typeName');
	struTypeName = escape(escape(struTypeName));
	//var records = ds.getAllChangedRecords();
	//var command = new L5.Command("org.loushang.bsp.organization.cmd.StruQueryCommand");
	//command.setParameter("records", records);
	//command.setParameter("struTypeId", struTypeId);
	//command.execute("getRoot");
	var url="jsp/bsp/organization/stru_main.jsp?struTypeId="+struTypeId+"&struTypeName="+struTypeName;
	var text = '管理组织结构';
	L5.forward(url,text);
}
//选择最高节点
function selectRootId(){
	var revalue=window.showModalDialog("../organization/getselect.jsp?rootId=rootId"+"&choiceOrganType=1"+"&isCheckBox=0"+"&showOrganType=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;dialogLeft:"+(window.screen.width-300)/2+";dialogTop:"+(window.screen.height-400)/2);
    if(revalue!=""&&revalue!=undefined){
	    var list = revalue.split(";");//
	    //var mgr=ds.getCurrent();
	    //ds.set("rootId",list[0]);
	    //L5.fly('rootNameinput').dom.value=list[1];
	    L5.fly('rootIdinput').dom.value=list[2];//此处的rootId为struId
		L5.fly('rootNameinput').dom.value=list[1];
		L5.fireEvent("rootIdinput","blur");
		L5.fireEvent("rootNameinput","blur");
    }
}

function checkSpecialChar(struTypeField) {
	var field = struTypeField.value ;
	var catched = field.match(/\$|#|&|@|\*|\?/g);
	if(  catched !== null) {
		L5.MessageBox.alert(messTypePrompt,msg_has_unlegal_char+catched);
	}
}