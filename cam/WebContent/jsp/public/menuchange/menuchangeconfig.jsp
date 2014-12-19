
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
	   ext_jsfile = "../../bsp/demo/organext/organ_ext.js";
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
	<model:dataset id="ds" cmd="com.inspur.cams.comm.menuconfig.cmd.MenuConfigCommand" method="getUnderlingByOrganType" pageSize="50"  global="true">
	</model:dataset>
	<model:dataset id="menuTypeds" cmd="com.inspur.cams.comm.menuconfig.cmd.MenuConfigCommand" method="getMenuType" pageSize="50"  autoLoad="true"  global="true">
		<model:record>
			<model:field name="value" mapping="MENU_TYPE_ID" type="string" />
			<model:field name="text" mapping="MENU_TYPE_NAME" type="string" />
		</model:record>
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
							<next:MenuItem text="设置菜单" handler="menuConfig"></next:MenuItem>
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
		 <next:Panel id="menuconfigpanel" title="设置菜单" hidden="true" autoScroll="true" >
		 	 <next:GridPanel id="menuconfigpanelgridpanel" dataset="ds" stripeRows="true" anchor="100% 100%" height="360">
		 	 	<next:TopBar>
					<next:ToolBarItem  text='组织代码' />
					<next:ToolBarItem  xtype="textfield" id="organCodequery" />
					<next:ToolBarItem  text='组织名称' />
					<next:ToolBarItem  xtype="textfield" id="organNamequery" />
					<next:ToolBarItem text='查询' iconCls="query" handler="query" />
	   			    <next:ToolBarItem symbol="->" ></next:ToolBarItem>
	   			    <next:ToolBarItem iconCls="locate" text="选择菜单" handler="setAll"/>
					<next:ToolBarItem iconCls="locate" text="定位" handler="locate" />
				</next:TopBar>
				<next:Columns>
					<next:RowNumberColumn/>
					<next:CheckBoxColumn></next:CheckBoxColumn>
					<next:Column id="organCode" header="组织代码" width="150" sortable="true" field="ORGAN_CODE"/>
					<next:Column header="组织名称" width="150" sortable="true" field="ORGAN_NAME" />
					<next:Column header="组织简称" width="150" sortable="true" field="SHORT_NAME" />
					<next:Column header="菜单类型" width="150" sortable="true" field="MENU_TYPE_NAME" />
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="ds" />
				</next:BottomBar>
			</next:GridPanel>
		 </next:Panel>
		 </next:Panel>
	 </next:Center>
  </next:BorderLayout>
</next:Panel>
</next:AnchorLayout>
</next:ViewPort>
<next:Window id="showwindow" closeAction="hide" title="菜单应用窗口" width="550" height="100">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="应用到列表选择的员工" iconCls="detail" handler="saveWinPart"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="detail" handler="closeWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
			<table width="100%">
				<tr>
					<td class="FieldLabel">请选择菜单</td>
					<td class="FieldInput">
						 <select id="menuTypeinput">
						 <option dataset="menuTypeds" ></option>
					</select>
					</td>
					
				</tr>
			</table>
	</next:Html>
</next:Window>
</body>
<script type="text/javascript" src="menuchangeconfig.js"></script>
<script type="text/javascript" src="<%=ext_jsfile%>"></script>
</html>