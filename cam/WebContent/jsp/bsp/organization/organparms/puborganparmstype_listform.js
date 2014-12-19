var page;
if(!page) page={};

page.param_field_editable = function(){
	document.getElementById('organParmName').disabled =undefined;
};
page.param_field_uneditable=function(){
	document.getElementById('organParmName').disabled ='disabled';
};
page.valid_nulled_field = function(rcds){//the5row组织类型名称column不能为空
	var leng = rcds.length;
	var i=0;
	var msg;
	for(; i<leng; i++){
		if(rcds[i].get('dataSource')==="2"){
			if(rcds[i].get('sourceTableName').length === 0){
				msg = {err_index:i,field_name:'数据来源表名'}
				break;
			}
			if(rcds[i].get('selCol').length === 0){
				msg = {err_index:i,field_name:'选择的字段'}
				break;
			}
			if(rcds[i].get('dispCol').length === 0){
				msg = {err_index:i,field_name:'显示的字段'}
				break;
			}
		}else
		if(rcds[i].get('dataSource')==="1"){
			if(rcds[i].get('enumName').length ===0){
				msg = {err_index:i,field_name:'枚举名称'}
				break;
			}
		}
		
	}
	if(i<leng){
		return msg;
	}
};
//检查数据权限类型是否被引用
page.check_remove=function(ids){
	var err_index;
	var cmd = new L5.Command('org.loushang.bsp.organization.cmd.PubOrganParmsTypeCommand');
	cmd.setParameter('ids',ids);
	cmd.execute('checkReferenced');
	var err_index = cmd.getReturn('errI');
	err_index = page.str2array(err_index);
	if(err_index.length<1){
		return null;
	}
	return err_index;
};
//把一个[xx,yy,zz]形状的字符串翻译成为数组
page.str2array=function(str){
	if(str === '[]'){
		return [];
	}
	var sub_str = str.substring(1,str.length-1);
	return sub_str.split(",");
}
function init() {
	dataSourceDs.on('load',function(){
		document.getElementById('dataSource_select').remove(0);
		ds.load();
	});
	ds.on('load',function(){ds.commitChanges();});
	dataSourceDs.load();
	
	L5.QuickTips.init();
}

function displayTable(){
		var data_source = document.getElementById('dataSource_select').value;
		
		if(data_source ==="0"){
			document.getElementById('enum_only_tr').style.display = 'none';
			document.getElementById('src_table').style.display = 'none';
			document.getElementById('select_column').style.display = 'none';
			document.getElementById('display_column').style.display = 'none';
			document.getElementById('where_condition').style.display = 'none';
		}else 
		if(data_source ==="1"){
			document.getElementById('enum_only_tr').style.display = "";
			document.getElementById('src_table').style.display = 'none';
			document.getElementById('select_column').style.display = 'none';
			document.getElementById('display_column').style.display = 'none';
			document.getElementById('where_condition').style.display = 'none';
		}else 
		if(data_source ==="2"){
			document.getElementById('enum_only_tr').style.display = 'none';
			document.getElementById('src_table').style.display = "";
			document.getElementById('select_column').style.display = "";
			document.getElementById('display_column').style.display = "";
			document.getElementById('where_condition').style.display = "";
		}
		var rcd = ds.getCurrent();
		if(rcd){
			var checkbox = document.getElementById('is_use_where_input');
			if(rcd.get('isUseWhere') ==="1"){
			  checkbox.checked = true;
			}
			else
			if(rcd.get('isUseWhere') ==="0"){
				checkbox.checked = false;
			}
			onchecked(checkbox);
		}
}
//解决：选择wehre条件 但是没有填写内容
function check_correct(ele){
	var v = document.getElementById('rely_on_checkbox').value;
	var where_condition = v.replace(/\s/g,"");
	if(where_condition.length === 0){
		document.getElementById('rely_on_checkbox').value = '1=1';
	}
}
function queryit(){
	var parm = document.getElementById('organParmsName').value;
	if(parm){
		ds.setParameter("ORGAN_PARMS_NAME@like",parm);
	}
	ds.load();
}

function reset(){
	document.getElementById('organParmsName').value="";	
}

