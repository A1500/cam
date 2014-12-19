var wFlag;

function init(){

}
/**
*查询
*/
function query(){
}
/**
*新增
*/
function add_problem(){
	var win=L5.getCmp('problem_win');
	var problemDealDS2=L5.DatasetMgr.lookup("problemDealDS2");
	problemDealDS2.newRecord();	
	wFlag="insert";
	win.show();	
}
//修改人员信息
function edit_problem(){
	var prsProblem_Grid=L5.getCmp("prsProblem_Grid");
	var cells= prsProblem_Grid.getSelectionModel().getSelections();
	if(cells.length!=1){
		L5.Msg.alert("提示","请选择一条要修改的记录！");
		return;
	}
	var problemId=cells[0].get("problemId");
	var problemDealDS2=L5.DatasetMgr.lookup("problemDealDS2");
	problemDealDS2.setParameter("problemId",problemId);
	problemDealDS2.load();
	
	var win=L5.getCmp('problem_win');
	wFlag="update";
	win.show();
}
//删除人员信息
function delete_problem(){
	var prsProblem_Grid = L5.getCmp('prsProblem_Grid');
	var cells= prsProblem_Grid .getSelectionModel().getSelections();
	if(cells.length<1){
		L5.Msg.alert("提示","请选择要删除的记录！");
		return;
	}
	var problemDealDS=L5.DatasetMgr.lookup("problemDealDS");
	L5.MessageBox.confirm('提示', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var delIds=[];
			for(var i=0;i<cells.length;i++){
				delIds[i]=cells[i].get("problemId");
			}
			var command=new L5.Command("com.inspur.cams.prs.prsproblemdeal.cmd.PrsProblemDealCmd");
			command.setParameter("delIds", delIds);
			command.execute("batchDelete");
			if (!command.error) {
				for(var n=cells.length-1;n>=0;n--){
					problemDealDS.remove(cells[n]);	
				}
			}else{
				L5.Msg.alert("提示","删除时出错！"+command.error);
			}
		}	
	});		
}
//查看详情
function detail_problem(){

	var prsProblem_Grid=L5.getCmp("prsProblem_Grid");
	var cells= prsProblem_Grid.getSelectionModel().getSelections();
	if(cells.length!=1){
		L5.Msg.alert("提示","请选择一条要查看的记录！");
		return;
	}
	var problemId=cells[0].get("problemId");
	var problemDealDS2=L5.DatasetMgr.lookup("problemDealDS2");
	problemDealDS2.setParameter("problemId",problemId);
	problemDealDS2.load();
/*	 
	var win=L5.getCmp('problem_win');
	win.show();
*/
}
//保存信息
function save_problem(){
	var problemDealDS2 = L5.DatasetMgr.lookup("problemDealDS2");
	var record=problemDealDS2.getCurrent();
	var valid =problemDealDS2.isValidate(true);
	if(valid !== true){
		L5.Msg.alert("提示","校验未通过："+valid);
		return false;
	}
	if(record.get("problemTitle")==""){
		L5.Msg.alert("提示","问题标题不能为空！");
		return false;
	}
	if(record.get("problemNumbers")==""){
		L5.Msg.alert("提示","问题编号不能为空！");
		return false;
	}
	if(record.get("problemPerson")==""){
		L5.Msg.alert("提示","反映人名称不能为空！");
		return false;
	}
	if(record.get("problemCompany")==""){
		L5.Msg.alert("提示","反映人单位不能为空！");
		return false;
	}
	if(record.get("personNumber")==""){
		L5.Msg.alert("提示","反映人数不能为空！");
		return false;
	}
	if(record.get("problemDate")==""){
		L5.Msg.alert("提示","反映时间不能为空！");
		return false;
	}
	if(record.get("content")==""){
		L5.Msg.alert("提示","反映内容不能为空！");
		return false;
	}
	
	var command = new L5.Command("com.inspur.cams.prs.prsproblemdeal.cmd.PrsProblemDealCmd");
    command.setParameter("record", record);
    //增加
    if(wFlag=="insert"){	   		
    	command.execute("insertProblemDeal");
    }
    //更新
    if(wFlag=="update"){
   		command.execute("updateProblemDeal");
    }
	if (!command.error) {
		wFlag="";
		L5.Msg.alert('提示','保存成功!',function(){
		hide_win();
		});					
	}else{
		L5.Msg.alert('提示',"保存时出现错误"+command.error);
	}	
}
//关闭窗口
function close_win(){
	var win=L5.getCmp("problem_win");
	win.hide();
}
