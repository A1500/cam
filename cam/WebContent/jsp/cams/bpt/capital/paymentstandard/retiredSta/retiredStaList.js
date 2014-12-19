/**
 * 初始化页面定义
 */
function init() {
   if(organCode!= currentOrganCode){
		document.getElementById("insert").style.visibility="hidden";
		document.getElementById("update").style.visibility="hidden";
		document.getElementById("delete").style.visibility="hidden";
   }
   //初始化数据
   retStaDs.setParameter("OBJECT_TYPE","81");
   retStaDs.setParameter("STANDARDS_COUNTIES",organCode);
   retStaDs.load();
};
/**
 * 增加功能
 */
function insert() {
    var url='jsp/cams/bpt/capital/paymentstandard/retiredSta/retiredStaEdit.jsp';
	var text = '增加农村退役士兵补助标准';
	var data = new L5.Map();
	data.put("method","insert");
	L5.forward(url,text,data);
}
/**
 * 查看功能
 */
function detail(){
	var data = new L5.Map();
	data.put("ID",retStaDs.get("id"));
	var url='jsp/cams/bpt/capital/paymentstandard/retiredSta/retiredStaDetail.jsp';
	var text = '查看农村退役士兵补助标准';
	L5.forward(url,text,data);
}
/**
 * 修改功能
 */
function update(){
	var url='jsp/cams/bpt/capital/paymentstandard/retiredSta/retiredStaEdit.jsp';
	var text = '修改农村退役士兵补助标准';
	var data = new L5.Map();
	data.put("method","update");
	data.put("id", retStaDs.get('id'));
	L5.forward(url,text,data);
}
/**
 * 删除功能
 * @returns {Boolean}
 */
function del(){
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示','请选择 要删除的记录！');
		return false;
	}
	var state=confirm('确定要删除选中的记录吗?');
	if(state==true){
		var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptCapitalRetStaCommand");
		command.setParameter("records",selected);
		command.execute("deleteList");
		if(!command.error){
			for(var i=0;i<selected.length;i++){
				retStaDs.remove(selected[i]);
			}
			retStaDs.commitChanges();
		}else{
			L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		}
	}else{
		return false;
	}
}