<%@ page language="java" contentType="text/html; charset=UTF-8"pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="java.net.URLDecoder" %>
<html>
<!-- 主功能表 -->
<head>
<next:ScriptManager></next:ScriptManager>
		<script type="text/javascript" src="somPartyList.js"></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js") %>'></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<script type="text/javascript">

	function collapse(element){
		var fieldsetParent=L5.get(element).findParent("fieldset");
		if(element.expand==null||element.expand==true){
			fieldsetParent.getElementsByTagName("div")[0].style.display="none";
			element.src = '<%=SkinUtils.getImage(request,"groupbox_expand.gif")%>';
			element.expand=false;
		}else{
			fieldsetParent.getElementsByTagName("div")[0].style.display="";
			element.src = "<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>";
			element.expand =true;
		}
	}


</script>
<%
	String searchSorgName=(String)request.getParameter("searchSorgName");
	if(searchSorgName == null){
		searchSorgName = "";
	}else{
		searchSorgName = URLDecoder.decode((String)searchSorgName, "UTF-8");
	}
	String searchSorgCode=(String)request.getParameter("searchSorgCode");
	if(searchSorgCode == null){
		searchSorgCode = "";
	}else{
		searchSorgCode = URLDecoder.decode((String)searchSorgCode, "UTF-8");
	}
	String searchSorgType=(String)request.getParameter("searchSorgType");
	if(searchSorgType == null){
		searchSorgType = "";
	}else{
		searchSorgType = URLDecoder.decode((String)searchSorgType, "UTF-8");
	}
	String partyId=(String)request.getParameter("partyId");
	if(partyId == null){
		partyId = "";
	}
%>
<script type="text/javascript">
	var searchSorgName='<%=searchSorgName%>';
	var searchSorgCode='<%=searchSorgCode%>';
	var searchSorgType='<%=searchSorgType%>';
	var partyId='<%=partyId%>';
	var morgArea='<%=BspUtil.getOrganCode()%>';