function insert() {
	page.param_field_editable();
	ds.newRecord({dataSource:"0",isUseWhere:"0"});
	ds.moveLast();
}

function del(){
	if(ds.getCount()===0){
		L5.MessageBox.alert(RES_PROMPT,'没有要删除的记录');
		return;
	}
	
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	var leng = selected.length;
	var ids;
	var idNames;
	
	if( leng< 1){
		L5.MessageBox.alert(RES_PROMPT,'请选择要删除的记录');
		return;
	}
	
	L5.MessageBox.confirm(RES_PROMPT, RES_DELETE,
			function(sta){
				if(sta ==='yes'){
					ids = [];
					idNames=[];
					for(var i=0; i<leng; i++){
						if(selected[i].state !==1){//不是新增的才需要到后台去验证是否被引用
							ids[i] = selected[i].get('organParmsName');
							idNames[ids[i]] = selected[i].get('organParmsName');
						}
					}
					//删除后台的数据
				if(ids.length !==0){
					var err_index = page.check_remove(ids);
					if(err_index !== null){
						L5.MessageBox.alert(RES_PROMPT,'"'+idNames[err_index[0]]+'"正在被组织参数使用，不能删除');
						return;
					}
					var command = new L5.Command("org.loushang.bsp.organization.cmd.PubOrganParmsTypeCommand");
					command.setParameter("delIds", ids);
					command.execute("delete");
					if (!command.error) {
							
							L5.MessageBox.alert(RES_PROMPT,'删除成功');
						}else {
						L5.MessageBox.alert(RES_PROMPT,command.error);
						return;
					}
					for(var i=0; i<leng; i++){
						ds.remove(selected[i]);
					}
					ds.reload();
				}else{
					for(var i=0; i<selected.length; i++){
						ds.remove(selected[i]);
					}
				}
					
	}});
}
function save() {
	
	var records = ds.getAllChangedRecords();
	var msg;
	if(records.length<1){
		L5.MessageBox.alert(RES_PROMPT,RES_NOCHANGE);
		return false;
	}
	msg = ds.isValidate();
	
	if(msg !== true){
		L5.MessageBox.alert(RES_PROMPT,msg);
		return;
	}
	
	msg = page.valid_nulled_field(records);//返回的都是出错信息
	if(msg !== undefined){
		msg.err_index = ds.indexOf(records[msg.err_index])+1;
		L5.MessageBox.alert(RES_PROMPT,
			'第'+msg.err_index+'行'+msg.field_name+'列不能为空');
		return;
	}
	
	//如果是批量增加数据
	if(records.length > 1){
		for(var i=0; i<records.length; i++){
			var record1 = records[i];
			for(var j= i+1; j<records.length; j++){
				if(record1.get("organParmsName") == records[j].get("organParmsName")
						&& record1.state=='1' && records[j].state == '1'){
					L5.MessageBox.alert("错误",
							"请不要重复添加相同的组织参数名称");
					return;
				}
			}
		}
	}
	
	var command = new L5.Command("org.loushang.bsp.organization.cmd.PubOrganParmsTypeCommand");
	command.setParameter("records", records);
	command.execute("save");
	
	if (!command.error) {
		L5.Msg.alert(RES_PROMPT,RES_SAVE);
		page.param_field_uneditable();
		ds.commitChanges();
		
	}else{
		L5.Msg.alert(RES_PROMPT,command.error);
	}
}
function onchecked(ele){
	var rcd = ds.getCurrent();
	if(ele.checked){
		rcd.set('isUseWhere',"1");
		document.getElementById('rely_on_checkbox').style.display = "";
	}else 
	if(!ele.checked){
		rcd.set('isUseWhere',"0");
		rcd.set('whereCondition',"1=1");
		document.getElementById('rely_on_checkbox').style.display = "none";
	}
}
/**
 * 取消对dataset的修改，隐藏编辑表单
 */
function reset() {
	ds.rejectChanges();
}

var RowSelect=function(sm,rowIndex,record){
	var dataSourceType=record.data["dataSource"];
	dataSourceChanged(dataSourceType);
}

function dataSourceChanged(dataSourceType){
}


