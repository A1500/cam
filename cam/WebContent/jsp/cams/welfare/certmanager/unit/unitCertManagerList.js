function init() {
	ds.setParameter("WEAL_CERT.COMPANY_TYPE@=","2");//企业类型：1	
	
	if(organArea.substring(2) == "0000000000") {
		organArea=organArea.substring(0,2);	//省局
	}else if(organArea.substring(4) == "00000000") {
		organArea=organArea.substring(0,4);//市局
	}else if(organArea.substring(4) == "000000"){
		organArea=organArea.substring(0,6);//县局
	}else{
		organArea=organArea.substring(0,9);//街道or乡镇
	}
	
	ds.setParameter("WEAL_CERT.MORG_AREA@LIKE",organArea+"%");
	ds.load();
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	if(organArea.substring(2) == "0000000000") {
		organArea=organArea.substring(0,2);	//省局
	}else if(organArea.substring(4) == "00000000") {
		organArea=organArea.substring(0,4);//市局
	}else if(organArea.substring(4) == "000000"){
		organArea=organArea.substring(0,6);//县局
	}else{
		organArea=organArea.substring(0,9);//街道or乡镇
	}
	ds.setParameter("WEAL_CERT.MORG_AREA@LIKE",organArea+"%");
	ds.setParameter("WEAL_CERT.COMPANY_TYPE@=","2");		
	ds.setParameter("WEAL_CERT.CERT_TYPE@=",getParam("certTypeQuery"));		
	ds.setParameter("WEAL_CERT.SERIAL_NUM@=",getParam("serialNumQuery"));		
	ds.setParameter("WEAL_CERT.COMPANY_NAME@LIKE",getParam("companyNameQuery"));		
	ds.setParameter("WEAL_CERT.LEGAL_PEOPLE@LIKE",getParam("legalPeopleQuery"));		
	ds.setParameter("WEAL_CERT.CERT_STATUS@=",getParam("certStatusQuery"));		
	ds.load();
}

function addCert() {
	var data = new L5.Map();
	data.put("method","INSERT");
	var url='jsp/cams/welfare/certmanager/unit/unitCertManagerEdit.jsp';
	var text = '证书管理编辑';
	L5.forward(url,text,data);

}

function editCert(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	if(selected[0].get('certStatus')=="2"){
		L5.Msg.alert('提示',"该证书已收缴，不能进行修改!");
		return false;
	}
	var data = new L5.Map();
	data.put("method","UPDATE");
	data.put("taskCode",selected[0].get('taskCode'));
	var url='jsp/cams/welfare/certmanager/unit/unitCertManagerEdit.jsp';
	var text = '证书管理编辑';
	L5.forward(url,text,data);
}

function delCert(){
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
				delIds[i]=selected[i].get("taskCode");
			}
			var command=new L5.Command("com.inspur.cams.welfare.base.cmd.WealCertCommand");
			command.setParameter("delIds", delIds);
			command.execute("delete");
			if (!command.error) {
				for(var i=0;i<selected.length;i++){
			    	ds.remove(selected[i]);
				}
				ds.commitChanges();
				L5.Msg.alert('提示',"成功删除！");
			}else{
				L5.Msg.alert('提示',"删除时出现错误！"+command.error);
			}
		}else{
			return false;
		}
	});
}
//注销收缴证书
function cancelCert(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录进行收缴!");
		return false;
	}
	if(selected[0].get('certStatus')=="2"){
		L5.Msg.alert('提示',"该证书已收缴!");
		return false;
	}
	cancelDs.setParameter("TASK_CODE@=",selected[0].get('taskCode'));
	cancelDs.load();
	var Cert=L5.getCmp("cancelCertWin");
	Cert.show();
}
function confirmCancelWin(){
	var record = cancelDs.getCurrent();
	var valid = cancelDs.isValidate();
	if(valid != true){
		L5.Msg.alert('提示',valid);
		return false;
	}
	L5.MessageBox.confirm('确定', '是否确认收缴证书？',function(sta){
		if(sta=="yes"){
			record.set("certStatus","2");
			var command = new L5.Command("com.inspur.cams.welfare.base.cmd.WealCertCommand");
			command.setParameter("record", record);
			command.execute("update");
			if (!command.error) {
				L5.Msg.alert('提示',"成功收缴证书！");
				init();
			}else{
				L5.Msg.alert('提示',"收缴注销时出现错误！"+command.error);
			}
		}else{
			var Cert=L5.getCmp("cancelCertWin");
			Cert.show();
		}
	});
}
function closeCancelWin(){
	var Cert=L5.getCmp("cancelCertWin");
	Cert.hide();
}
//把企业名称变为一个超级链接
function detailHref(value,cellmeta,record,rowindex,colindex,dataset){
	var ds=L5.DatasetMgr.lookup("ds");
	return '<a href="javascript:certDetail(\'' + ds.indexOf(record) + '\')">' + value + '</a>';
}
var certStatus="";
//超级链接所调用的方法
 function certDetail(index){
   	var ds=L5.DatasetMgr.lookup("ds");
   	var record= ds.getAt(index);
   	certStatus=record.get('certStatus');
   	var taskCode=record.get('taskCode');
   	var certDs=L5.DatasetMgr.lookup("certDs");
   	certDs.setParameter("TASK_CODE@=",taskCode);
   	certDs.load();
   	var Cert=L5.getCmp("Cert");
	Cert.show();
	if(certStatus=="2"){
		 document.getElementById("cancelInfo").style.display="block";
	}
 }
function rePrint(){
	if(certStatus=="2"){
		L5.Msg.alert('提示',"该证书已收缴！");
	}else{
		forRePrint("unit");
	}
}
function closewin(){
	var Cert=L5.getCmp("Cert");
	Cert.hide();
}