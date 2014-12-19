<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model" %>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="java.util.List"%>

<HTML>
<HEAD>
<TITLE>环节内自由发送</TITLE>
<next:ScriptManager></next:ScriptManager>
</HEAD>
<BODY>
	<next:Panel anchor="100% 100%" border="false">
			<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="add"  text="确定" handler="doConfirm"/>
				<next:ToolBarItem iconCls="undo"  text="取消" handler="doClose"/>
			</next:TopBar>
			<next:Tree name="组织结构树" id="strutree1" width="100%" height="100%" autoScroll="true" rootVisible="true" rootExpanded="false"
			 			border="false"  bodyBorder="2"  lines="true"    >
				<!—定义树的数据模型-->
				<next:TreeDataSet dataset="stru" root="rootdata">
					<next:TreeLoader cmd="org.loushang.workflow.client.common.help.cmd.TaskHelpCmd" method="selectUnderlingStruInfo">
						<next:treeRecord name="struRecord" idField="struId">
							<model:field name="struId" type="string"/>
							<model:field name="organId" type="string"/>
							<model:field name="organName" type="string"/>
							<model:field name="organType" type="string"/>
							<model:field name="parentId" type="string"/>
						</next:treeRecord>
						<next:TreeBaseparam name="parentId" value="getStruParent"></next:TreeBaseparam>
						<next:TreeBaseparam name="struId" value="getStruId"></next:TreeBaseparam>
						<next:TreeBaseparam name="struType" value="getStruType"></next:TreeBaseparam>
						<next:TreeBaseparam name="struTypeId" value="getStruTypeId"></next:TreeBaseparam>
					</next:TreeLoader>
				</next:TreeDataSet>
				<!—TreeNodemodel将后台数据映射到树形节点上-->
				<next:TreeNodemodel recordType="struRecord">
					<next:TreeNodeAttribute name="text" mapping="organName"></next:TreeNodeAttribute>
					<next:TreeNodeAttribute name="icon" handler="getIcon" ></next:TreeNodeAttribute>
					<next:TreeNodeAttribute name="disabled" handler="getStrudisabled"></next:TreeNodeAttribute>
					<next:TreeNodeAttribute name="showType" handler="getChoiceBox"></next:TreeNodeAttribute>
				</next:TreeNodemodel>
			</next:Tree>
	</next:Panel>
</BODY>
<script language="javascript">
var struTypeId='<%=request.getParameter("struTypeId")%>';
var struTypeName='<%=request.getParameter("struTypeName")%>';
if(struTypeName=="null" || struTypeName==""){
	struTypeName="人力资源"
}

var str=struTypeId;
if(str=="null" || str==""){
	str="00";
}
/**
* 定义根节点结构
*/
var rootdata = {
	id : 'rootId',//唯一标志record,如果是前台配置生成record,需要指定id
	struId:'rootId',
	organId:'rootId',
	organName:'组织机构树',
	organType:'1',
	parentId:'-1',
	recordType : 'struRecord'
};

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
* 事件处理：设置organId为空
*/
function getStrudisabled(rec){
	return false;
}

/**
* 事件处理：确认按钮事件
*/
function doConfirm(){
	var selectedStru = L5.getCmp('strutree1');
	var organType = selectedStru.getChecked("organType");
	if(organType!=""){
		var value=parseInt(organType);
		//判断是否为叶节点
		if(value==8){
			var returnV=new Array(2);
			//选择的处理人的organId
			returnV[0]=selectedStru.getChecked("organId")[0];
			//选择的处理人的organName
			returnV[1]=selectedStru.getChecked("organName")[0];
			parent.returnValue=returnV;
			parent.close();
			}else{
				alert("请选择到具体的处理人！");
				}
	}else{
		alert("请选择具体的处理人！");
		}
}

/**
* 事件处理：取消按钮事件
*/
function doClose(){
	parent.close();
}


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
	if(rec.get('id') == 'rootId'){
		file = figpath+'/l5/root.gif';
	}
	return file;
}

function getChoiceBox(record){
	//后台判断的方法，不符合条件的，后台将organId置空，从而无法选中
	var organType=record.get("organType");
	var type=organType.substring(0,1);
	var value=parseInt(type);
	if(value==8){
		return  'radiobox';
	}else{
		return '';
		}
}
</script>