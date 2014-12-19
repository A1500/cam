<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.inspur.cams.comm.util.StrUtil,org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next" %>
<%@ taglib uri="/tags/next-model" prefix="model" %>
<html>
<head>
<title>民办非企业单位信息明细</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="somUngov.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript">
	var sorgId = '<%=StrUtil.n2b(request.getParameter("sorgId"))%>';
	var sorgStatus = '<%=StrUtil.n2b(request.getParameter("sorgStatus"))%>';
</script>
</head>
<body>
<%--定义dataset--%>
<model:datasets>
	<%--基本信息--%>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.manage.cmd.SomUngovOrganQueryCmd" method="queryMain">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
	</model:dataset>
	<%--主要人员--%>
	<model:dataset id="somPresidePeopleDataSet" cmd="com.inspur.cams.sorg.manage.cmd.SomUngovPeopleQueryCmd" method="queryPeopleList">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeople"></model:record>
	</model:dataset>
	<%--法定代表人--%>
	<model:dataset id="somDeputyPeopleDataSet" cmd="com.inspur.cams.sorg.manage.cmd.SomUngovPeopleQueryCmd" method="queryPeopleByParam">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeople"></model:record>
	</model:dataset>
	<%--查看主要人员窗口--%>
	<model:dataset id="winPresidePeopleDataSet" cmd="com.inspur.cams.sorg.manage.cmd.SomUngovPeopleQueryCmd" method="queryPeopleByParam">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeople"></model:record>
	</model:dataset>
	
	<model:dataset id="peopleTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_PEOPLE_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="sorgKindSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_UNGOV_KIND'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="politicsSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_POLITICAL'></model:param>
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
	<model:dataset id="resideSourceSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_RESIDE_SOURCE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="busScopeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BUS_SCOPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="sorgDutiesSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_DUTY'></model:param>
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
	<model:dataset id="businessOrganSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>	
	<model:dataset id="sexSelect" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
</model:datasets>	

