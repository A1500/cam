<%
//author：hqq
//description：本通用帮助实现了“选择单位（多选）”的功能
//选择单位后，点击【确定】，返回值为包含有3个元素的数组，并且每个元素仍然是数组。
//其中第一个元素是存放organId的数组，第2个元素是存放organName的数组，第3个元素是存放struId的数组
%>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<next:ScriptManager/>
<script type="text/javascript" src="..\..\..\skins\emonitor\js\UrlManager.js"></script>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>选择单位</title>

<script type="text/javascript">

//获取根节点数据

L5.informSession = {};
L5.informSession.getUserInfo = function() {
	if (sameDomain && top.userInfo != null)
	 return top.userInfo;
	var command = new L5.Command("com.inspur.cams.comm.informUtil.InformSessionCmd");
	command.execute("getUserInfo");
	if (!command.error) {
		var info = command.getReturn("userInfo");
		if (sameDomain) {
			top.userInfo = info;
		}
		return info;
	} else {
		alert("用户没有登录！");
	}
}




var userInfo=L5.informSession.getUserInfo();
var cantCode=userInfo.corporationId;
var cantName=userInfo.cantName;
var userDepOrganType=userInfo.userDepOrganType;
if(userDepOrganType==2){
   cantCode=userInfo.cantCode;
   cantName=userInfo.cantName;
}

/*
 * 定义根节点
 */
var rootdata = {
		CODE:cantCode,
		NAME:cantName,
		recordType : 'cantRecord'
	};
function struLoaderStart(record){
	return true;
}
function rules(record){
    return record.get("CODE");
}

function getIsLeaf(record)
{
	return false;
}


//点击【确定】
function confirm(){
	var tree = L5.getCmp("organtree1")	;
	var CODE=tree.getChecked("CODE");
	var NAME=tree.getChecked("NAME");
	var rs = new Array();
	if( CODE.length > 0){
		rs.push(CODE);
		rs.push(NAME);
		window.returnValue=rs;
		window.close();
	} else{
		alert("请选择一条记录！");
		}
}
//点击【清除】
function clear1(){
	var rs = new Array();
	rs.push("");
	rs.push("");
	window.returnValue=rs;
	window.close();

}
//关闭窗口
function winclose(){
	window.close();

}

function showType(record){
  return 'checkbox';
}
</script>
</head>
<body>
<next:Panel>
<next:TopBar>
		<next:ToolBarItem  iconCls="add" text="确定"  handler="confirm" ></next:ToolBarItem>
		<next:ToolBarItem  iconCls="undo" text="清除" handler="clear1"  ></next:ToolBarItem>
		<next:ToolBarItem  iconCls="remove" text="关闭" handler="winclose" ></next:ToolBarItem>
	</next:TopBar>

<next:Tree  name="organtree1" id="organtree1" title="选择单位" collapsible="true" height="500" autoScroll="true" >
	<next:TreeDataSet dataset="stru_dept" root="rootdata">
		<next:TreeLoader cmd="com.inspur.cams.comm.informUtil.InformOrganTreeQueryCommand" >
		<next:TreeBaseparam name="code"  value="rules"></next:TreeBaseparam>
			<next:treeRecord name="cantRecord"  idField="CODE">
				<model:field name="CODE" type="string"/>
				<model:field name="NAME" type="string"/>
			</next:treeRecord>
		</next:TreeLoader>
	</next:TreeDataSet>
	<next:TreeNodemodel recordType="cantRecord">
		<next:TreeNodeAttribute name="showType" handler="showType"></next:TreeNodeAttribute>
		<next:TreeNodeAttribute name="text" mapping="NAME"></next:TreeNodeAttribute>
		<next:TreeNodeAttribute name="leaf" handler="getIsLeaf"></next:TreeNodeAttribute>

	</next:TreeNodemodel>
</next:Tree>
</next:Panel>
</body>
</html>