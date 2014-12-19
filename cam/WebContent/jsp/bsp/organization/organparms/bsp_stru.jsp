		<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<next:ScriptManager/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>组织-维护</title>

<script type="text/javascript">
var struTypeId='<%=request.getParameter("struTypeId")%>';

/**
 * 定义根节点结构
 */
var rootdata = {
	id : 'rootId',//唯一标志record,如果是前台配置生成record,需要指定id
	struId:'rootId',
	organId:'rootId',
	struType:'00',
	parentId:'-1',
	struLevel:'1',
	struPath:'rootId',
	struOrder:'1',
	isLeaf:'0',
	inUseStru:'1',
	organId:'rootId',
	organName:'组织树',
	shortName:'根结点',
	organType:'1',
	organTypeName:'单位',
	struTypeName:'人力资源',
	inUseOrgan:'1',
	recordType : 'struRecord'
};
//根据类型值获取图标路径
function getIcon(rec){
	var figpath=L5.webPath+"/skins/images";
	var file=figpath+"/l5/bsp_department&corporation.gif";
	if(!rec){
		return file;
	}
	var organType=rec.get('organType');
	var type=organType.substring(0, 1);
	var value=parseInt(type);
	switch(value){
			case 0: //根结点
				file =figpath+"/l5/root.gif";
				break;
			case 1: // 法人
				file =figpath+"/l5/bsp_department&corporation.gif";
				break;
			case 2: // 部门
				file =figpath+ "/l5/bsp_department&corporation.gif";
				break;
			case 6: // 岗位
				file = figpath+"/l5/bsp_post.png";
				break;
			case 8: // 职工
				file =figpath+ "/l5/bsp_employee.gif";
				break;
			default:
				file =figpath+ "/l5/other.gif";

	}
	return file;
}
/**
 * 事件处理：获得 TreebaseParams的值
 */
function getStruParent(rec){
	var parentId = rec.get('parentId');

	return parentId;
}
function getStruId(rec){
	var struId=rec.get('struId');
	return struId?struId:"rootId";
}
function getStruType(rec){
	var struType=rec.get('struType');
	return struType?struType:"00";
}
function getStruTypeId(rec){

	return struTypeId?struTypeId:"00";
}

/**
* 事件处理：将节点信息添加到table中
*/
function selectedStru(record){
	formset.removeAll();
	var data=L5.getCmp("strutree1").getCurrentRecord().data;
	var id=data.struId;
	formset.add([new formset.recordType(data,id)]);


}
function struLoaderStart(record){
	return true;
}
function rules(record){
	return record.get("deptId");
}
function getStrudisabled(rec){
	return rec.get('organId') == 'rootId';
}
function confirm(){
	var tree = L5.getCmp("strutree1")	;
	var organId=tree.getChecked("organId");
	var organName=tree.getChecked("organName");
	var rs = new Array();
	var length = organId.length;
	if(organId &&  length> 0){
		var retParmValue="";
		var retParmNote="";
		for(var i=0;i<length;i++){
			retParmValue=retParmValue+organId[i];
			retParmNote=retParmNote+organName[i];
			if(i!=length-1){
				retParmValue=retParmValue+",";
				retParmNote=retParmNote+",";
			}
		}
		rs.push(retParmValue);
		rs.push(retParmNote);
		window.returnValue=rs;
		window.close();
	} else{
		alert("请选择一条记录！");
	}
}
function clear1(){
	var rs = new Array();
	rs.push("");
	rs.push("");
	window.returnValue=rs;
	window.close();

}
function winclose(){
	window.close();

}

function getcheckbox(rec){
	if(rec.get("struId")=="rootId"){
		return '';
	}else{
		return 'checkbox';
	}
}

</script>
</head>
<body>
<model:datasets>

<model:dataset id="ds" cmd="org.loushang.bsp.organization.cmd.StruQueryCommand" method="getUnderling" pageSize="15" global="true">
		<model:record fromBean="org.loushang.bsp.share.organization.bean.StruView"></model:record>
	</model:dataset>
	<model:dataset id="formset" global="true">
		<model:record fromBean="org.loushang.bsp.share.organization.bean.StruView"></model:record>
	</model:dataset>
</model:datasets>
<next:Panel  anchor="100% 100%" border="false">
<next:TopBar>

		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem  iconCls="yes" text="确定"  handler="confirm" ></next:ToolBarItem>
		<next:ToolBarItem  iconCls="undo" text="清除" handler="clear1"  ></next:ToolBarItem>
		<next:ToolBarItem  iconCls="no" text="关闭" handler="winclose" ></next:ToolBarItem>
	</next:TopBar>

<next:Tree id="strutree1"  bodyBorder="2" autoScroll="true" lines="true" rootVisible="false">
		<next:TreeDataSet dataset="stru" root="rootdata">
			<next:TreeLoader cmd="org.loushang.bsp.organization.cmd.StruQueryCommand"  method="getRoot" >
				<next:treeRecord name="struRecord" idField="struId" fromBean="org.loushang.bsp.share.organization.bean.StruView"/>
				<next:TreeBaseparam name="parentId" value="getStruParent"></next:TreeBaseparam>
				<next:TreeBaseparam name="struId" value="getStruId"></next:TreeBaseparam>
				<next:TreeBaseparam name="struType" value="getStruType"></next:TreeBaseparam>
				<next:TreeBaseparam name="struTypeId" value="getStruTypeId"></next:TreeBaseparam>
			</next:TreeLoader>
		</next:TreeDataSet>
	<next:TreeNodemodel recordType="struRecord">
		<next:TreeNodeAttribute name="showType" handler="getcheckbox"></next:TreeNodeAttribute>
		<next:TreeNodeAttribute name="text" mapping="organName"></next:TreeNodeAttribute>
		<next:TreeNodeAttribute name="disabled" handler="getStrudisabled"></next:TreeNodeAttribute>
		<next:TreeNodeAttribute name="icon" handler="getIcon" ></next:TreeNodeAttribute>
		<next:TreeNodeAttribute name="struPath" mapping="struId"></next:TreeNodeAttribute>
		<next:Listeners>
			<next:Listener eventName="selected" handler="selectedStru"></next:Listener>
		</next:Listeners>
	</next:TreeNodemodel>
</next:Tree>
</next:Panel>
</body>
</html>