<%--定义界面--%>
<next:Panel width="100%" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="民办非企业单位信息明细"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="返回" handler="back"></next:ToolBarItem>
	</next:TopBar>
	
	<next:TabPanel id="tab" width="100%" height="100%"  activeTab="2">
		<next:Tabs>
			<next:Panel title="民办非企业单位法人登记表" width="100%" autoScroll="true">
				<next:Html>
					<form method="post" dataset="somOrganDataSet" onsubmit="return false" class="L5form">
						<table width="100%">
							<tr>
								<td class="FieldLabel"><label>登记证号：</label></td>
								<td class="FieldInput" colspan="5"><label field="sorgCode" style="width:98%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>单位名称：</label></td>
								<td class="FieldInput" colspan="5"><label field="cnName" style="width:98%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>组织机构代码：</label></td>
								<td class="FieldInput" colspan="3"><label field="organCode" style="width:97%"/></td>
								<td class="FieldLabel"><label>单位类型：</label></td>
								<td class="FieldInput"><label field="sorgKind" dataset="sorgKindSelect" style="width:90%"/></td>
							</tr>
							<tr>	
								<td class="FieldLabel"><label>住所：</label></td>
								<td class="FieldInput" colspan="5"><label field="residence" style="width:98%"/></td>
							</tr>
							<tr>	
								<td class="FieldLabel" style="width:17%"><label>住所来源：</label></td>
								<td class="FieldInput" style="width:17%"><label field="resideSource" dataset="resideSourceSelect" style="width:90%"/></td>
								<td class="FieldLabel" style="width:17%"><label>单位邮编：</label></td>
								<td class="FieldInput" style="width:17%"><label field="sorgPost" style="width:90%"/></td>
								<td class="FieldLabel" style="width:15%"><label>单位传真：</label></td>
								<td class="FieldInput" style="width:17%"><label field="sorgFax" style="width:90%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>租（借）期限：</label></td>
								<td class="FieldInput" colspan="5"><label field="leasePeriod" style="width:98%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>单位电话：</label></td>
								<td class="FieldInput" colspan="5"><label field="sorgPhone" style="width:90%"/></td>
							</tr>
							<tr>	
								<td class="FieldLabel"><label>从业人员数：</label></td>
								<td class="FieldInput"><label field="engagedNum" style="width:90%"/></td>
								<td class="FieldLabel"><label>其中执业人员数：</label></td>
								<td class="FieldInput" colspan="3"><label field="practiceNum" style="width:30.5%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>业务主管单位：</label></td>
								<td class="FieldInput" colspan="3"><label field="borgName" style="width:97%" dataset="businessOrganSelect"/></td>
								<td class="FieldLabel"><label>主管单位审查日期：</label></td>
								<td class="FieldInput"><label field="borgCheckDate" format="Y-m-d" style="width:90%"/></td>
							</tr>
							<tr>	
								<td class="FieldLabel"><label>宗旨：</label></td>
								<td class="FieldInput" colspan="5"><textarea rows="10" field="purpose" readonly="readonly" style="width:98%"></textarea></td>
							</tr>
							<tr>	
								<td class="FieldLabel"><label>业务范围：</label></td>
								<td class="FieldInput" colspan="5"><textarea rows="10" field="business" style="width:98%" readonly="readonly"></textarea></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>基本设备、设施：</label></td>
								<td class="FieldInput" colspan="5"><label field="facilities" style="width:98%" /></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>出资人：</label></td>
								<td class="FieldInput" colspan="3"><textarea field="fundingPeople" style="width:96.5%"></textarea></td>
								<td class="FieldLabel"><label>开办资金数额（万元）：</label></td>
								<td class="FieldInput"><label field="regMon" style="width:65%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>验资单位：</label></td>
								<td class="FieldInput" colspan="5"><label field="checkCapitalOrgan" style="width:98%"></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>开办资金来源：</label></td>
								<td class="FieldInput" colspan="5"><textarea rows="5" name='"开办资金来源"' field="moneySource" style="width:98%" readonly="readonly"></textarea></td>
							</tr>
							<tr>	
								<td class="FieldLabel"><label>住所产权单位：</label></td>
								<td class="FieldInput" colspan="3"><label field="housingOrgan" style="width:97%"/></td>
								<td class="FieldLabel"><label>用房面积（平方米）：</label></td>
								<td class="FieldInput"><label field="housingArea" style="width:90%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>登记人：</label></td>
								<td class="FieldInput"><label field="regPeople" style="width:90%"/></td>
								<td class="FieldLabel"><label>登记日期：</label></td>
								<td class="FieldInput"><label field="regDate" format="Y-m-d" style="width:90%"/></td>
								<td class="FieldLabel"><label>成立日期：</label></td>
								<td class="FieldInput"><label field="buildDate" format="Y-m-d" style="width:90%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>所属行（事）业：</label></td>
								<td class="FieldInput" colspan="5"><label field="busScope" dataset="busScopeSelect" style="width:17.5%"/></td>
							</tr>
							<tr>	
								<td class="FieldLabel"><label>单位通信地址：</label></td>
								<td class="FieldInput" colspan="5"><label field="sorgAdds" style="width:98%"/></td>
							</tr>
							<tr>	
								<td class="FieldLabel"><label>单位网址：</label></td>
								<td class="FieldInput" colspan="3"><label field="sorgWeb" style="width:97%"/></td>
								<td class="FieldLabel"><label>单位电子邮箱：</label></td>
								<td class="FieldInput"><label field="sorgEmail" style="width:90%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>备注：</label></td>
								<td class="FieldInput" colspan="5"><textarea rows="2" field="note" style="width:98%" readonly="readonly"></textarea></td>
							</tr>
						</table>
					</form>
				</next:Html>
			</next:Panel>
			<next:Panel title="主要人员">
				<next:EditGridPanel id="grid" name="grid" width="100%" stripeRows="true" height="100%" dataset="somPresidePeopleDataSet">
					<next:TopBar>
						<next:ToolBarItem symbol="领导/合伙人列表"></next:ToolBarItem>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="detail" text="查看" handler="examine"></next:ToolBarItem>
					</next:TopBar>

					<next:Columns>
						<next:RowNumberColumn />
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="身份证号" field="idCard" width="20%" sortable="false" editable="false"><next:TextField /></next:Column>
						<next:Column header="姓名"    field="name" width="15%" sortable="false" editable="false"><next:TextField /></next:Column>
						<next:Column header="出生年月" field="birthday" width="10%" sortable="false" editable="false"><next:TextField /></next:Column>
						<next:Column header="性别" 	  field="sex"      width="5%" sortable="false" editable="false" dataset="sexSelect"><next:TextField /></next:Column>
						<next:Column header="人员类型" field="peopleType" width="15%" sortable="false" editable="false" dataset="peopleTypeSelect"><next:TextField /></next:Column>
						<next:Column header="政治面貌" field="politics" width="17%" sortable="false" editable="false" dataset="politicsSelect"><next:TextField /></next:Column>
						<next:Column header="电话"    field="phone" width="18%" sortable="false" editable="false"><next:TextField /></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somPresidePeopleDataSet" />
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>
			<next:Panel title="法定代表人登记表"  width="100%" autoScroll="true">
				<next:Html>
					<form  method="post" dataset="somDeputyPeopleDataSet" onsubmit="return false" class="L5form">
					<table width="100%">
						<tr>
							<td class="FieldLabel" style="width:14%"><label>身份证号：</label></td>
							<td class="FieldInput" style="width:20%"><label field="idCard" style="width:90%"/></td>
							<td class="FieldLabel" style="width:13%"><label>姓名：</label></td>
							<td class="FieldInput" style="width:20%"><label field="name" style="width:90%"/></td>
							<td class="FieldLabel" style="width:13%"><label>文化程度：</label></td>
							<td class="FieldInput" style="width:20%"><label field="education" dataset="educationSelect" style="width:90%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>性别：</label></td>
							<td class="FieldInput"><label field="sex" dataset="sexSelect" style="width:90%"/></td>
							<td class="FieldLabel"><label>民族：</label></td>
							<td class="FieldInput"><label field="folk" style="width:90%" dataset="folkSelect"/></td>
							<td class="FieldLabel"><label>出生年月：</label></td>
							<td class="FieldInput"><label field="birthday" format="Y-m-d" style="width:90%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>政治面貌：</label></td>
							<td class="FieldInput"><label field="politics" dataset="politicsSelect" style="width:90%"/></td>
							<td class="FieldLabel"><label>家庭地址邮编：</label></td>
							<td class="FieldInput"><label field="postCode" style="width:90%"/></td>
							<td class="FieldLabel"><label>年龄：</label></td>
							<td class="FieldInput"><label id="age" style="width:90%"/></td>
						</tr>
						<tr>	
							<td class="FieldLabel"><label>本人电话：</label></td>
							<td class="FieldInput" colspan="5"><label field="phone" style="width:90%"/></td>
						</tr>
						<tr>	
							<td class="FieldLabel"><label>家庭住址：</label></td>
							<td class="FieldInput" colspan="5"><label field="adds" style="width:97.7%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>户口所在地：</label></td>
							<td class="FieldInput" colspan="5"><label field="populace" style="width:97.7%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>人事关系所在单位：</label></td>
							<td class="FieldInput" colspan="5"><label field="workName" style="width:97.7%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>工作职务：</label></td>
							<td class="FieldInput" colspan="3"><label field="workDuties" style="width:96.5%"/></td>
							<td class="FieldLabel"><label>所在单位电话：</label></td>
							<td class="FieldInput"><label field="workPhone" style="width:90%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>技术职称：</label></td>
							<td class="FieldInput"><label field="profession" style="width:90%"/></td>
							<td class="FieldLabel"><label>单位职务：</label></td>
							<td class="FieldInput"><label field="sorgDuties" dataset="sorgDutiesSelect" style="width:90%"/></td>
							<td class="FieldLabel"><label>是否连任法定代表人：</label></td>
							<td class="FieldInput"><label field="ifRedo" dataset="comm_yesorno" style="width:90%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>是否党政机关领导干部：</label></td>
							<td class="FieldInput"><label field="ifPartyLeader" dataset="comm_yesorno" style="width:90%"/></td>
							<td class="FieldLabel"><label>批准文号：</label></td>
							<td class="FieldInput"><label field="promiseCode" style="width:90%"/></td>
							<td class="FieldLabel"><label>批准机关：</label></td>
							<td class="FieldInput"><label field="promiseOrgan" style="width:90%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>本人简历：</label></td>
							<td class="FieldInput" colspan="5"><textarea  rows="10" field="resume" style="width:97.7%" readonly="readonly"></textarea></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>人事关系所在单位审查意见：</label></td>
							<td class="FieldInput" colspan="5"><textarea  rows="2" field="workOpinion" style="width:97.7%" readonly="readonly"></textarea></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>审查日期：</label></td>
							<td class="FieldInput" colspan="5"><label  field="workCheckDate" format="Y-m-d" style="width:22%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>民办非企业单位意见：</label></td>
							<td class="FieldInput" colspan="5"><textarea   rows="2" field="sorgOpinion" style="width:97.7%" readonly="readonly"></textarea></td>
						</tr>
						<tr>	
							<td class="FieldLabel"><label>签署日期：</label></td>
							<td class="FieldInput" colspan="5"><label  field="sorgCheckDate" format="Y-m-d" style="width:22%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>登记备注：</label></td>
							<td class="FieldInput" colspan="5"><textarea rows="2" field="memberNote" style="width:97.7%" readonly="readonly"></textarea></td>
						</tr>
					</table>
					</form>
				</next:Html>
			</next:Panel>
			<next:Panel width="100%" title="成立电子档案查看">
				<next:Html>
				  <iframe id="uploadInfo" src="../upload/somDownloadComm.jsp?sorgId=<%=request.getParameter("sorgId") %>&applyType=101"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
