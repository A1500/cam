<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>优抚档案目录</title>
<next:ScriptManager/>
<script type="text/javascript" src="bptcataloguearchives.js"></script>
<script language="javascript">
			 var struId = '<%=BspUtil.getStruId()%>';
             var organCode = '<%=BspUtil.getOrganCode()%>';
             var organType='<%=BspUtil.getOrganType()%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="bptCatalogueArchives_detaildataset" global="true" sortField="catalogOrder">
	    <model:record fromBean="com.inspur.cams.bpt.edoc.data.BptCatalogueArchives"></model:record>
	</model:dataset>
	<!-- 业务类型 -->
	<model:dataset id="dsService"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BPT_SERVICE_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
	<next:ViewPort>
	<next:BorderLayout>
	<next:Left>
		<next:Panel title="优抚目录" collapsible="true" width="35%" autoScroll="true">
			<next:Tree name="bptCatalogueArchivestree" id="bptCatalogueArchivestree" collapsible="true"  lines="true">
				<next:TreeDataSet dataset="bptCatalogueArchivesDataSet" root="rootdata" >
					<next:TreeLoader cmd="com.inspur.cams.bpt.manage.cmd.BptCatalogueArchivesQueryCommand" >
						<next:treeRecord name="bptCatalogueArchivesRecord" idField="catalogID">
						    <model:field name="catalogID" type="string"/>
		   					<model:field name="catalogCode" type="string"/>	
		   					<model:field name="catalogName" type="string"/>	
		   					<model:field name="upCatalogCode" type="string"/>	
		   					<model:field name="catalogInfo" type="string"/>	
		   					<model:field name="catalogOrder" type="string"/>	
		   					<model:field name="organId" type="string"/>	
		   					<model:field name="serviceType" type="string"/>
		   					<model:field name="leve" type="string"/>
		   					<model:field name="flag" type="string"/>
						</next:treeRecord>
						<next:TreeBaseparam name="UP_CATALOG_CODE@=" value="getParent"/>
						<next:TreeBaseparam name="ORGAN_ID@=" value='<%=request.getParameter("organCode")%>'/>
					</next:TreeLoader>
				</next:TreeDataSet>
				<next:TreeNodemodel recordType="bptCatalogueArchivesRecord">
					<next:TreeNodeAttribute name="text" mapping="catalogName"></next:TreeNodeAttribute>
					<next:TreeNodeAttribute name="disabled" handler="getBptCatalogueArchivesdisabled"></next:TreeNodeAttribute>
					<next:RightmouseMenu menuId="bptCatalogueArchives">
						<next:MenuItem text="新增" handler="addBptCatalogueArchives"></next:MenuItem>
						<next:MenuItem text="修改" handler="updateBptCatalogueArchives"></next:MenuItem>
						<%--<next:MenuItem text="删除" handler="delBptCatalogueArchives"></next:MenuItem>--%>
					</next:RightmouseMenu>
					<next:Listeners>
						<next:Listener eventName="selected" handler="selectedBptCatalogueArchives"></next:Listener>
					</next:Listeners>
				</next:TreeNodemodel>
			</next:Tree>
		</next:Panel>
	</next:Left>
	<next:Center floatable="true" margins="5 0 0 0">
	<next:Panel >
	<next:Panel id="detailPanel" title="基本信息" name="detailPanel"  hidden="true">
		<next:Html >
		 	 <div id="bptCatalogueArchives_detail" dataset="bptCatalogueArchives_detaildataset">
		 	      <form class="L5form" >
					 <table style="width:100%">
						<input type="hidden" id="catalogCode" field="catalogCode">
						<tr>
						    <td class="FieldLabel">目录名称:</td>
							<td class="FieldInput">
								<label id="catalogName" field="catalogName" >
							</td>
						</tr>
					   	<tr>
						    <td class="FieldLabel">上级目录代码:</td>
							<td class="FieldInput">
								<label id="upCatalogCode" field="upCatalogCode" >
							</td>
							
						</tr>
						<tr>
						  <td class="FieldLabel">目录描述:</td>
							<td class="FieldInput">
								<label id="catalogInfo" field="catalogInfo" >
							</td>
						</tr>
					   	<tr>
						    <td class="FieldLabel">显示顺序:</td>
							<td class="FieldInput">
								<label id="catalogOrder" field="catalogOrder" >
							</td>
						</tr>
						<tr>
						    <td class="FieldLabel">业务类型:</td>
							<td class="FieldInput">
								<label id="serviceType" field="serviceType" dataset="dsService"/>
				            </td>
						</tr>	
					</table>
		 	      </form>
		 	 </div>
			</next:Html>
	</next:Panel>
	<next:Panel id="updatePanel" name="updatePanel" hidden="true">
	<next:TopBar>
	    <next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem id="saveButoon" iconCls="save" text="保存" handler="save"></next:ToolBarItem>
		<next:ToolBarItem id="saveButoon" iconCls="undo" text="返回" handler="back"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
	<div id="bptCatalogueArchives_update" dataset="bptCatalogueArchives_detaildataset" >
		<form class="L5form" >
		<table style="width:100%">
		<input type="hidden" id="catalogCode" field="catalogCode">
		<tr>
		 <td class="FieldLabel">目录名称:</td>
		 <td class="FieldInput">
				<input type="text" id="catalogName" field="catalogName" maxlength="120"/><font color="red">*</font>
				<input type="hidden" id="upCatalogCode" field="upCatalogCode" />
		 </td>
		</tr>
		 
		 <tr>
		   <td  class="FieldLabel" >业务类型</td>
				<td class="FieldInput">
				    <select  style="width: 240px;" id="serviceType" field="serviceType" >
					<option dataset="dsService"></option>
				  </select><font color="red">*</font>
				 </td>
		 </tr>
		 
		<tr>
		<td class="FieldLabel">显示顺序:</td>
			<td class="FieldInput">
				<input type="text" id="catalogOrder" field="catalogOrder" /><font color="red">*</font>
		</td>
		</tr>
		
		
		<tr>
		
	   		<td class="FieldLabel">目录描述:</td>
			<td class="FieldInput">
				<input type="text" id="catalogInfo" field="catalogInfo" />
			</td>
				
	   	</tr>
	   	</table>
	 </form>
	</div>
	</next:Html>
	</next:Panel>
	</next:Panel >
	</next:Center>
	</next:BorderLayout>
	</next:ViewPort>
</body>
</html>
