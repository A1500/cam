
/**
 * 获取页面输入域值，并对空进行处理
 * @param ElementId
 * @returns
 */

function getParam(ElementId){
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
/**
 * 批量删除处理
 * 
 */

function del(){
	//开始时间和结束时间的check
	var startday= getParam("startTime");
	var endday= getParam("endTime");
	if(startday==undefined && endday==undefined){
		L5.Msg.alert('提示','开始时间和结束时间不能全为空！')
	}else{
		L5.MessageBox.confirm('确认','确定要删除该时间范围内日志吗？',
		function(sta){if(sta=="yes"){
			//获取command
			var command = new L5.Command("org.loushang.bsp.temporary.auditlog.cmd.PubAuditLogCommand");
			//向后台command传递参数
			command.setParameter("startTime",startday);
			command.setParameter("endTime",endday);
			//执行command的delete方法
			command.execute("delete");
			//如果执行没有错误,dataset接受所有修改,否则弹出错误信息：
			if(!command.error){
				L5.Msg.alert('提示','批量删除成功!');
			}else{
				alert(command.error);}
		}else return;
		});
		
	}
}


function back(){
	var url="jsp/bsp/audit/pubauditlog_list.jsp";
	L5.forward(url);
}