<next:Window id="win" title="查看主要负责人"  resizable="false" width="740" height="376" closeAction="hide" autoScroll="true">
	<next:Panel id="panel_win">
		<next:Html>
			<form id="form_win" method="post" dataset="winPresidePeopleDataSet" onsubmit="return false" class="L5form">
				<table width="100%">
					<tr>
							<td class="FieldLabel" style="width:15%"><label>身份证号：</label></td>
							<td class="FieldInput" style="width:21%"><label field="idCard" onblur="validateIdcard()" style="width:90%"/></td>
							<td class="FieldLabel" style="width:11%"><label>姓名：</label></td>
							<td class="FieldInput" style="width:21%"><label field="name" style="width:90%"/></td>
							<td class="FieldLabel" style="width:11%"><label>人员类型：</label></td>
							<td class="FieldInput" style="width:21%"><label field="peopleType" dataset="peopleTypeSelect" style="width:90%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>文化程度：</label></td>
							<td class="FieldInput"><label field="education" dataset="educationSelect" style="width:90%"/></td>
							<td class="FieldLabel"><label>性别：</label></td>
							<td class="FieldInput"><label field="sex" dataset="sexSelect" style="width:90%"/></td>
							<td class="FieldLabel"><label>民族：</label></td>
							<td class="FieldInput"><label field="folk" style="width:90%" dataset="folkSelect"/></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>出生年月：</label></td>
							<td class="FieldInput"><label field="birthday" style="width:90%"/></td>
							<td class="FieldLabel"><label>政治面貌：</label></td>
							<td class="FieldInput"><label field="politics" dataset="politicsSelect" style="width:90%"/></td>
							<td class="FieldLabel"><label>本人电话：</label></td>
							<td class="FieldInput"><label  field="phone" style="width:90%"/></td>
						</tr>
						<tr>	
							<td class="FieldLabel"><label>家庭住址：</label></td>
							<td class="FieldInput" colspan="3"><label field="adds" style="width:96.5%"/></td>
							<td class="FieldLabel"><label>家庭地址邮编：</label></td>
							<td class="FieldInput"><label field="postCode" style="width:90%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>户口所在地：</label></td>
							<td class="FieldInput" colspan="5"><label field="populace" style="width:97.7%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>人事关系所在单位：</label></td>
							<td class="FieldInput" colspan="5"><label field="workName" style="width:97.7%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>工作职务：</label></td>
							<td class="FieldInput" colspan="3"><label field="workDuties" style="width:96.5%"/></td>
							<td class="FieldLabel"><label>所在单位电话：</label></td>
							<td class="FieldInput"><label field="workPhone" style="width:90%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>技术职称：</label></td>
							<td class="FieldInput"><label field="profession" style="width:90%"/></td>
							<td class="FieldLabel"><label>单位职务：</label></td>
							<td class="FieldInput"><label field="sorgDuties" dataset="sorgDutiesSelect" style="width:90%"/></td>
							<td class="FieldLabel"><label>是否连任：</label></td>
							<td class="FieldInput"><label field="ifRedo" dataset="comm_yesorno" style="width:90%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>是否党政机关领导干部：</label></td>
							<td class="FieldInput"><label field="ifPartyLeader" dataset="comm_yesorno" style="width:90%"/></td>
							<td class="FieldLabel"><label>批准文号：</label></td>
							<td class="FieldInput"><label field="promiseCode" style="width:90%"/></td>
							<td class="FieldLabel"><label>批准机关：</label></td>
							<td class="FieldInput"><label field="promiseOrgan" style="width:90%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>本人简历：</label></td>
							<td class="FieldInput" colspan="5"><textarea  rows="10" field="resume" style="width:97.7%" readonly="readonly"></textarea></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>人事关系所在单位审查意见：</label></td>
							<td class="FieldInput" colspan="5"><textarea  rows="2" field="workOpinion" style="width:97.7%" readonly="readonly"></textarea></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>审查日期：</label></td>
							<td class="FieldInput" colspan="5"><label field="workCheckDate" style="width:22%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>民办非企业单位意见：</label></td>
							<td class="FieldInput" colspan="5"><textarea  rows="2" field="sorgOpinion" style="width:97.7%" readonly="readonly"></textarea></td>
						</tr>
						<tr>	
							<td class="FieldLabel"><label>签署日期：</label></td>
							<td class="FieldInput" colspan="5"><label  field="sorgCheckDate" style="width:22%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>备注：</label></td>
							<td class="FieldInput" colspan="5"><textarea rows="2" field="memberNote" style="width:97.7%" readonly="readonly"></textarea></td>
						</tr>
				</table>
			</form>
		</next:Html>
	</next:Panel>
	<next:Buttons>
		<next:ToolButton text="关闭窗口" handler="closeWin"></next:ToolButton>
	</next:Buttons>
</next:Window>
</body>
</html>