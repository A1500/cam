var page;
if(!page) page={};

page.param = {
	data_tyep_name:'数据类型名称'
}

//检查数据权限类型是否被引用
page.check_remove=function(ids){
	var err_index;
	var cmd = new L5.Command('org.loushang.bsp.permit.pap.datatype.cmd.PubDataTypeCommand');

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
function displayTable(){
	var dataType= document.getElementById('isOrgan_select').value;
	if(dataType === '0'){//是数据库
		document.getElementById('sourceTableTr').style.display = "";
		document.getElementById('selColTr').style.display = "";
		document.getElementById('dispColTr').style.display = "";
		document.getElementById('isUseWhereTr').style.display = "";
		document.getElementById('dataTypeCodeImg').style.display = 'none';
		if(ds.getCurrent().state==1){//当前记录是新增记录,则设置为可编辑
             document.getElementById('dataTypeCode_input').disabled = undefined;
    	}else{//否则设置为不可编辑
			document.getElementById('dataTypeCode_input').disabled ='disabled';
			}
		document.getElementById('dataTypeName_input').disabled = undefined;

	}else
	if(dataType==='1'){//是组织机构
		document.getElementById('sourceTableTr').style.display = 'none';
		document.getElementById('selColTr').style.display = 'none';
		document.getElementById('dispColTr').style.display = 'none';
		document.getElementById('isUseWhereTr').style.display = 'none';
		document.getElementById('dataTypeCodeImg').style.display = "";
				document.getElementById('dataTypeCode_input').disabled = 'disabled';
				document.getElementById('dataTypeName_input').disabled = 'disabled';
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

//附加地对数据库类型和枚举类型添加的校验，验证是否为空
page.valid_nulled_field = function(rcds){
	var leng = rcds.length;
	var i=0;
	var msg;
	for(; i<leng; i++){
		if(rcds[i].get('isOrgan')==="0"){
			if(rcds[i].get('sourceTable').length === 0){
				msg = {err_index:i,field_name:'源表名称'}
				break;
			}
			if(rcds[i].get('selCol').length === 0){
				msg = {err_index:i,field_name:'选择的字段名称'}
				break;
			}
			if(rcds[i].get('dispCol').length === 0){
				msg = {err_index:i,field_name:'显示的字段名称'}
				break;
			}
			if(rcds[i].get('selColDes').length === 0){
				msg = {err_index:i,field_name:'显示的字段描述'}
				break;
			}
			if(rcds[i].get('dispColDes').length === 0){
				msg = {err_index:i,field_name:'显示的字段描述'}
				break;
			}
		}
	}
	if(i<leng){
		return msg;
	}
};
var inUseDataset = new L5.EnumDataset('BSP.IN_USE');
function forHelp(ev,target,key){
		var url ="datatype_help.jsp";
		var win = showModalDialog(url,null,"scroll:yes;status:no;dialogWidth:500px;dialogHeight:550px");
		 if (win == null) {
			return ;
		  }else{
		  		var rcd = ds.getCurrent();
		  		rcd.set('dataTypeCode',win[0]);
		  		rcd.set('dataTypeName',win[1]);

		  }
}

function init() {
	dataTypeDs.on('load',function(){
		ds.load();
		document.getElementById('isOrgan_select').remove(0);
	});
	ds.on('load',function(){ds.commitChanges();});
	dataTypeDs.load();
	L5.QuickTips.init();
}
function query(){
	ds.load();
}
var RowSelect=function(sm,rowIndex,record){
}
function onchecked(ele){
	var rcd = ds.getCurrent();
	if(ele.checked){
		rcd.set('isUseWhere',"1");
		//rcd.set('whereCondition',"");
		document.getElementById('rely_on_checkbox').style.display = "";
	}
	else
	if(!ele.checked){
		rcd.set('isUseWhere',"0");
		rcd.set('whereCondition','1=1');
		document.getElementById('rely_on_checkbox').style.display = 'none';
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
function insert() {
	ds.newRecord({isOrgan:"1",isUseWhere:"0",whereCondition:'1=1'});
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
					idNames = [];
					for(var i=0; i<leng; i++){
						if(selected[i].state !==1){//不是新增的才需要到后台去验证是否被引用
						ids[i] = selected[i].get('dataTypeCode');
						idNames[ids[i]] = selected[i].get('dataTypeName');
						}
					}
					//删除后台的数据
					if(ids.length !==0){
					var err_index = page.check_remove(ids);
					if(err_index !== null){
						L5.MessageBox.alert(RES_PROMPT,'"'+idNames[err_index[0]]+'"正在被数据权限使用，不能删除');
						return;
					}
					var command = new L5.Command("org.loushang.bsp.permit.pap.datatype.cmd.PubDataTypeCommand");
					command.setParameter("delIds", ids);
					command.execute("delete");
					if (!command.error) {
						ds.commitChanges();
						L5.MessageBox.alert(RES_PROMPT,'删除成功');
					}else
					{
						L5.MessageBox.alert(RES_PROMPT,command.error);
						return;
					}
				}

				for(var i=0; i<leng; i++){
					ds.remove(selected[i]);
				}
	}});
}

function save(){
	var records = ds.getAllChangedRecords();
	if(records.length<1){
		L5.MessageBox.alert(RES_PROMPT,RES_NOCHANGE);
		return false;
	}
	if(Validate()==false){
		return;
	}
	var command = new L5.Command("org.loushang.bsp.permit.pap.datatype.cmd.PubDataTypeCommand");
	command.setParameter("records", records);
	command.execute("save");
	if ( !command.error ) {
		ds.commitChanges();
		L5.MessageBox.alert(RES_PROMPT , RES_SAVE);
	}else{
		L5.MessageBox.alert(RES_PROMPT , command.error);
	}
}
function Validate(){
	var dataTypeCode_input = document.getElementById("dataTypeCode_input").value;
	if(dataTypeCode_input==''){
		L5.MessageBox.alert("提示","\"数据类型编码\"不能为空");
		return false;
	}
	var dataTypeName_input = document.getElementById("dataTypeName_input").value;
	if(dataTypeName_input==''){
		L5.MessageBox.alert("提示","\"数据类型名称\"不能为空");
		return false;
	}
	var isOrgan_select = document.getElementById("isOrgan_select").value;
	if(isOrgan_select=='0'){
		var sourceTable = document.getElementById("sourceTable").value;
		if(sourceTable==''){
			L5.MessageBox.alert("提示","\"源表名称\"不能为空");
			return false;
		}
		var selCol = document.getElementById("selCol").value;
		if(selCol==''){
			L5.MessageBox.alert("提示","\"选择的字段名称\"不能为空");
			return false;
		}
		var selColDes = document.getElementById("selColDes").value;
		if(selColDes==''){
			L5.MessageBox.alert("提示","\"选择的字段描述\"不能为空");
			return false;
		}
		var dispCol = document.getElementById("dispCol").value;
		if(dispCol==''){
			L5.MessageBox.alert("提示","\"显示的字段名称\"不能为空");
			return false;
		}
		var dispColDes = document.getElementById("dispColDes").value;
		if(dispColDes==''){
			L5.MessageBox.alert("提示","\"显示的字段描述\"不能为空");
			return false;
		}
	}
}
function dataTypeRender(value,cellmeta,record,rowindex,colindex,dataset){
	var dataType=record.data['isOrgan'];
	if(dataType=="1")
		return "组织机构";
	else
		return "数据库表";

}

function reset() {
	ds.rejectChanges();
}
