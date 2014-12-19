
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="org.loushang.bsp.util.BspConfig"%>
<next:ScriptManager />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>选择代理人</title>
<%
  String webPath="http://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();
  
  String  ext_jsfile = BspConfig.getString("organ_ext_jsfile_path");
  if(ext_jsfile==null||"".equals(ext_jsfile.trim()))
	   ext_jsfile = "../demo/organext/organ_ext.js";
  String ext_dataset_file = BspConfig.getString("organ_ext_dataset_file_path");
  if(ext_dataset_file==null)
	  ext_dataset_file="/jsp/bsp/demo/blank.jsp";
  String organ_ext_detail_jspfile=BspConfig.getString("organ_ext_detail_jspfile_path");
  if(organ_ext_detail_jspfile==null)
	  organ_ext_detail_jspfile="/jsp/bsp/demo/blank.jsp";
  String organ_ext_update_jspfile=BspConfig.getString("organ_ext_update_jspfile_path");
   if(organ_ext_update_jspfile==null)
	  organ_ext_update_jspfile="/jsp/bsp/demo/blank.jsp";
%>
<script type="text/javascript">
	var struTypeId='<%=request.getParameter("struTypeId")%>';
	var struTypeName='<%=request.getParameter("struTypeName")%>';
	if(struTypeName=="null" || struTypeName==""){
		struTypeName="人力资源"
	}
</script>
<style type="text/css">
label {
	width: 150px;
}
</style>
</head>
<body>
<model:datasets>
	<model:dataset id="parentOrganType"
		cmd="org.loushang.bsp.organization.cmd.OrganTypeQueryCommand"
		method="query" autoLoad="true" sortField="ORGAN_TYPE" global="true"
		pageSize="-1">
		<model:record>
			<model:field name="value" mapping="organType" type="string" />
			<model:field name="text" mapping="typeName" type="string" />
		</model:record>
	</model:dataset>
	<model:dataset id="formset" global="true">
		<model:record
			fromBean="org.loushang.bsp.share.organization.bean.StruView"></model:record>
	</model:dataset>
	<model:dataset id="ds"
		cmd="org.loushang.bsp.organization.cmd.StruQueryCommand"
		method="getUnderling" pageSize="15" global="true">
	</model:dataset>
	<model:dataset id="organTypeDs"
		cmd="org.loushang.bsp.organization.cmd.OrganTypeQueryCommand"
		sortField="organType" global="true" pageSize="-1">
		<model:record>
			<model:field name="value" mapping="organType" type="string" />
			<model:field name="text" mapping="typeName" type="string" />
		</model:record>
	</model:dataset>
</model:datasets>
<jsp:include page="<%=ext_dataset_file%>"></jsp:include>
<next:ViewPort>
	<next:AnchorLayout>
		<next:Panel anchor="100% 100%" bodyBorder="false" autoScroll="true">
			<next:BorderLayout>
				<next:Left split="true" cmargins="5 0 0 0" margins="5 0 0 0">
					<next:Panel title="组织结构树" id="struTypeNameTitle" collapsible="true"
						autoScroll="true" width="100%">
						<next:TopBar>
							<next:ToolBarItem symbol="->"></next:ToolBarItem>
							<next:ToolBarItem iconCls="add" text="确定" handler="forSure" />
							<next:ToolBarItem iconCls="remove" text="关闭" handler="forClose" />
						</next:TopBar>
						<next:Html>
							<next:Tree id="strutree1" border="false" width="100%"
								bodyBorder="2" lines="true">
								<next:TreeDataSet dataset="stru" root="rootdata">
									<next:TreeLoader
										cmd="org.loushang.bsp.organization.cmd.StruQueryCommand"
										method="getRoot">
										<next:treeRecord name="struRecord" idField="struId"
											fromBean="org.loushang.bsp.share.organization.bean.StruView" />
										<next:TreeBaseparam name="parentId" value="getStruParent"></next:TreeBaseparam>
										<next:TreeBaseparam name="struId" value="getStruId"></next:TreeBaseparam>
										<next:TreeBaseparam name="struType" value="getStruType"></next:TreeBaseparam>
										<next:TreeBaseparam name="struTypeId" value="getStruTypeId"></next:TreeBaseparam>
									</next:TreeLoader>
								</next:TreeDataSet>
								<next:TreeNodemodel recordType="struRecord">
									<next:TreeNodeAttribute name="text" mapping="organName"></next:TreeNodeAttribute>
									<next:TreeNodeAttribute name="disabled"
										handler="getStrudisabled"></next:TreeNodeAttribute>
									<next:TreeNodeAttribute name="showType" handler="getChoiceBox"></next:TreeNodeAttribute>
									<next:TreeNodeAttribute name="icon" handler="getIcon" ></next:TreeNodeAttribute>
									<next:TreeNodeAttribute name="struPath" mapping="struId"></next:TreeNodeAttribute>
									<next:TreeNodeAttribute name="leaf" handler="getIsLeaf"></next:TreeNodeAttribute>
									<next:TreeNodeAttribute name="href" handler="'#'"></next:TreeNodeAttribute>
								</next:TreeNodemodel>
							</next:Tree>
						</next:Html>
					</next:Panel>
				</next:Left>
				<next:Center floatable="true" margins="5 0 0 0">
					<next:Panel autoScroll="true">
					</next:Panel>
				</next:Center>
			</next:BorderLayout>
		</next:Panel>
	</next:AnchorLayout>
</next:ViewPort>
</body>
<script type="text/javascript"
	src="<%=webPath%>/jsp/bsp/organization/stru_main.js"></script>
<script type="text/javascript" src="<%=ext_jsfile%>"></script>
<script type="text/javascript">
function forSure(){
	var tree = L5.getCmp('strutree1');
	var organName=tree.getChecked("organName");
	var organId=tree.getChecked("organId");
	var returnValue=[];
	returnValue[0]=organId;
	returnValue[1]=organName;
	
	L5.MessageBox.confirm("消息提示", "代理人为:"+organName,
			function(sta){
		if(sta =='yes'){
	window.returnValue = returnValue;
	window.close();
			}}
	);
}

function forClose(){
	window.returnValue="";
	window.close();
}

function getChoiceBox(rec){
	var leaf1=rec.get('isLeaf');
	if(leaf1=='1'){
			return 'checkbox';
			}
}
</script>
</html>