
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<%@ page import="org.loushang.bsp.util.BspConfig" %>
<next:ScriptManager/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>组织-维护</title>
<%
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
	if(struTypeId=="null" || struTypeId==""){
		struTypeId="00";
	}
	var struTypeName='<%=request.getParameter("struTypeName")%>';
	if(struTypeName=="null" || struTypeName==""){
		struTypeName="人力资源"
	}
</script>
<style type="text/css">
	label{
		width:150px;

	}
</style>
</head>
<body>
<model:datasets>
	<model:dataset id="parentOrganType" cmd="org.loushang.bsp.organization.cmd.OrganTypeQueryCommand" method="query" autoLoad="true" sortField="ORGAN_TYPE" global="true" pageSize="-1">
		<model:record>
			<model:field name="value" mapping="organType" type="string" />
			<model:field name="text" mapping="typeName" type="string" />
		</model:record>
	</model:dataset>
	<model:dataset id="formset" global="true">
		<model:record fromBean="org.loushang.bsp.share.organization.bean.StruView"></model:record>
	</model:dataset>
	<model:dataset id="ds" cmd="org.loushang.bsp.organization.cmd.StruQueryCommand" method="getUnderling" pageSize="15"  global="true">
	</model:dataset>
	<model:dataset id="organTypeDs" cmd="org.loushang.bsp.organization.cmd.OrganTypeQueryCommand" sortField="organType" global="true" pageSize="-1">
		<model:record>
			<model:field name="value" mapping="organType" type="string"/>
			<model:field name="text" mapping="typeName" type="string"/>
		</model:record>
	</model:dataset>
