<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<next:ScriptManager/>
<script type="text/javascript" src="..\..\..\skins\emonitor\js\UrlManager.js"></script>
<script type="text/javascript">
 var cantName='<%=BspUtil.getOrganName()%>';
 var cantCode='<%=BspUtil.getOrganCode()%>';
</script>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>选择单位</title>

<script type="text/javascript">

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
	if(record.get("TYPE")=="13"){
		return true;
	}
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
		<next:TreeLoader cmd="com.inspur.cams.comm.informUtil.InformOrganTreeQueryCommand"  method="queryBySql">
		<next:TreeBaseparam name="code"  value="rules"></next:TreeBaseparam>
			<next:treeRecord name="cantRecord"  idField="CODE">
				<model:field name="CODE" type="string"/>
				<model:field name="NAME" type="string"/>
				<model:field name="TYPE" type="string"/>
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