</script>
</head>
<body>
	<model:datasets>
		<model:dataset id="somPartyDS"  cmd="com.inspur.cams.sorg.manage.cmd.SomPartyQueryCmd" >
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
	 	<model:dataset id="if_build_par" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	 	<model:dataset id="outTypeSelect" enumName="SOM.PARTY.OUT_TYPE" autoLoad="true" global="true"></model:dataset>
	 	<model:dataset id="inTypeSelect" enumName="SOM.PARTY.IN_TYPE" autoLoad="true" global="true"></model:dataset>
	</model:datasets>
	<next:Panel width="100%" border="0">
					<next:Html>
						<fieldset><legend>查询条件
						<img class="GroupBoxExpandButton" src=<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%> onclick="collapse(this);"/>
						</legend>
						<div>
						<form class="L5form">
						<table width="100%">
							<tr>
								<td class="FieldLabel" style='width:12.5%'><label>社会组织名称：</label></td>
								<td class="FieldInput" style='width:12.5%'><input type="text" id="qsorgName" style='width:90%'/></td>
								<td class="FieldLabel" style='width:12.5%'><label>登记证号：</label></td>
								<td class="FieldInput" style='width:12.5%'><input id="qsorgCode" type="text"style='width:90%'/></td>
								<td class="FieldLabel" style='width:12.5%'><label>社会组织类型：</label></td>
								<td class="FieldInput" style='width:12.5%'><select id="qsorgType" style='width:90%'><option dataset="sorg_type"></option></select></td>
								<td class="FieldButton" style='width:12.5%'><button  onclick="query();">查询</button></td>
							</tr>
							<tr>
								<td class="FieldLabel" style='width:12.5%'><label>党组织是否建立：</label></td>
								<td class="FieldInput" style='width:12.5%'><select id="qifBuildParty" style='width:90%'><option dataset="if_build_par"></option></select></td>
								<td class="FieldLabel"><label>党组织类型：</label></td>
								<td class="FieldInput"><select id="qpartyType" style='width:90%'><option dataset="party_type" ></option></select></td>
								<td class="FieldLabel"><label>党组织状态：</label></td>
								<td class="FieldInput"><select id="qpartyStatus" style='width:90%'><option dataset="partyStatusDS"></option></select></td>
								<td class="FieldButton"><button type="reset">重置</button></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>党组织建制：</label></td>
								<td class="FieldInput"><select id="qbuildType" style='width:90%'><option dataset="build_type"></option></select></td>
								<td class="FieldLabel"><label>转入状态：</label></td>
								<td class="FieldInput"><select id="qinType" style='width:90%'><option dataset="inTypeSelect"></option></select></td>
								<td class="FieldLabel"><label>转出状态：</label></td>
								<td class="FieldInput"><select id="qoutType" style='width:90%'><option dataset="outTypeSelect"></option></select></td>
								<td class="FieldButton"></td>
							</tr>
						</table>
						</form>
						</div>
						</fieldset>
					</next:Html>
	</next:Panel>
	<next:GridPanel id="somPartyGrid"  dataset="somPartyDS" stripeRows="true" width="100%"  height="99.9%">
		<next:TopBar>
			<next:ToolBarItem symbol="社会组织党建信息"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem text="党建情况登记" iconCls="add"  handler="addParty"></next:ToolBarItem>
			<next:ToolBarItem text="党建情况修改" iconCls="edit" handler="editSomParty"></next:ToolBarItem>
			<next:ToolBarItem text="党建情况详情" iconCls="detail" handler="detailSomParty"></next:ToolBarItem>
			<next:ToolBarItem text="整建制转出" iconCls="disable" handler="fullPartyOut"></next:ToolBarItem>
			<next:ToolBarItem text="党建撤销备案" iconCls="remove" handler="cancleParty"></next:ToolBarItem>
			<next:ToolBarItem text="党员信息管理" iconCls="view" handler="somPartyMemberList"></next:ToolBarItem>
		</next:TopBar>

		<next:Columns>
	     <next:RowNumberColumn width="20"/>
	   	<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column hidden="true" header="党建登记编号" id="partyId"  field="partyId"  ><next:TextField allowBlank="false"/></next:Column>
			<next:Column hidden="true" header="社会组织ID" id="sorgId"  field="sorgId"  ><next:TextField allowBlank="false"/></next:Column>
			<next:Column header="社会组织名称" id="sorgName" width="25%" field="sorgName" align="center" ><next:TextField allowBlank="false"/></next:Column>
			<next:Column header="党组织类别" id="buildType"  field="buildType" width="20%" dataset="build_type" align="center"><next:TextField allowBlank="false"/></next:Column>
			<next:Column header="社会组织类型" id="sorgType" field="sorgType" width="14%" dataset="sorg_type" align="center"><next:TextField allowBlank="false"/></next:Column>
			<next:Column header="党组织是否建立" id="ifBuildParty" field="ifBuildParty" width="12%" dataset="if_build_par" align="center"><next:TextField allowBlank="false"/></next:Column>
			<next:Column header="党建状态" id="partyStatus" field="partyStatus" width="12%" align="center" dataset="partyStatusDS" ><next:TextField allowBlank="false"/></next:Column>
			<next:Column header="党组织成立时间" id="buildDate" field="buildDate" width="12%" align="center" ><next:TextField allowBlank="false"/></next:Column>
			<next:Column header="转入类型" id="inType" field="inType" width="12%" align="center" dataset="inTypeSelect" ><next:TextField allowBlank="false"/></next:Column>
			<next:Column header="转出类型" id="outType" field="outType" width="12%" align="center" dataset="outTypeSelect" ><next:TextField allowBlank="false"/></next:Column>
		</next:Columns>
		<next:BottomBar>
					<next:PagingToolBar dataset="somPartyDS"  />
		</next:BottomBar>
	</next:GridPanel>
	<next:Window id="outWin" closeAction="hide" title="转出情况" width="800" modal="true">
		<next:TopBar>
			<next:ToolBarItem symbol="->" ></next:ToolBarItem>
			<next:ToolBarItem iconCls="yes" text="确定" handler="confirmOut"></next:ToolBarItem>
			<next:ToolBarItem iconCls="return" text="关闭" handler="closeOut"></next:ToolBarItem>
		</next:TopBar>
		<next:Html>
			<form onsubmit="return false" style="padding: 5px;" class="L5form">
			<table width="100%" >
				<tr>
					<td class="FieldLabel"  width="14%"><label>转出时间:</label></td>
					<td class="FieldInput"  width="19%"><input type="text" name="转出时间" id="outTime" format="Y-m-d"  field="outTime" onclick="WdatePicker();" style="width: 90%"/><font color="red">*</font></td>
					<td class="FieldLabel"  width="14%"><label>转出到何单位:</label></td>
					<td class="FieldInput"  width="19%"><input type="text" name="转出到何单位" id="outToOrgan" field="outToOrgan" style="width: 90%"/><font color="red">*</font></td>
				</tr>
			</table>
			</form>
	   </next:Html>
	</next:Window>
</body>
</html>