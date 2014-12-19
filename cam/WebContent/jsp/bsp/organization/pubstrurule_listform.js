function init() {
	//struTypeDs
	var vstruTypeDs=L5.DatasetMgr.lookup("struTypeDs");
	vstruTypeDs.setParameter("IN_USE","1");
	vstruTypeDs.load(true);

	//organTypeDs
	var vorganTypeDs=L5.DatasetMgr.lookup("organTypeDs");
	vorganTypeDs.baseParams["IN_USE"]="1";
	vorganTypeDs.load(true);

    //organTypeDsNew
	var vds=L5.DatasetMgr.lookup("organTypeDsNew");
	vds.setParameter("IN_USE","1");
	vds.load(true);
	//L5.DatasetMgr.lookup("ds").load();
	query();

	L5.QuickTips.init();
	initTargetRef();

};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	ds.setParameter("STRU_TYPE",getParam("struType0"));
	ds.setParameter("SRC_REF",getParam("srcRef0"));
	ds.setParameter("TARGET_REF",getParam("targetRef0"));
	ds.load();
}

function reset(){
	document.getElementById("struType0").value="";
	document.getElementById("srcRef0").value="";
	document.getElementById("targetRef0").value="";
}

function insert() {
	var record=ds.newRecord();
	ds.moveLast();
}

function del(){
	if(ds.getCount()===0){
		L5.MessageBox.alert(RES_PROMPT,'没有要删除的记录');
		return;
	}
	var userGrid=L5.getCmp('editGridPanel');
	var selected = userGrid.getSelectionModel().getSelections();
	var leng = selected.length;
	if( leng< 1){
		L5.MessageBox.alert(RES_PROMPT,'请选择要删除的记录');
		return;
	}
	var ruleIds;
	L5.MessageBox.confirm(RES_PROMPT, RES_DELETE,
			function(sta){
				if(sta ==='yes'){
					ruleIds =[];
					for(var i=0; i<leng; i++){
						//if(selected[i].state !==1){
							ruleIds[i] = selected[i].get('ruleId');
					}
					//删除后台的数据
				if(ruleIds.length !==0){
					var command = new L5.Command("org.loushang.bsp.organization.cmd.PubStruRuleCommand");
					command.setParameter("delIds", ruleIds);
					command.execute("delete");
					if (!command.error) {
						ds.commitChanges();
						L5.MessageBox.alert(RES_PROMPT,'删除成功');
					}else{
						L5.MessageBox.alert(RES_PROMPT,command.error);
						return;
					}
				}

				for(var i=0; i<leng; i++){
					ds.remove(selected[i]);
				}
	}});

}
function save() {
	//多选组件
	var selectTargetRef= document.getElementsByName("targetRef_name");
	var userGrid=L5.getCmp('editGridPanel');
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
	var allrecords = ds.getAllRecords();
	var l=0;
	//有新增信息 ,需要判断相同的组织视角下是否有相同的“上级组织类型”？
	for(i=0;i<allrecords.length;i++)
	{
		var record_=allrecords[i];
		var recordState=record_.state;//状态：0：未作更改 1：新增 2：删除 3：修改；
		if(recordState==1)//新增的
		{
			var vStruType=record_.get("struType");
			var vSrcRef=record_.get("srcRef");
			for(l=0;l<allrecords.length;l++)
			{
				var record_re=allrecords[l];
				var vStruType_=record_re.get("struType");
				var vSrcRef_=record_re.get("srcRef");
				if(i!=l&&vStruType+":"+vSrcRef==vStruType_+":"+vSrcRef_)
				{
					//alert(i+"---"+l);
					//alert(vStruType+":"+vSrcRef+"---------"+vStruType_+":"+vSrcRef_);
					L5.Msg.alert(messType,saveRepeatMess);
					return false;
				}
			}
		}

	}

	var command = new L5.Command("org.loushang.bsp.organization.cmd.PubStruRuleCommand");
	command.setParameter("records", records);
	command.execute("save");

	query();
	if (!command.error) {
		ds.commitChanges();
		L5.Msg.alert(messType,saveSuccessMess);
	}else{
		L5.Msg.alert(messType,command.error);
	}

}
function reset() {
	ds.rejectChanges();
}

function initTargetRef(){
	new L5.ux.ItemSelector({
		field:"targetRef",
		applyTo:"favordiv",
		id:"targetRefId",
		name:"targetRef_name",
		dataFields:["value","text"],
		fromDataset:organTypeDsNew,
		valueField :"value",
		displayField:"text",
	    msWidth:206,
	    msHeight:195,
	    drawUpIcon:false,
	    drawDownIcon:false,
	    drawTopIcon:false,
	    drawBotIcon:false
	    });
}
//点击“允许使用的下级组织类型”列字段弹出窗口
function openTargetRefWin(){
	var win=L5.getCmp('targetRefWin');
	win.show(this);
	win.el.focus();
}
//弹出窗口点击“确定”
function win_sure(){
	var values=L5.get("targetRefId").getValue();
    var record=ds.getCurrent();
	record.set("targetRef",values);
	var win=L5.getCmp('targetRefWin');
	win.hide();
}
//弹出窗口点击“关闭”
function win_close(){
	var win=L5.getCmp('targetRefWin');
    win.hide();
}
//渲染“允许使用的下级组织类型”
function render_targetRef(values) {
	var texts=new Array();
	if (!(values instanceof Array)) {
		if(!values||values=="") {
			return "";
		}
		values = values.split(',');
	}
	//根据id显示名称
	for (var i=0; i<values.length; i++) {
		var record=organTypeDs.getById(values[i]);
		if(record){
			texts.push(record.get("text"));
		}
	}
	return texts.join(",");
}

