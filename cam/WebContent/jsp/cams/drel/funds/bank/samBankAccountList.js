function init() {
	document.getElementById("domicileName").value=organName;
	document.getElementById("domicileCode").value=organArea;
	bankAccountDS.on("load",function(){
		if(bankAccountDS.getCount()<=0){
			bankAccountDS.newRecord();
		}
	});
}

function query(){

	var baseinfoFamilyListDS=L5.DatasetMgr.lookup("baseinfoFamilyListDS");
	baseinfoFamilyListDS.setParameter("assistanceType",assistanceType);
	baseinfoFamilyListDS.setParameter("familyName",document.getElementById("qFamilyName").value);
	baseinfoFamilyListDS.setParameter("familyCardNo",document.getElementById("qFamilyCardNo").value);
	baseinfoFamilyListDS.setParameter("queryDate",getCurYM());
	baseinfoFamilyListDS.setParameter("bankStatus",document.getElementById("bankStat").value);
	var domicileCode = document.getElementById("domicileCode").value;
	if(domicileCode){
		baseinfoFamilyListDS.setParameter("domicileCode",domicileCode);
	}else{
		baseinfoFamilyListDS.setParameter("domicileCode",organArea);
	}
	//翻页
	var num = baseinfoFamilyListDS.pageInfo.pageIndex;
	if(num <= 1){
		baseinfoFamilyListDS.load();
		return;
	}else{
		baseinfoFamilyListDS.turnPage(num);
	}
	baseinfoFamilyListDS.on("load", showToolBarMsg);
	noReclick(baseinfoFamilyListDS,"queryId");
}
function showToolBarMsg(ds){
	var qrToolbar = L5.getCmp("qrToolbar");
	if(ds.getCount()>0) 
		qrToolbar.setText("银行账户维护信息(" + ds.getTotalCount() + "条)");
	else
		qrToolbar.setText("银行账户维护信息");
}

function insert(){
	var selected = L5.getCmp("editGridPanel").getSelectionModel().getSelections();
	if(selected.length != 1){
		L5.Msg.alert('提示',"请选择一条记录！");
		return false;
	}
	//银行帐户信息
	bankAccountDS.removeAll();
	bankAccountDS.setParameter("FAMILY_ID@=",selected[0].get("FAMILY_ID"));
	bankAccountDS.load();
	var win = L5.getCmp("bankAccountWin");
	win.show();
	//家庭信息
	document.getElementById("familyName").innerHTML = selected[0].get("FAMILY_NAME");
	document.getElementById("familyCardNo").innerHTML = selected[0].get("FAMILY_CARD_NO");
}

function save() {
	L5.getCmp("saveId").setDisabled(true);
	var win = L5.getCmp("bankAccountWin");
	var selected = L5.getCmp("editGridPanel").getSelectionModel().getSelections();
	
	var records = bankAccountDS.getAllChangedRecords();
	if(records.length<1){
		L5.Msg.alert('提示','没有需要保存的数据!');
		L5.getCmp("saveId").setDisabled(false);
		return false;
	}
	//校验
	var valid = bankAccountDS.isValidate();
	if(valid != true){
		L5.Msg.alert('提示',"校验未通过,不能保存:"+valid);
		L5.getCmp("saveId").setDisabled(false);
		return false;
	}
	bankAccountDS.set("accountNumber", bankAccountDS.getCurrent().get("accountNumber").trim());
	var command = new L5.Command("com.inspur.cams.drel.sam.cmd.SamBankAccountCmd");
	command.setParameter("record", bankAccountDS.getCurrent());
	command.setParameter("familyId", selected[0].get("FAMILY_ID"));
	command.setParameter("assistanceType",assistanceType);
	command.execute("insert");
	if (!command.error) {
		L5.Msg.alert("提示", "银行账户维护成功！",function(){
			win.hide();
			query();
			L5.getCmp("saveId").setDisabled(false);
		});
	} else {
		L5.Msg.alert("提示", "银行账户维护失败：" + command.error);
		L5.getCmp("saveId").setDisabled(false);
	}
}
String.prototype.trim=function() {

    return this.replace(/(^\s*)|(\s*$)/g,'');
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
				delIds[i]=selected[i].get("familyId");
			}
			var command=new L5.Command("src.com.inspur.cams.drel.sam.cmd.SamBankAccountCommand");
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

function back(){
	var win = L5.getCmp("bankAccountWin");
	win.hide();
}

//重置
function resetQuery() {
	document.getElementById("domicileName").value=organName;
	document.getElementById("domicileCode").value=organArea;
	document.getElementById("qFamilyName").value="";
	document.getElementById("qFamilyCardNo").value="";
}

//获得当前日期 2011-05
function getCurYM(){
	var date=new Date();
	var year=""+date.getFullYear();
	var month=date.getMonth()+1;
	if(month<10){month="0"+month;}
	return year+"-"+month;
}

// 弹出本地的行政区划
function func_ForDomicileSelect() {
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&organCode="
					+ organArea + "&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("domicileCode").value = list[0];
		document.getElementById("domicileName").value = list[1];
	}
}
function formatDate2String(date) {
	return date.getYear()+"-"+((date.getMonth()+1)>9?(date.getMonth()+1):"0"+(date.getMonth()+1))+"-"+(date.getDate()>9?date.getDate():"0"+date.getDate());
}
//明细
function statusHref(value,cellmeta,record,rowindex,colindex,dataset){
	if(record.get('ACCOUNT_STATUS') == '2'){
		return '<font color="red">须更新</font>';
	}else if(record.get('ACCOUNT_STATUS') == '1'){
		return '<font color="green">正常</font>';
	}else{
		return '<font color="red">未采集</font>';
	}
}


