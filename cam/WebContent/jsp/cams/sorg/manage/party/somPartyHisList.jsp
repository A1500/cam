<%@ page language="java" contentType="text/html; charset=UTF-8"pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<next:ScriptManager></next:ScriptManager>
		<script type="text/javascript" src="somPartyHisList.js"></script>	
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js") %>'></script>
		<script type="text/javascript">
		var morgArea='<%=BspUtil.getOrganCode()%>';
		</script>		
</head>
<body>
	<model:datasets>
		<model:dataset id="somPartyDS"  cmd="com.inspur.cams.sorg.manage.cmd.SomPartyQueryCmd" pageSize="30">
			<model:record fromBean="com.inspur.cams.sorg.base.data.SomParty"></model:record>
		</model:dataset>
		<model:dataset id="partyUpLoadDataSet" cmd="com.inspur.cams.sorg.manage.cmd.SomPartyHisImportCmd">
			<model:record fromBean="com.inspur.cams.sorg.base.data.SomParty"></model:record>
		</model:dataset>
		<model:dataset id="sorg_type" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
			<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
			<model:params>
				<model:param name="dic" value='DIC_SORG_TYPE'></model:param>
				<model:param name="value" value='CODE'></model:param>
				<model:param name="text" value='NAME'></model:param>
			</model:params>
		</model:dataset>
		<model:dataset id="party_type" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
			<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
			<model:params>
				<model:param name="dic" value='DIC_PARTY_TYPE'></model:param>
				<model:param name="value" value='CODE'></model:param>
				<model:param name="text" value='NAME'></model:param>
			</model:params>
		</model:dataset>
		<model:dataset id="build_type" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
			<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
			<model:params>
				<model:param name="dic" value='DIC_PARTY_BUILD_TYPE'></model:param>
				<model:param name="value" value='CODE'></model:param>
				<model:param name="text" value='NAME'></model:param>
			</model:params>
		</model:dataset>
		<model:dataset id="nobuild_reason" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
			<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
			<model:params>
				<model:param name="dic" value='DIC_PARTY_NOBUILD_REASON'></model:param>
				<model:param name="value" value='CODE'></model:param>
				<model:param name="text" value='NAME'></model:param>
			</model:params>
		</model:dataset>
		<model:dataset id="partyStatusDS" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
			<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
			<model:params>
				<model:param name="dic" value='DIC_PARTY_STATUS'></model:param>
				<model:param name="value" value='CODE'></model:param>
				<model:param name="text" value='NAME'></model:param>
			</model:params>
		</model:dataset>
		<model:dataset id="sorgIdSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
			<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
			<model:params>
				<model:param name="dic" value="SOM_ORGAN" ></model:param>
				<model:param name="value" value="SORG_CODE" ></model:param>
				<model:param name="text" value="SORG_ID" ></model:param>
			</model:params>
		</model:dataset>	
		<model:dataset id="belong_rel" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
			<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
			<model:params>
				<model:param name="dic" value='DIC_PARTY_RELATION'></model:param>
				<model:param name="value" value='CODE'></model:param>
				<model:param name="text" value='NAME'></model:param>
			</model:params>
		</model:dataset>
	 	<model:dataset id="if_build_par" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	 	<model:dataset id="outTypeSelect" enumName="SOM.PARTY.OUT_TYPE" autoLoad="true" global="true"></model:dataset>
	 	<model:dataset id="inTypeSelect" enumName="SOM.PARTY.IN_TYPE" autoLoad="true" global="true"></model:dataset>  
	</model:datasets>
	
	<next:GridPanel id="somPartyGrid"  dataset="somPartyDS" stripeRows="true" width="100%"  height="99.9%">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="edit" text="下载Excel模版" handler="onLoad"/>
			<next:ToolBarItem iconCls="import" text="导入Excel" handler="forImport"></next:ToolBarItem>
			<next:ToolBarItem text="修改" iconCls="edit" handler="updateParty"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
		<next:RowNumberColumn/>
	   	<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column hidden="true" header="党建登记编号" id="partyId"  field="partyId"  ><next:TextField allowBlank="false"/></next:Column>
		<next:Column hidden="true" header="社会组织ID" id="sorgId"  field="sorgId"  ><next:TextField allowBlank="false"/></next:Column>
		
		<next:Column header="社会组织名称" id="sorgName" width="15%" field="sorgName" align="center" ><next:TextField allowBlank="false"/></next:Column>
		<next:Column header="社会组织类型" id="sorgType" field="sorgType" width="7%" dataset="sorg_type" align="center"><next:TextField allowBlank="false"/></next:Column>
		<next:Column header="党建状态" id="partyStatus" field="partyStatus" width="6%" align="center" dataset="partyStatusDS" ><next:TextField allowBlank="false"/></next:Column>	
		<next:Column header="党组织是否建立" id="ifBuildParty" field="ifBuildParty" width="6%" dataset="if_build_par" align="center"><next:TextField allowBlank="false"/></next:Column>
		<next:Column header="党组织类别" id="buildType"  field="buildType" width="7%" dataset="build_type" align="center"><next:TextField allowBlank="false"/></next:Column>
		<next:Column header="党组织成立时间" id="buildDate" field="buildDate" width="9%" align="center" ><next:TextField allowBlank="false"/></next:Column>
		
		<next:Column header="审批单位" id="auditOrgan" field="auditOrgan" width="12%" align="center" ><next:TextField allowBlank="false"/></next:Column>
		<next:Column header="党组织隶属关系" id="belongRel" field="belongRel" width="8%" align="center" dataset="belong_rel"><next:TextField allowBlank="false"/></next:Column>
		<next:Column header="未建立党组织原因" id="nobuildReason" field="nobuildReason" width="8%" align="center" dataset="nobuild_reason" ><next:TextField allowBlank="false"/></next:Column>
		</next:Columns>
		<next:BottomBar>
					<next:PagingToolBar dataset="somPartyDS"  />
		</next:BottomBar>
	</next:GridPanel>
<next:Window id="importExcelWin" closeAction="hide" title="导入Excel" height="230" width="600" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="yes" text="确定" handler="click_import"></next:ToolBarItem>
		<next:ToolBarItem iconCls="delete" text="关闭" handler="click_close"></next:ToolBarItem>
		<next:ToolBarItem xtype="tbseparator" />
	</next:TopBar>
	<next:Html>
		<form id="upLoadFileForm" method="post" dataset="partyUpLoadDataSet"
			onsubmit="return false"  class="L5form">
		<table width="100%" border="1">
			<tr>
				<td class="FieldLabel" width="30%">请选择要导入的Excel文件:</td>
				<td class="FieldInput" width="70%"><input type="file" maxlength="200"
					id="uploadFile" name="uploadFile" style ="width:90%"/></td>
			</tr>
		</table>
		</form>
		<div style="position:relative;left:15px;color:red;font-size=11;width:550">
			备注：只能导入规定格式的EXCEL文件（可以通过【下载导入Excel模板】功能进行下载），文件大小不能超过1M！<br/>
		</div>
	</next:Html>
</next:Window>
<next:Window id="importListWin" closeAction="hide" title="错误信息列表" height="500" width="800" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="delete" text="关闭" handler="closeListWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form id="importListForm" class="L5form">
		<table id="errorList" width="100%" border="1" >
			<tr>
				<td  width="10%" align="center">序号</td>
				<td  width="90%" align="center">错误信息</td>
			</tr>
		</table>
		</form>
	</next:Html>
</next:Window>
</body>
</html>