<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.inspur.cams.comm.util.StrUtil,org.loushang.next.skin.SkinUtils,com.inspur.cams.sorg.util.SomIdHelp"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@ taglib uri="/tags/next-web" prefix="next" %>
<%@ taglib uri="/tags/next-model" prefix="model" %>
<%@ page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.sorg.util.ApplyType"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>社会团体数据修订</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="groupModifyBuild.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript">var rootPath='<%=SkinUtils.getRootUrl(request)%>';</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgCheck.js") %>'></script>
<script type="text/javascript">
	var currentUserName = '<%= GetBspInfo.getBspInfo().getUserName()%>';
	<%
		String sorgId=request.getParameter("sorgId");
		if(sorgId==null){
			sorgId="";
		}
	%>
	var sorgId='<%=sorgId%>';
</script>
</head>
<body>

<%--定义dataset--%>
<model:datasets>
	<%--社团基本信息--%>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
			<%--社会团体基本信息验证 --%>
			<model:field name="sorgCode" type="string" rule="require|length{20}" />
			<model:field name="cnName" type="string" rule="require|length{100}" />
			<model:field name="enName" type="string" rule="length{100}" />
			<model:field name="abName" type="string" rule="length{50}" />
			<model:field name="organCode" type="string" rule="length{10}" />
			<model:field name="residence" type="string" rule="length{100}" />
			<model:field name="sorgAdds" type="string" rule="length{200}" />
			<model:field name="sorgEmail" type="string" rule="email|length{100}" />
			<model:field name="actArea" type="string" rule="length{50}" />
			<model:field name="purpose" type="string" rule="length{1000}" />
			<model:field name="business" type="string" rule="length{2000}" />
			<model:field name="borgName" type="string" rule="length{100}" />
			<model:field name="unitsNum" type="string" rule="integer" />
			<model:field name="peopleNum" type="string" rule="integer" />
			<model:field name="councilNum" type="string" rule="integer" />
			<model:field name="standCouncilNum" type="string" rule="integer" />
			<model:field name="fundingPeople" type="string" rule="length{500}" />
			<model:field name="checkCapitalOrgan" type="string" rule="length{100}" />
			<model:field name="moneySource" type="string" rule="length{500}" />
			<model:field name="housingOrgan" type="string" rule="length{100}" />
			<model:field name="leasePeriod" type="string" rule="length{100}" />
			<model:field name="legalPeople" type="string"/>
			<model:field name="regMon" type="string" rule="double|length{14}" />
		</model:record>
	</model:dataset>
		<%--检验登记证号是否重复--%>
	<model:dataset id="checkSorgCodeDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" global="true" method="queryOrgan">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
	</model:dataset>
	<%--定义字典表--%>
	<model:dataset id="cataLogCodeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_CATALOG'></model:param>
			<model:param name="value" value='CATALOG_CODE'></model:param>
			<model:param name="text" value='CATALOG_NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 社会组织种类 -->
	<model:dataset id="sorgKindSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_GROUP_KIND'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 政治面貌 -->
	<model:dataset id="politicsSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_POLITICAL'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 住所来源 -->
	<model:dataset id="resideSourceSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_RESIDE_SOURCE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 住所来源 -->
	<model:dataset id="sorgNameSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_ORGAN'></model:param>
			<model:param name="value" value='SORG_ID'></model:param>
			<model:param name="text" value='CN_NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 所属行事业 -->
	<model:dataset id="busScopeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BUS_SCOPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 社会组织职务 -->
	<model:dataset id="sorgDutiesSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_DUTY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 专兼职 -->
	<model:dataset id="ifFulltimeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_IF_FULLTIME'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 民族 -->
	<model:dataset id="folkSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 民族 -->
	<model:dataset id="ifServeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_DUTY_IF_SERVE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 业务主管单位 -->
	<model:dataset id="businessOrganSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true" sortField="ORDER_NUMBER">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
			<model:param name="filterSql" value='<%="MORG_CODE ="+BspUtil.getOrganCode().substring(0,6)%>'></model:param>

		</model:params>
	</model:dataset>
	<!-- 证件类型 -->
	<model:dataset id="cardTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CARD_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 会议类型 -->
	<model:dataset id="meetingType" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_MEETING_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="sexSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SEX'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="opinionSelect" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="leaderLevelDataSet" enumName="SOM.LEADER_LEVEL" autoLoad="true" global="true"></model:dataset>
