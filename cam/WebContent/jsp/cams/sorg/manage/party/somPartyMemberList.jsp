<%@ page language="java" contentType="text/html; charset=utf-8"pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="java.net.URLDecoder" %>
<html>
<!-- 党员功能表 -->
<head>
<next:ScriptManager></next:ScriptManager>
	<script type="text/javascript" src="somPartyMemberList.js"></script>
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
	}
	String sorgId=(String)request.getParameter("sorgId");
	if(sorgId == null){
		sorgId = "";
	}
%>
<script type="text/javascript">
	var searchSorgName='<%=searchSorgName%>';
	var searchSorgCode='<%=searchSorgCode%>';
	var searchSorgType='<%=searchSorgType%>';
	var sorgId='<%=sorgId%>';
	var morgArea='<%=BspUtil.getOrganCode()%>';
</script>
</head>
<body>
<model:datasets>
		<model:dataset id="somPartyMemberDS"  cmd="com.inspur.cams.sorg.manage.cmd.SomPartyMemberQueryCmd" >
			<model:record fromBean="com.inspur.cams.sorg.base.data.SomPartyMember"></model:record>
		</model:dataset>
		<model:dataset id="organDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" method="queryOrgan"  >
	      <model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
		</model:dataset>
		<model:dataset id="somPartyMemberQueryDataSet"  cmd="com.inspur.cams.sorg.manage.cmd.SomPartyMemberQueryCmd" >
			<model:record fromBean="com.inspur.cams.sorg.base.data.SomPartyMember"></model:record>
		</model:dataset>
		<model:dataset id="somPartyMemberStatusChangeDataSet"  cmd="com.inspur.cams.sorg.manage.cmd.SomPartyMemberStatusChangeQueryCommand" sortField="CHANGE_TIME">
			<model:record fromBean="com.inspur.cams.sorg.base.data.SomPartyMemberStatusChange"></model:record>
		</model:dataset>
		<model:dataset id="somPartyQueryDataSet_edit"  cmd="com.inspur.cams.sorg.manage.cmd.SomPartyQueryCmd" >
			<model:record fromBean="com.inspur.cams.sorg.base.data.SomParty"></model:record>
		</model:dataset>
		<model:dataset id="somPartyQueryDataSet_del"  cmd="com.inspur.cams.sorg.manage.cmd.SomPartyQueryCmd" >
			<model:record fromBean="com.inspur.cams.sorg.base.data.SomParty"></model:record>
		</model:dataset>
		<model:dataset id="somPartyQueryDataSet_in"  cmd="com.inspur.cams.sorg.manage.cmd.SomPartyQueryCmd" >
			<model:record fromBean="com.inspur.cams.sorg.base.data.SomParty"></model:record>
		</model:dataset>
		<model:dataset id="somPartyQueryDataSet_out"  cmd="com.inspur.cams.sorg.manage.cmd.SomPartyQueryCmd" >
			<model:record fromBean="com.inspur.cams.sorg.base.data.SomParty"></model:record>
		</model:dataset>
		<model:dataset id="cnNameDS" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
			<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
			<model:params>
				<model:param name="dic" value="SOM_ORGAN" ></model:param>
				<model:param name="value" value="SORG_ID" ></model:param>
				<model:param name="text" value="CN_NAME" ></model:param>
			</model:params>
		</model:dataset>
		<model:dataset id="peopleTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
			<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
			<model:params>
				<model:param name="dic" value='DIC_PARTY_PEOPLE_TYPE'></model:param>
				<model:param name="value" value='CODE'></model:param>
				<model:param name="text" value='NAME'></model:param>
			</model:params>
		</model:dataset>
		<model:dataset id="sorgTypeDS" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
			<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
			<model:params>
				<model:param name="dic" value='DIC_SORG_TYPE'></model:param>
				<model:param name="value" value='CODE'></model:param>
				<model:param name="text" value='NAME'></model:param>
			</model:params>
		</model:dataset>
		<model:dataset id="politicsDS" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
			<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
			<model:params>
				<model:param name="dic" value='DIC_POLITICAL'></model:param>
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
		<model:dataset id="belong_rel" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
			<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
			<model:params>
				<model:param name="dic" value='DIC_PARTY_RELATION'></model:param>
				<model:param name="value" value='CODE'></model:param>
				<model:param name="text" value='NAME'></model:param>
			</model:params>
		</model:dataset>
		<model:dataset id="groupTypeDS" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
			<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
			<model:params>
				<model:param name="dic" value='DIC_PARTY_GROUP_TYPE'></model:param>
				<model:param name="value" value='CODE'></model:param>
				<model:param name="text" value='NAME'></model:param>
			</model:params>
		</model:dataset>
		<model:dataset id="educationSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
			<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
			<model:params>
				<model:param name="dic" value='DIC_EDUCATION'></model:param>
				<model:param name="value" value='CODE'></model:param>
				<model:param name="text" value='NAME'></model:param>
			</model:params>
		</model:dataset>
		<model:dataset id="folkSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
			<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
			<model:params>
				<model:param name="dic" value='DIC_NATION'></model:param>
				<model:param name="value" value='CODE'></model:param>
				<model:param name="text" value='NAME'></model:param>
			</model:params>
		</model:dataset>
		<model:dataset id="SEX" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
		<model:dataset id="outTypeSelect" enumName="SOM.PARTY.OUT_TYPE" autoLoad="true" global="true"></model:dataset>
		<model:dataset id="statusChangeTypeSelect" enumName="SOM.PARTY.MEMBER.STATUS_TYPE" autoLoad="true" global="true"></model:dataset>
		<model:dataset id="statusChangeTypePartSelect" enumName="SOM.PARTY.MEMBER.STATUS_TYPE" autoLoad="true" global="true"></model:dataset>
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
								<td class="FieldLabel" width='14%'><label>社会组织名称：</label></td>
								<td class="FieldInput" width='14%'><input id="qsorgName" type="text" style='width:90%'/></td>
								<td class="FieldLabel" width='14%'><label>登记证号：</label></td>
								<td class="FieldInput" width='14%'><input id="qsorgCode" type="text"style='width:90%'/></td>
								<td class="FieldLabel" width='14%'><label>社会组织类型：</label></td>
								<td class="FieldInput" width='14%'><select id="qsorgType"style='width:90%'><option dataset="sorgTypeDS"></option></select></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>转入状态：</label></td>
								<td class="FieldInput"><select id="qinType" style='width:90%'><option dataset="inTypeSelect"></option></select></td>
								<td class="FieldLabel"><label>转出状态：</label></td>
								<td class="FieldInput"><select id="qoutType" style='width:90%'><option dataset="outTypeSelect"></option></select></td>
								<td class="FieldButton" width='14%'><button  onclick="query();">查询</button></td>
								<td class="FieldButton" width='14%'><button type="reset">重置</button></td>
							</tr>
						</table>
						</form>
						</div>
						</fieldset>
					</next:Html>
	</next:Panel>

		<next:GridPanel id="somPartyMemberEdit"  dataset="somPartyMemberDS" enableHdMenu="true" height="99.9%" width="100%" >
			<next:TopBar>
				<next:ToolBarItem symbol="党员明细信息"></next:ToolBarItem>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem text="增加党员" iconCls="add" handler="addPartyMember" ></next:ToolBarItem>
				<next:ToolBarItem text="修改党员信息" iconCls="edit" handler="editPartyMember"></next:ToolBarItem>
				<next:ToolBarItem text="删除" iconCls="remove" handler="delPartyMember"></next:ToolBarItem>
				<next:ToolBarItem text="查看党员信息" iconCls="detail" handler="lookPartyMember"></next:ToolBarItem>
				<next:ToolBarItem text="整建制转入" iconCls="view" handler="inPartyMemberFull"></next:ToolBarItem>
				<next:ToolBarItem text="党员转入" iconCls="view" handler="inPartyMember"></next:ToolBarItem>
				<next:ToolBarItem text="党员转出" iconCls="disable" handler="outPartyMember"></next:ToolBarItem>
				<next:ToolBarItem text="党员状态变更" iconCls="edit" handler="changeStatus"></next:ToolBarItem>
				<next:ToolBarItem text="党建管理" iconCls="undo" handler="returnPartyList"></next:ToolBarItem>
			</next:TopBar>
			<next:Columns>
				<next:RowNumberColumn/>
				<next:RadioBoxColumn></next:RadioBoxColumn>
				<next:Column header="党员ID" hidden="true" id="memberId" field="memberId"   ><next:TextField /></next:Column>
				<next:Column header="姓名" id="name" field="name"   sortable="true" width="8%"><next:TextField /></next:Column>
				<next:Column header="社会组织名称" id="sorgId" field="sorgId"  dataset="cnNameDS" width="22%" sortable="true"><next:TextField /></next:Column>
				<next:Column header="人员类别" id="peopleType" field="peopleType"  dataset="peopleTypeSelect" width="8%" sortable="true"><next:TextField /></next:Column>
				<next:Column header="性别" id="sex" field="sex" width="10%" dataset="SEX" sortable="true"><next:TextField /></next:Column>
				<next:Column header="出生年月" id="birthday" field="birthday" width="10%"  sortable="true"><next:TextField /></next:Column>
				<next:Column header="民族" id="folk" field="folk"  width="10%" sortable="true" dataset="folkSelect"><next:TextField /></next:Column>
				<next:Column header="学历" id="education" field="education" dataset="educationSelect" width="10%" sortable="true"><next:TextField /></next:Column>
				<next:Column header="转入类型" id="inType" field="inType" width="12%" align="center" dataset="inTypeSelect" ><next:TextField allowBlank="false"/></next:Column>
				<next:Column header="转出类型" field="outType" width="10%"  sortable="true" dataset="outTypeSelect"><next:TextField /></next:Column>
				<next:Column header="党员状态" field="memberStatus" width="10%"  sortable="true" dataset="statusChangeTypeSelect"><next:TextField /></next:Column>
			</next:Columns>
			<next:BottomBar>
						<next:PagingToolBar dataset="somPartyMemberDS"  />
			</next:BottomBar>
		</next:GridPanel>

