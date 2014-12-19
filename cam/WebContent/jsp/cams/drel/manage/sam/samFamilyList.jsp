<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%
String struId = BspUtil.getStruId();
%>
<html>
<head>
<title>社会救助_家庭信息列表</title>
<next:ScriptManager />
<script type="text/javascript" src="samFamilyList.js"></script>
<script type="text/javascript" src="IDCard.js"></script>
<script type="text/javascript" src="FamilyComm.js"></script>
<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ygms/MultiSimpleGridHelp.js"></script>

<script language="javascript">
  //查询条件打开合并函数
 var struId='<%=struId%>';
 function collapse(element){
	 var fieldsetParent=L5.get(element).findParent("fieldset");
	 if(element.expand==null||element.expand==true){
       fieldsetParent.getElementsByTagName("div")[0].style.display="none";
	   element.src = '<%=SkinUtils.getImage(request, "groupbox_expand.gif")%>';
	   element.expand=false;
      }else{
		 fieldsetParent.getElementsByTagName("div")[0].style.display="";
		 element.src = "<%=SkinUtils.getImage(request, "groupbox_collapse.gif")%>";
		 element.expand =true;
	    }
   }
</script>
</head>
<body>
<model:datasets>
	 <model:dataset id="assistancetypeSelect" enumName="SAM_FAMILY_ASSISTANCE.ASSISTANCETYPE" autoLoad="true" global="true"></model:dataset>
		<!-- 救助类型 -->
	<model:dataset id="DmJzlxDataSet" cmd="com.inspur.cams.drel.dicm.cmd.DmQueryCommand" global="true" autoLoad="true" pageSize="20">
		<model:record fromBean="com.inspur.cams.drel.dicm.data.DmBean"></model:record>
		<model:params>
			<model:param name="tableName" value='DM_JZLX'></model:param>
		</model:params>
	</model:dataset>

	<model:dataset id="ds" cmd="com.inspur.cams.drel.sam.cmd.SamFamilyQueryCmd" pageSize="18" global="true" autoLoad="false"></model:dataset>
</model:datasets>

<next:Panel name="form" width="98%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true">
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox"><legend
			class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton"
			src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>"
			onclick="collapse(this)" /> </legend>
		<div>
		<form id="queryForm"   style="width: 98%; height: 100%;" class="L5form">
		<table border="1" style="width:100%;table-layout:fixed;">
			<tr>
				<td class="FieldLabel" width="10%">户主姓名:</td>
				<td class="FieldInput" width="15%"><input type="text" style="width:60%" id="familyName" name="familyName" maxlength="25" class="TextEditor" title="户主姓名" /></td>
				<td class="FieldLabel" width="10%">户主身份证:</td>
				<td class="FieldInput" width="15%"><input type="text" style="width:70%" id="familyCardNo" name="familyCardNo" maxlength="18"  class="TextEditor" title="户主身份证" /></td>

			    <td class="FieldLabel" width="10%">所属单位:</td>
				<td class="FieldInput" width="15%"><input type="text" style="width:60%" readonly name="regOrgName" id="regOrgName" />
									  <input type="text" style="display: none;"  name="regOrg" id="regOrg" field="regOrg" />
									 <img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"  style="cursor:hand" onclick="forHelp()" />
				</td>
			</tr>
			<tr>
			     <td class="FieldLabel" nowrap width="10%">救助类型:</td>
				<td class="FieldInput" style="width:20%">
							<select id="assistanceType" style="width:60%">
								<option dataset="assistancetypeSelect"></option>
							</select>
				</td>
			    <td class="FieldLabel" width="10%" nowrap="nowrap">录入日期：</td>
				<td class="FieldInput" colspan="1" width="15%" nowrap="nowrap"><input type="text" id="regTimeS" format="Y-m-d" name="regTimeS"  style="width:30%" onclick="LoushangDate(this)" readonly="readonly"/>-----
				<input type="text" id="regTimeT" format="Y-m-d" name="regTimeT"  style="width:30%"  onclick="LoushangDate(this)" readonly="readonly"/></td>
				<td  class="FieldInput" COLSPAN="2" style="text-align:center"  >
					<button onclick="jtxxQuery()">查 询</button>
				    <button onclick="reset()" style="margin-left: 15px;">重 置</button>
				</td>
			</tr>
		  </table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>
<next:GridPanel id="editGridPanel" name="baseinfoFamilyGrid" width="98%"
	stripeRows="true" height="100%" dataset="ds"  autoScroll="true" collapsible="true" autoWidth="true">
	<next:TopBar>
		<next:ToolBarItem symbol="困难户家庭信息登记列表"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="登记" iconCls="add" handler="insert" />
		<next:ToolBarItem text="变更" iconCls="edit" handler="update" />
		<next:ToolBarItem text="注销" iconCls="remove" handler="del" />
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="FAMILY_ID" header="家庭ID" field="FAMILY_ID" hidden="true" align="center" width="90">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="FAMILY_NAME" header="户主姓名" field="FAMILY_NAME" width="140" align="center" renderer="familyDetailHref"/>
		<next:Column id="FAMILY_CARD_NO" header="身份证号" field="FAMILY_CARD_NO" width="140" align="center"/>
		<next:Column id="PEOPLE_NUM" header="人口数量" field="PEOPLE_NUM" width="100" align="center"/>
	    <next:Column id="YEAR_INCOME" header="家庭年收入" field="YEAR_INCOME" width="100" align="right"/>
		<next:Column id="REG_PEOPLE" header="录入人姓名" field="REG_PEOPLE" width="140" align="center"/>
		<next:Column id="REG_ORG_NAME" header="录入单位名称" field="REG_ORG_NAME" width="140" align="center"/>
		<next:Column id="REG_TIME" header="录入时间" field="REG_TIME" width="140" align="center"/>
		<next:Column id="PHOTO_ID" header="照片ID" field="PHOTO_ID" width="140" hidden="true" align="center"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
