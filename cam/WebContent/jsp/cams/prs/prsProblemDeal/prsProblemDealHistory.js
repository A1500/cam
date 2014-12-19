function init(){
	problemDealDS=L5.DatasetMgr.lookup("problemDealDS");
	problemDealDS.setParameter("organ",organArea);
	problemDealDS.setParameter("curActivity","02");
	//problemDealDS.setParameter("dealFlag","03");
	problemDealDS.load();
}
/**
*查询
*/
function query(){
	var problemTitle=_$("qTitle");
	var supervision=_$("qSupervision");
	var problemFrom=_$("qFrom");
	var problemDateBegin=_$("qDateBegin");
	var problemDateEnd=_$("qDateEnd");
	
	problemDealDS=L5.DatasetMgr.lookup("problemDealDS");
	problemDealDS.setParameter("problemTitle",problemTitle);
	problemDealDS.setParameter("supervision",supervision);
	problemDealDS.setParameter("problemFrom",problemFrom);
	problemDealDS.setParameter("problemDateBegin",problemDateBegin);
	problemDealDS.setParameter("problemDateEnd",problemDateEnd);
	problemDealDS.setParameter("organ",organArea);
	problemDealDS.setParameter("curActivity","02");
	problemDealDS.load();
}
//查看详情
function detail_problem(){

	var prsProblem_Grid=L5.getCmp("prsProblem_Grid");
	var cells= prsProblem_Grid.getSelectionModel().getSelections();
	if(cells.length!=1){
		L5.Msg.alert("提示","请选择一条要查看的记录！");
		return;
	}
	var problemId=cells[0].get("PROBLEM_ID");
	var url="jsp/cams/prs/prsProblemDeal/prsProblemDealDetail.jsp";
	var text="问题信息详情";
	var data=new L5.Map();
	data.put("problemId",problemId);
	data.put("method","history");
	L5.forward(url,text,data);
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
				delIds[i]=cells[i].get("PROBLEM_ID");
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