</model:datasets>
<jsp:include page="<%=ext_dataset_file%>"></jsp:include>
<next:ViewPort>
<next:AnchorLayout>
<next:Panel anchor="100% 100%" bodyBorder="false" autoScroll="true">
<next:BorderLayout>
	<next:Left split="true" cmargins="5 0 0 0" margins="5 0 0 0" >
		<next:Panel title="组织结构树" id="struTypeNameTitle" collapsible="true" autoScroll="true" width="20%" >
			<next:Html>
		   			<next:Tree id="strutree1" border="false" width="100%" bodyBorder="2"  lines="true" >
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
						<next:TreeNodeAttribute name="text" mapping="organName"></next:TreeNodeAttribute>
						<next:TreeNodeAttribute name="disabled" handler="getStrudisabled"></next:TreeNodeAttribute>
						<next:TreeNodeAttribute name="icon" handler="getIcon" ></next:TreeNodeAttribute>
						<next:TreeNodeAttribute name="struPath" mapping="struId"></next:TreeNodeAttribute>
						<next:TreeNodeAttribute name="leaf" handler="getIsLeaf"></next:TreeNodeAttribute>
						<next:TreeNodeAttribute name="href" handler="'#'"></next:TreeNodeAttribute>
						<next:RightmouseMenu menuId="menuId1">
							<next:MenuItem text="增加下级" handler="addSub"></next:MenuItem>
							<next:MenuItem text="修改" handler="update"></next:MenuItem>
							<next:MenuItem text="删除" handler="delStru"></next:MenuItem>
							<next:MenuItem text="选择下级" handler="selectStru"></next:MenuItem>
							<next:MenuItem text="下级排序" handler="forOrder"></next:MenuItem>
							<next:MenuItem text="搜索下级" handler="searchSub"></next:MenuItem>
							<next:MenuItem text="变更隶属关系" handler="forMergeTo"></next:MenuItem>
							<next:MenuItem text="设置组织参数" handler="setParams"></next:MenuItem>
							<next:MenuItem text="修改序号" handler="setStruOrder"></next:MenuItem>
							<next:MenuItem text="导入" handler="importStru"></next:MenuItem>
							<next:MenuItem text="导出" handler="exportStru"></next:MenuItem>
						</next:RightmouseMenu>
						<next:RightmouseMenu trigger="handlerOther"  menuId="menuId3">
							<next:MenuItem text="增加下级" handler="addSub"></next:MenuItem>
							<next:MenuItem text="修改" handler="update"></next:MenuItem>
							<next:MenuItem text="删除" handler="delStru"></next:MenuItem>
							<next:MenuItem text="选择下级" handler="select"></next:MenuItem>
							<next:MenuItem text="搜索下级" handler="searchSub"></next:MenuItem>
						</next:RightmouseMenu>
						<next:RightmouseMenu trigger="handler"  menuId="menuId2">
							<next:MenuItem text="增加" handler="add"></next:MenuItem>
							<next:MenuItem text="导入" handler="importStru"></next:MenuItem>
							<next:MenuItem text="导出" handler="exportStru"></next:MenuItem>
						</next:RightmouseMenu>
						<next:Listeners>
							<next:Listener eventName="selected" handler="selectedStru"></next:Listener>
						</next:Listeners>
					</next:TreeNodemodel>
				</next:Tree>
			</next:Html>
		</next:Panel>
	 </next:Left>
		 <next:Center floatable="true" margins="5 0 0 0">
			<next:Panel autoScroll="true">
		 	<next:Panel id="detailpanel"  hidden="true" title="组织机构明细" border="0" autoScroll="true">
			<next:Html >
			<fieldset style="overflow: visible;" class="GroupBox">
				<legend class="GroupBoxTitle">组织信息</legend>
		 	      <form class="L5form" dataset="formset">
					 <table style="width:100%">
						<tr>
							<td style="width:20%" class="FieldLabel">组织代码</td>
							<td style="width:30%" class="FieldInput" >
								<label id="organCode" field="organCode">
							</td>
							<td style="width:20%" class="FieldLabel">组织名称</td>
							<td style="width:30%" class="FieldInput">
								<label id="organName" field="organName">
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">组织简称</td>
							<td class="FieldInput">
								<label id="shortName" field="shortName"/>
							</td>
							<td class="FieldLabel">组织类型</td>
							<td class="FieldInput">
								<label id="organTypeName" field="organTypeName"/>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">负责岗/负责人</td>
							<td class="FieldInput">
								<label id="principalName2" field="principalName"/>
							</td>
							<td class="FieldLabel">组织结构类型</td>
							<td class="FieldInput">
								<label id="struTypeName" field="struTypeName" />
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">所属部门</td>
							<td class="FieldInput">
								<label id="deptName" field="deptName"/>
							</td>
							<td class="FieldLabel">所属单位</td>
							<td class="FieldInput">
								<label id="cropName" field="cropName"/>
							</td>
						</tr>
					</table>
		 	      </form>
		 	 </fieldset>
          <jsp:include page="<%=organ_ext_detail_jspfile %>"></jsp:include>
		 </next:Html>
		 </next:Panel>
		 <next:Panel id="updatePanel" title="组织结构管理" hidden="true" border="0" autoScroll="true">
		 		<next:TopBar>
		 		    <next:ToolBarItem symbol="->"></next:ToolBarItem>
		 			<next:ToolBarItem id="saveButoon" iconCls="save" text="保存" handler="save"></next:ToolBarItem>
		 		</next:TopBar>
				<next:Html >
			<fieldset style="overflow: visible;" class="GroupBox">
				<legend class="GroupBoxTitle">组织信息</legend>
		 	 <div id="stru_update" >
		 	      <form class="L5form" dataset="formset">
					 <table style="width:100%">
						<tr>
							<td class="FieldLabel">组织代码</td>
							<td class="FieldInput">
								<input type="text" id="organCodeinput" field="organCode" maxlength="30" /><font color="red">*</font>
							</td>
							<td class="FieldLabel">组织名称</td>
							<td class="FieldInput">
								<input type="text" id="organNameinput" field="organName" maxlength="30"/><font color="red">*</font>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">组织简称</td>
							<td class="FieldInput">
								<input type="text" id="shortName" field="shortName" maxlength="30"/>
							</td>
							<td class="FieldLabel">组织类型</td>
							<td class="FieldInput">
								<select id="organTypeinput" field="organType">
								   <option dataset="parentOrganType" >
								</select>
								<font color="red">*</font>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">负责岗/负责人</td>
							<td class="FieldInput">
								<input type="text" id="principalName1" field="principalName" readonly="readonly" >
								<img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor:hand" onclick="updateSelectPrincipalId()"/>
								<input type="hidden" name="principalId" field="principalId"  />
							</td>
							<td class="FieldLabel">组织结构类型</td>
							<td class="FieldInput">
								<input type="text" id="struTypeName" field="struTypeName" readonly="readonly">
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">所属部门</td>
							<td class="FieldInput">
								<input type="text" id="deptName" field="deptName" readonly="readonly">
							</td>
							<td class="FieldLabel">所属单位</td>
							<td class="FieldInput">
								<input type="text" id="cropName" field="cropName" readonly="readonly">
							</td>
						</tr>
					</table>
		 	      </form>
		 	 </div>
		 	 </fieldset>
		 	 <jsp:include page="<%=organ_ext_update_jspfile %>"></jsp:include>
			</next:Html>
		 </next:Panel>

		 <next:Panel id="rootPanel" title="组织结构管理" hidden="true" autoScroll="true">
		 		<next:TopBar>
		 		    <next:ToolBarItem symbol="->"></next:ToolBarItem>
		 			<next:ToolBarItem iconCls="save" text="保存" handler="save"></next:ToolBarItem>
		 		</next:TopBar>
				<next:Html >
		 	 <div id="stru_update" dataset="formset">
		 	      <form  class="L5form">
					 <table style="width:100%">
						<tr>
							<td class="FieldLabel">组织代码</td>
							<td class="FieldInput">
								<input type="text" id="organCodeinput" field="organCode" maxlength="30"/><font color="red">*</font>
							</td>
							<td class="FieldLabel">组织名称</td>
							<td class="FieldInput">
								<input type="text" id="organNameinput" field="organName" maxlength="30"/><font color="red">*</font>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">组织简称</td>
							<td class="FieldInput">
								<input type="text" id="shortName" field="shortName"/>
							</td>
							<td class="FieldLabel">组织类型</td>
							<td class="FieldInput">
								<input type="text" id="organTypeName" field="organTypeName" readonly="readonly">
								<input type="hidden" name="organType" field="organType"  />
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">负责岗/负责人</td>
							<td class="FieldInput">
								<input type="text" id="principalName" field="principalName" readonly="readonly">
								<img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor:hand" onclick="selectPrincipalId()"/>
								<input type="hidden" name="principalId" field="principalId" />
							</td>
							<td class="FieldLabel">组织结构类型</td>
							<td class="FieldInput">
								<input type="text" id="struTypeName" field="struTypeName" readonly="readonly">
							</td>
						</tr>
					</table>
		 	      </form>
		 	 </div>
			</next:Html>
		 </next:Panel>
		 <next:Panel id="searchsubpanel" title="搜索下级" hidden="true" autoScroll="true" >
		 	 <next:GridPanel id="searchsubgridpanel" dataset="ds" stripeRows="true" anchor="100% 100%" height="360">
		 	 	<next:TopBar>
				<next:ToolBarItem  text='组织代码' />
				<next:ToolBarItem  xtype="textfield" id="organCodequery" />
				<next:ToolBarItem  text='组织名称' />
				<next:ToolBarItem  xtype="textfield" id="organNamequery" />
				<next:ToolBarItem text='查询' iconCls="query" handler="query" />
   			    <next:ToolBarItem symbol="->" ></next:ToolBarItem>
				<next:ToolBarItem iconCls="locate" text="定位" handler="locate" />
			</next:TopBar>
				<next:Columns>
					<next:RowNumberColumn/>
					<next:Column id="organCode" header="组织代码" width="150" sortable="true" field="ORGAN_CODE"/>
					<next:Column header="组织名称" width="150" sortable="true" field="ORGAN_NAME" />
					<next:Column header="组织简称" width="150" sortable="true" field="SHORT_NAME" />
					<next:Column header="组织类型" width="150" sortable="true" field="ORGAN_TYPE_NAME" />
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="ds" />
				</next:BottomBar>
			</next:GridPanel>
		 </next:Panel>
				<next:Panel id="dao" title=""  height="100%" width="100%" border="false" >
				 <next:Html>
					<div id="loadmask" style="display: none;" class="loading" >
				 <img src="<%=request.getContextPath()%>/skins/images/default/extanim32.gif"
				                        width="32" height="32" style="margin-right: 8px;" />正在处理...</div>
				 <iframe id="frame1" frameborder="no"  marginwidth="0" marginheight="0" allowtransparency="yes" 
					 style="overflow: auto" height="100%" width="100%" 
							src="../demo/blank.jsp"></iframe>
				</next:Html>
		 </next:Panel>
	</next:Panel>
   </next:Center>
	
  </next:BorderLayout>
</next:Panel>
</next:AnchorLayout>
</next:ViewPort>
</body>
<script type="text/javascript" src="stru_main.js"></script>
<script type="text/javascript" src="<%=ext_jsfile%>"></script>
</html>