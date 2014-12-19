/** 页面加载后自动运行，初始化事件等操作。
 */
function init(){
	L5.DatasetMgr.lookup("consultDataset").load();	
}
/** 新增按钮的处理函数。
 */
function insert(){
	var url='jsp/sdmz/apply/consultInsert.jsp';
	L5.forward(url);
}

/** 修改按钮的处理函数。
 */
function update(){
	var consultGrid=L5.getCmp('consultGridPanel');
	var selected=consultGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert("提示","请选择一条记录修改！");
		return false;
	}
	var data = new L5.Map();
	data.put("applyId",selected[0].get('applyId'));
	var url='jsp/sdmz/apply/consultUpdate.jsp';
	var text = '修改用户';
	L5.forward(url,text,data);
}

/**提交审核
*/
function tjsh(){
	var consultGrid=L5.getCmp('consultGridPanel');
	var selected = consultGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert("提示","请选择要审核的记录！");
		return false;
	}
	var consultDataset = L5.DatasetMgr.lookup("consultDataset");
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
			    	consultDataset.remove(selected[i]);		    	
				}
			}else{
				L5.Msg.alert("错误",command.error);
			}
		}else{
			return false;
		}
	});
}

/** 删除按钮的处理函数。
 */
function del(){
	var consultGrid=L5.getCmp('consultGridPanel');
	var selected = consultGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert("提示","请选择要删除的记录！");
		return false;
	}
	var consultDataset = L5.DatasetMgr.lookup("consultDataset");
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗？',function(state){
		if(state=="yes"){
			var consultIds=[];
			for(var i=0;i<selected.length;i++){
				consultIds[i]=selected[i].get("applyId");
			}
			var command=new L5.Command("com.inspur.sdmz.apply.cmd.SamApplyCmd"); 
			command.setParameter("delIds", consultIds);
			command.execute("delete");
			if (!command.error) {
				for(var i=0;i<selected.length;i++){
			    	consultDataset.remove(selected[i]);		    	
				}
			}else{
				L5.Msg.alert("错误",command.error);
			}
		}else{
			return false;
		}
	});
}


