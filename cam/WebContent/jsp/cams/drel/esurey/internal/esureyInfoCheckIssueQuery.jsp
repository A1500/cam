<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil" %>
<html>
<head>
<title>申报家庭经济核对分发</title>
<next:ScriptManager />
<script type="text/javascript">
			var jtids='<%=request.getParameter("id")%>';
			var organCode='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
			var organId='<%=BspUtil.getCorpOrgan().getOrganId()%>';
			var checkOrg='<%=BspUtil.getCorpOrgan().getOrganName()%>';
		</script>
<script type="text/javascript" src="esureyInfoCheckIssueQuery.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script language="javascript">
		 	 //查询条件打开合并函数
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

	<!--申报家庭基本信息-->
	<model:dataset id="esureyFamilyDS"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyFamilyQueryCmd"
		global="true">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyFamily"></model:record>
	</model:dataset>
	<!--申报家庭成员基本信息-->
	<model:dataset id="esureyPeopleDS"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyPeopleQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyPeople"></model:record>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="sexDS" enumName="COMM.SEX" autoLoad="true"
		global="ture"></model:dataset>
	<!-- 家庭性质 -->
	<model:dataset id="familyTypeDS" enumName="FAMILY_TYPE" autoLoad="true"
		global="true"></model:dataset>
	<!-- 救助类型 -->
	<model:dataset id="assistanceTypeDS" enumName="ASSISTANCE_TYPE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 审核意见 -->
	<model:dataset id="checkOpinionDS" enumName="CHECK_OPINION"
		autoLoad="true"></model:dataset>
	<!-- 当前环节 -->
	<model:dataset id="curDS" enumName="ESUREY.CUR_ACTIVITY"
		autoLoad="true" global="true"></model:dataset>
	<!-- 当前环节 -->
	<model:dataset id="curStatusDS" enumName="CUR_STATUS" autoLoad="true"
		global="true"></model:dataset>
		
</model:datasets>

<next:Panel name="form" width="100%" border="0"
	bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true">
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox"><legend
			class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton"
			src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
			onclick="collapse(this)" /> </legend>
		<div>
		<form style="width: 98%; height: 100%;" class="L5form">
		<table border="1" width="100%">
			<tr>
				<td class="FieldLabel"><label>户主姓名:</label></td>
				<td class="FieldInput"><input type="text"  id="qName"/></td>					
				<td class="FieldLabel"><label>身份证号:</label></td>
				<td class="FieldInput"><input type="text" style="width:140" id="qIdCard"  /></td>		
				<td class="FieldButton" ><button onclick="query();">查 询</button>&nbsp;<button type="reset">重 置</button> </td>	
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="sbjtxxGridPanel" name="sbjtxxGridPanel" width="100%" height="100%" title="核对家庭基本信息列表" notSelectFirstRow="true" stripeRows="true" dataset="esureyFamilyDS">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="detail" text="详细" handler="details" />
		<next:ToolBarItem iconCls="save" text="核对分发" handler="memberIssue" />
	</next:TopBar>

	<next:Columns>
		<next:RowNumberColumn width="10" />
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="familyId" header="家庭ID" field="familyId" hidden="true" width="10">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="familyName" header="户主姓名" field="familyName" width="10%" >
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="familyCardNo" header="身份证件号码" field="familyCardNo" width="20%">
			<next:TextField />
		</next:Column>
		<next:Column id="peopleNum" header="家庭人数" field="peopleNum" width="8%">
			<next:TextField />
		</next:Column>
		<next:Column id="assistanceType" header="救助类型" field="assistanceType" width="10%" dataset="assistanceTypeDS">
			<next:TextField />
		</next:Column>
		<next:Column id="domicileType" header="家庭性质" field="domicileType" width="10%" dataset="familyTypeDS">
			<next:TextField />
		</next:Column>
		<next:Column id="curActivity" header="当前环节" field="curActivity" hidden="true" width="10%"  dataset="curDS">
			<next:TextField />
		</next:Column>
		<next:Column id="curState" header="当前环节状态" field="curState" hidden="true"  dataset="curStatusDS" width="15%">
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="esureyFamilyDS"></next:PagingToolBar>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
