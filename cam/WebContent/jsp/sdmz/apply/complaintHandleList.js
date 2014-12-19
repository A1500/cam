/** 页面加载后自动运行，初始化事件等操作。
 */
function init(){
	L5.DatasetMgr.lookup("complaintDataset").load();	
}
/** 新增按钮的处理函数。
 */
function insert(){
	var url='jsp/sdmz/apply/complaintInsert.jsp';
	L5.forward(url);
}


/**提交审核
*/
function tjsh(){
	var applyGrid=L5.getCmp('complaintGridPanel');
	var selected = applyGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert("提示","请选择要审核的记录！");
		return false;
	}
	var applyDataset = L5.DatasetMgr.lookup("complaintDataset");
	L5.MessageBox.confirm('确定', '确定要审核选中的记录吗？',function(state){
		if(state=="yes"){
			var applyIds=[];
			for(var i=0;i<selected.length;i++){
				applyIds[i]=selected[i].get("applyId");
			}
			var command=new L5.Command("com.inspur.sdmz.apply.cmd.SamApplyCmd"); 
			command.setParameter("delIds", applyIds);
			command.execute("tjsh");
			if (!command.error) {
				for(var i=0;i<selected.length;i++){
			    	applyDataset.remove(selected[i]);		    	
				}
			}else{
				L5.Msg.alert("错误",command.error);
			}
		}else{
			return false;
		}
	});
 }
 /**点击修改按钮
*/
function update(){
	var applyGrid=L5.getCmp('complaintGridPanel');
	var selected=applyGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert("提示","请选择一条记录修改！");
		return false;
	}
	var data = new L5.Map();
	data.put("applyId",selected[0].get('applyId'));
	var url='jsp/sdmz/apply/complaintUpdate.jsp';
	var text = '修改用户';
	L5.forward(url,text,data);
	}
/**
 * 事件处理：点击删除按钮
 */
function remove() {
	var complaintGrid=L5.getCmp('complaintGridPanel');
	var selected = complaintGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert("提示","请选择要删除的记录！");
		return false;
	}
	var complaintDataset = L5.DatasetMgr.lookup("complaintDataset");
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗？',function(state){
		if(state=="yes"){
			var complaintIds=[];
			for(var i=0;i<selected.length;i++){
				complaintIds[i]=selected[i].get("applyId");
			}
			var command=new L5.Command("com.inspur.sdmz.apply.cmd.SamApplyCmd"); 
			command.setParameter("delIds", complaintIds);
			command.execute("delete");
			if (!command.error) {
				for(var i=0;i<selected.length;i++){
			    	complaintDataset.remove(selected[i]);		    	
				}
			}else{
				L5.Msg.alert("错误",command.error);
			}
		}else{
			return false;
		}
	});
}