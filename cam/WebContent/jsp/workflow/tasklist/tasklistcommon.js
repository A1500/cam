function showprocessstate(gridpanel,type,backUrl)
{
	 var assignmentId="";
	 var procDefUniqueId="";
	 var selecteds=gridpanel.getSelectionModel().getSelections();
	   if(selecteds.length!=1){
	      alert("请选择一条您要查看的记录");
		  return false;
		}
	   if(type=="new"){
		   procDefUniqueId=selecteds[0].get("procDefUniqueId");
	   }else{
		   assignmentId=selecteds[0].get("assignmentId");
	   }
	   var getModelTypeCmd=new L5.Command("org.loushang.workflow.monitor.cmd.ProcessMonitorCmd");
	   getModelTypeCmd.setParameter("procDefUniqueId",procDefUniqueId);
	   getModelTypeCmd.setParameter("assignmentId",assignmentId);
	   getModelTypeCmd.execute("hasProcHighExecuteMapping");
	   if(!getModelTypeCmd.error)
	   {
	    var hasProcHighExecuteMapping=getModelTypeCmd.getReturn("hasProcHighExecuteMapping");
	    var url='jsp/workflow/monitor/flowview.jsp?backUrl='+backUrl+'&assignmentId='+assignmentId+'&procDefUniqueId='+procDefUniqueId;
	 	if(hasProcHighExecuteMapping)
	 	{
	 		url='jsp/workflow/monitor/bpmn/processviewer.jsp?backUrl='+backUrl+'&assignmentId='+assignmentId+'&id='+procDefUniqueId;
	 	}
	     var text = '流程状态';
	     L5.forward(url,text);
	   }
	   else
	   {
	 	alert(getModelTypeCmd.error);
	   }	   
}