</model:datasets>	
<%--定义界面--%>
<next:Panel width="100%" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="社会团体成立登记"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="saveAll"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="返回" handler="goBack"></next:ToolBarItem>
	</next:TopBar>
	<next:TabPanel width="100%" height="100%" id="tab">
		<next:Tabs>
			<next:Panel title="登记申请表" width="100%" >
				<next:Panel width="100%" height="100%" autoScroll="true">
					<next:Html>					
					<fieldset>
						<legend>社会团体法人成立登记申请表</legend>		
						<form method="post" dataset="somOrganDataSet" onsubmit="return false" class="L5form">
						<table width="100%">
							<tr>
								<td class="FieldLabel">社会团体中文名称：</td>
								<td class="FieldInput" colspan="5"><input type="text" id="cnName" name='社会团体中文名称' field="cnName" onblur="fillOrganInfo();" style="width:97%"/><span style="color:red">*</span></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width:17%">社会团体英文名称：</td>
								<td class="FieldInput"  style="width:17%"><input type="text" name='社会团体英文名称' field="enName" style="width:90%"/></td>
								<td class="FieldLabel" style="width:17%">社会团体英文名称缩写：</td>
								<td class="FieldInput" style="width:17%"><input type="text" field="abName" name='社会团体英文名称缩写' style="width:90%"/></td>
								<td class="FieldLabel">成立日期：</td>
								<td class="FieldInput"><input type="text" name='成立日期' field="buildDate" onClick="WdatePicker()" style="width:90%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width:17%">登记证号：</td>
								<td class="FieldInput" style="width:17%"><input type="text" id="sorgCode" name='登记证号' field="sorgCode" onkeyup="value=value.replace(/[^\\w\.\/]/ig,'').toUpperCase()" onblur="sorgCodeUK();" style="width:90%"/><span style="color:red">*</span></td>
								<td class="FieldLabel" style="width:17%">组织机构代码：</td>
								<td class="FieldInput" style="width:17%"><input type="text" name='组织机构代码' field="organCode"  style="width:90%"/></td>
								<td class="FieldLabel" style="width:17%">登记日期：</td>
								<td class="FieldInput" style="width:17%"><input type="text" id="regDate" name='登记日期' field="regDate" onClick="WdatePicker()" style="width:90%"/><span style="color:red">*</span></td>
							</tr>
							<tr>
								<td class="FieldLabel">社会团体类型：</td>
								<td class="FieldInput"><select id="sorgKind" field="sorgKind" name='社会团体类型' style="width:90%"><option dataset="sorgKindSelect"></option></select></td>
								<td class="FieldLabel">所属行（事）业：</td>
								<td class="FieldInput"><select field="busScope" name='所属行（事）业' style="width:90%"><option  dataset="busScopeSelect"></option></select></td>
								<td class="FieldLabel" style="width:17%">法定代表人：</td>
								<td class="FieldInput" style="width:17%"><input type="text" name='法定代表人' field="legalPeople"  style="width:90%"/></td>
							</tr>
							<tr>	
								<td class="FieldLabel" style="width:17%">住所来源：</td>
								<td class="FieldInput" style="width:17%"><select field="resideSource" onblur="changeResideSource();" id="resideSource" name='住所来源' style="width:90%""><option dataset="resideSourceSelect"></option></select></td>
								<td class="FieldLabel">住所：</td>
								<td class="FieldInput" colspan="3"><input type="text" name='住所' field="residence" style="width:97%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width:17%">社会团体邮编：</td>
								<td class="FieldInput" style="width:17%"><input type="text" id="sorgPost" name='社会团体邮编' field="sorgPost" style="width:90%"/></td>								
								<td class="FieldLabel">社会团体电话：</td>
								<td class="FieldInput"><input type="text" id="sorgPhone" name='社会团体电话' field="sorgPhone" style="width:90%"/></td>	
								<td class="FieldLabel">活动地域：</td>
								<td class="FieldInput"><input type="text" name='活动地域' field="actArea" style="width:90%" /></td>							
							</tr>
							<tr>
								<td class="FieldLabel">业务主管单位：</td>
								<td class="FieldInput">
								<input type="text" id="borgNameDispaly" name="borgNameDispaly"  title="业务主管单位"  onkeyup="findDiv(this,'borgName','popup','','businessOrganAuto','BORG_NAME@like','borgCode','borgName','35')" onblur="clearDiv()" onchange="clearBorg(this)"/><img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor:hand" onclick="showBorgWin()"/>
								<div id="popup" style="width:300px; height: 150px; display: none;position: absolute;background-color: #FFFFFF;" >  
	        							<ul></ul> 
	   								</div>
	   								<input type="hidden" id="borgName" name="borgName" field="borgName" title="业务主管单位代码"/>
								<span style="color:red">*</span></td>
								
								<td class="FieldLabel">业务主管单位联系人：</td>
								<td class="FieldInput"><input type="text" name='业务主管单位联系人' field="borgPeople" style="width:90%" /></td>
								<td class="FieldLabel">业务主管单位电话：</td>
								<td class="FieldInput"><input type="text" name='业务主管单位电话' field="borgPhone" style="width:90%" /></td>
							</tr>
							<tr>	
								<td class="FieldLabel">社会团体宗旨：</td>
								<td class="FieldInput" colspan="5"><textarea rows="5" name='社会团体宗旨' field="purpose" style="width:98%"></textarea></td>
							</tr>
							<tr>	
								<td class="FieldLabel">业务范围：</td>
								<td class="FieldInput" colspan="5"><textarea rows="5" name='业务范围' field="business" style="width:98%"></textarea></td>
							</tr>
							<tr>	
								<td class="FieldLabel">单位会员数：</td>
								<td class="FieldInput"><input type="text" id="unitsNum" name='单位会员数' field="unitsNum" maxlength="6" style="width:90%"/></td>
								<td class="FieldLabel">个人会员数：</td>
								<td class="FieldInput"><input type="text" id="peopleNum" name='个人会员数' field="peopleNum" maxlength="6" style="width:90%"/></td>
								<td class="FieldLabel">理事数：</td>
								<td class="FieldInput"><input type="text" name='理事数' field="councilNum" maxlength="6" style="width:90%"></td>
							</tr>
							<tr>
								<td class="FieldLabel">常务理事数：</td>
								<td class="FieldInput"><input type="text" name='常务理事数' field="standCouncilNum" maxlength="6" style="width:90%"/></td>
								<td class="FieldLabel">活动资金数额：</td>
								<td class="FieldInput" colspan="3"><input type="text" id="regMon" name='活动资金数额' field="regMon" maxlength="10" style="width:30%"/>万元</td>
							</tr>
							<tr>
								<td class="FieldLabel">出资人：</td>
								<td class="FieldInput" colspan="5"><textarea name='出资人' field="fundingPeople" style="width:98%" ></textarea></td>
							</tr>
							<tr>
								<td class="FieldLabel">验资单位：</td>
								<td class="FieldInput" colspan="5"><input type="text" name='验资单位' field="checkCapitalOrgan" style="width:98%"></td>
							</tr>
							<tr>
								<td class="FieldLabel">经费来源：</td>
								<td class="FieldInput" colspan="5"><input type="text" name='经费来源' field="moneySource" style="width:98%"/></td>
							</tr>
							<tr>	
								<td class="FieldLabel">住所产权单位：</td>
								<td class="FieldInput" colspan="3"><input type="text" name='住所产权单位' field="housingOrgan" style="width:97%"/></td>
								<td class="FieldLabel">用房面积：</td>
								<td class="FieldInput"><input type="text" id="housingArea" name='用房面积' field="housingArea" maxlength="10" style="width:65%"/>平方米</td>
							</tr>
							<tr id="leasePeriod" style="display:none">
								<td class="FieldLabel">租（借）期限：</td>
								<td class="FieldInput" colspan="5"><input type="text" field="leasePeriod" style="width:98%"/></td>
							</tr>
							<tr>	
								<td class="FieldLabel">社会团体通信地址：</td>
								<td class="FieldInput"><input type="text"name='社会团体通信地址' id="sorgAdds" field="sorgAdds" style="width:97%"/></td>
								<td class="FieldLabel">社会团体电子邮箱：</td>
								<td class="FieldInput"><input type="text" name='社会团体电子邮箱' field="sorgEmail" style="width:90%"/></td>
								<td class="FieldLabel" style="width:15%">社会团体传真：</td>
								<td class="FieldInput" style="width:17%"><input type="text" id="sorgFax" field="sorgFax" style="width:90%"/></td>
							</tr>
						</table>
						</form>
					</fieldset>
					<fieldset>
					<form method="post"  onsubmit="return false" class="L5form" style="border-width:0px" dataset=somOrganDataSet>
					<legend>联系人信息</legend>
					<table width="100%">
						<tr>
							<td class="FieldLabel" style="width:17%">联系人：</td>
							<td class="FieldInput" style="width:17%"><input type="text" name='"申请人"' field="sorgPeople" style="width:90%"/></td>
							<td class="FieldLabel" style="width:17%">联系人电话：</td>
							<td class="FieldInput" style="width:17%"><input type="text" id="sorgPeoplePhone" name='"申请人电话"' field="sorgPeoplePhone" style="width:90%"/></td>
						</tr>
					</table>
					</form>
					</fieldset>
					</next:Html>
				</next:Panel>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
<jsp:include page="../../comm/borg/borgSelectWindow.jsp" flush="true"/> 
</body>
</html>