<next:Window id="outWin" closeAction="hide" title="转出情况" width="600" modal="true">
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
<next:Window id="changeStatusWin" closeAction="hide" title="党员状态变更情况" width="600" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="yes" text="确定" handler="confirmChange"></next:ToolBarItem>
		<next:ToolBarItem iconCls="detail" text="查看党员状态变更历史" handler="showChangeListWin"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="closeChange"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form onsubmit="return false" style="padding: 5px;" class="L5form">
		<table width="100%" >
			<tr>
				<td class="FieldLabel"  width="14%"><label>党员状态:</label></td>
				<td class="FieldInput"  width="19%"><select id="memberStatus" field='memberStatus'  style="width: 90%"><option dataset='statusChangeTypePartSelect'></option></select><font color="red">*</font></td>
				<td class="FieldLabel"  width="14%"><label>党员状态变更时间(如死亡时间、出党时间等):</label></td>
				<td class="FieldInput"  width="19%"><input type="text" name="党员状态变更时间" id="statusChangeDate" format="Y-m-d" field="statusChangeDate" style="width: 90%" onclick="WdatePicker();"/><font color="red">*</font></td>
			</tr>
		</table>
		</form>
   </next:Html>
</next:Window>
<next:Window id="ChangeListWin" closeAction="hide" title="党员状态变更历史查看" width="600" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="closeChangeListWin"></next:ToolBarItem>
	</next:TopBar>
	<next:GridPanel id="somPartyMemberStatusChangeDetail"  dataset="somPartyMemberStatusChangeDataSet" enableHdMenu="true" height="300" width="600" >
			<next:Columns>
				<next:RowNumberColumn/>
				<next:RadioBoxColumn></next:RadioBoxColumn>
				<next:Column header="变更ID" hidden="true" id="changeId" field="changeId"   ><next:TextField /></next:Column>
				<next:Column header="党员ID" hidden="true" id="memberId" field="memberId"   ><next:TextField /></next:Column>
				<next:Column header="变更类型" id="changeType" field="changeType"  dataset="statusChangeTypeSelect" width="15%" sortable="true"><next:TextField /></next:Column>
				<next:Column header="变更时间" id="changeTime" field="changeTime" width="10%"  sortable="true"><next:TextField /></next:Column>
				<next:Column header="登记人" id="regPeople" field="regPeople"   sortable="true" width="13%"><next:TextField /></next:Column>
				<next:Column header="登记时间" id="regDate" field="regDate"  width="10%" sortable="true"><next:TextField /></next:Column>
			</next:Columns>
			<next:BottomBar>
						<next:PagingToolBar dataset="somPartyMemberStatusChangeDataSet"  />
			</next:BottomBar>
		</next:GridPanel>
</next:Window>
</body>
</html>