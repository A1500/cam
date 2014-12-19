function init(){
	problemDealDS=L5.DatasetMgr.lookup("problemDealDS");
	problemDealDS.setParameter("organ",organArea);
	problemDealDS.setParameter("curActivity","01");
	//problemDealDS.setParameter("dealFlag","01");
	var grid=L5.getCmp('prsProblem_Grid');
	//给grid增加双击侦听事件。
	grid.on("rowdblclick",edit_problem);
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
	//problemDealDS.setParameter("dealFlag","01");
	problemDealDS.setParameter("curActivity","01");
	problemDealDS.load();
}
/**
*新增
*/
function add_problem(){
	var url="jsp/cams/prs/prsProblemDeal/prsProblemDealInsert.jsp";
	var text="问题信息办理";
	var data=new L5.Map();
	data.put("method","insert");
	L5.forward(url,text,data);
}
/**
*办理
*/
function process_problem(){
	var prsProblem_Grid=L5.getCmp("prsProblem_Grid");
	var cells= prsProblem_Grid.getSelectionModel().getSelections();
	if(cells.length!=1){
		L5.Msg.alert("提示","请选择一条要办理的记录！");
		return;
	}
	var dealFlag=cells[0].get("DEAL_FLAG");
	var problemFrom=cells[0].get("PROBLEM_FROM");
	var problemId=cells[0].get("PROBLEM_ID");
	if(dealFlag=="02"){
		L5.Msg.alert("提示","此问题已转发其他地区，不可以再办理！");
		return;
	}
	var url="jsp/cams/prs/prsProblemDeal/prsProblemDealProcess.jsp";
	var text="问题信息办理";
	var data=new L5.Map();
	data.put("problemId",problemId);
	data.put("problemFrom",problemFrom);
	L5.forward(url,text,data);
}
//修改
function edit_problem(){	
	var prsProblem_Grid=L5.getCmp("prsProblem_Grid");
	var cells= prsProblem_Grid.getSelectionModel().getSelections();
	if(cells.length!=1){
		L5.Msg.alert("提示","请选择一条要修改的记录！");
		return;
	}
	var dealFlag=cells[0].get("DEAL_FLAG");
	var problemFrom=cells[0].get("PROBLEM_FROM");
	var problemId=cells[0].get("PROBLEM_ID");
	var organ=cells[0].get("ORGAN");
	if(dealFlag=="02"){
		L5.Msg.alert("提示","此问题已转发其他地区，不可以修改！");
		return;
	}
	if(organ!=organArea){
		L5.Msg.alert("提示","此问题由其他地区转发过来的，不可以修改！");
		return;
	}
	var url="jsp/cams/prs/prsProblemDeal/prsProblemDealModify.jsp";
	var text="问题信息办理";
	var data=new L5.Map();
	data.put("problemId",problemId);
	data.put("method","update");
	L5.forward(url,text,data);
}
//删除
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
				var dealFlag=cells[i].get("DEAL_FLAG");
				var organ=cells[i].get("ORGAN");
				if(dealFlag=="02"){
					L5.Msg.alert("提示","里面含有已转发的记录，不可以删除！");
					return;
				}
				if(organ!=organArea){
					L5.Msg.alert("提示","里面含有其他地区转发过来的记录，不可以删除！");
					return;
				}
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
	var problemId=cells[0].get("PROBLEM_ID");
	var url="jsp/cams/prs/prsProblemDeal/prsProblemDealDetail.jsp";
	var text="问题信息详情";
	var data=new L5.Map();
	data.put("problemId",problemId);
	data.put("method","list");
	L5.forward(url,text,data);
}
//修改
function send_problem02(){
	document.getElementById(dealFlag).disabled=true;
	document.getElementById(dealPerson).disabled=true;
	document.getElementById(dealTime).disabled=true;
	document.getElementById(deal).disabled=true;
}