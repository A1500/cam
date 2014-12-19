//获取页面输入域值，并对空进行处理
function getParam(ElementId){
	var value=document.getElementById(ElementId).value;
	//如果没有只就设为undifined对应java的null
	if(value=="") value=undefined;
	return value;
}

/**
 * 事件处理：点击查询按钮
 */
function query(){
	//设置参数值,用@分开的两段：前面是参数名,后面是比较符号
	var userId=getParam("userId");
	var userName=getParam("userName");
	 if(userId!=undefined&&userId!=""&&userId.indexOf("'")!=-1){
	    	L5.MessageBox.alert("提示",'查询条件中不能包含单引号字符');
	        return;
	    }
	    if(userName!=undefined&&userName!=""&&userName.indexOf("'")!=-1){
	    		L5.MessageBox.alert("提示",'查询条件中不能包含单引号字符');
	            return;	
	    }
	onlineDataset.setParameter("userId",userId);
	onlineDataset.setParameter("userName",userName);
	//通过对象调用OnlineQueryCommand中的queryPlan方法，执行计划查询功能
	onlineDataset.load();
}
    
function reset(){
	document.getElementById("userId").value="";
	document.getElementById("userName").value="";
}