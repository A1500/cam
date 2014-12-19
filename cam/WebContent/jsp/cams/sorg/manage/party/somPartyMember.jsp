<%@ page language="java" contentType="text/html; charset=utf-8"pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
<!-- 党员基本信息登记表 -->
<head>
<next:ScriptManager/>
<script type="text/javascript" src="somPartyMember.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript">
	var memberId='<%=request.getParameter("memberId")%>';	
	var sorgId='<%=request.getParameter("sorgId")%>';
	var peopleType='<%=request.getParameter("peopleType")%>';	
	var searchSorgName=decodeURIComponent('<%=request.getParameter("searchSorgName")%>');
	var searchSorgCode=decodeURIComponent('<%=request.getParameter("searchSorgCode")%>');
	var searchSorgType='<%=request.getParameter("searchSorgType")%>';		
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="somPartyMemberDS"  cmd="com.inspur.cams.sorg.manage.cmd.SomPartyMemberQueryCmd" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPartyMember"></model:record>
	</model:dataset>
	<model:dataset id="somPartyPraiseInsertDataSet" cmd="com.inspur.cams.sorg.manage.cmd.SomPartyPraiseQueryCmd" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPartyPraise"></model:record>
	</model:dataset>
	<model:dataset id="organDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" method="queryOrgan"  >
      <model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
	</model:dataset>	
	<model:dataset id="belongOrgTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_PARTY_BELONG_ORG_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
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
	<model:dataset id="ifFullTimeDS" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_IF_FULLTIME'></model:param>
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
	<model:dataset id="peopleStatusDS" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_PARTY_PEOPLE_STATUS'></model:param>
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
	<model:dataset id="relationDS" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_PARTY_RELATION'></model:param>
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
	<model:dataset id="sorgDutiesSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_DUTY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="SEX" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="normalInfoSelect" enumName="SORG.PARTY.NORMAL_INFO" autoLoad="true" global="true"></model:dataset>	
	<model:dataset id="inTypeSelect" enumName="SOM.PARTY.IN_TYPE" autoLoad="true" global="true"></model:dataset> 
	<model:dataset id="outTypeSelect" enumName="SOM.PARTY.OUT_TYPE" autoLoad="true" global="true"></model:dataset> 
	<model:dataset id="praiseOrPunnishSelect" enumName="SOM.PARTY.PRAISE_OR_PUNNISH" autoLoad="true" global="true"></model:dataset> 
 	<model:dataset id="praiseTypeSelect" enumName="SOM.PARTY.PRAISE_TYPE" autoLoad="true" global="true"></model:dataset> 
 	<model:dataset id="grantedTitleSelect" enumName="SOM.PARTY.GRANTED_TITLE" autoLoad="true" global="true"></model:dataset> 
</model:datasets>
<next:Panel width="100%" height="100%" >
	<next:TopBar>
			<next:ToolBarItem symbol="党员情况登记表"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem  iconCls="return" text="返回" handler="returnList"></next:ToolBarItem>
	</next:TopBar>

	<next:TabPanel id="tabPartyMember">
		<next:Tabs>
	<next:Panel id="panelPartyMember"height='100%' autoScroll="true" title='基本信息'>	
	<next:Html>
		<form  method="post"  onsubmit="return false" class="L5form" dataset="somPartyMemberDS">
		<fieldset>
		<legend>基本信息</legend>		
		<table width="100%">
			<input type="hidden" id="sorgId" field="sorgId"/>
			<tr>
				<td class="FieldLabel" ><label>社会组织名称:</label></td>
				<td class="FieldInput" colspan="3"><label id="sorgName"></label></td>
				<td class="FieldLabel" ><label>社会组织类型:</label></td>
				<td class="FieldInput" >
					<select id="sorgType"disabled style="width:90%"><option dataset="sorgTypeDS"></option></select>
				</td>
			</tr>
						<tr>
							<td class="FieldLabel" width='14%'><label>身份证号：</label></td>
							<td class="FieldInput" width='21%'><label type="text" name="身份证号" id="idCard_partyMember" field="idCard" onblur='' style="width:90%"/></td>
							<td class="FieldLabel" width='14%'><label>姓名：</label></td>
							<td class="FieldInput" width='18%'><label type="text" name="姓名" id="name_partyMember" field="name" style="width:90%" /></td>
							<td class="FieldLabel" width='14%'><label>人员类别:</label></td>
							<td class="FieldInput" width='19%'><select name="人员类别" id="peopleType_partyMember" field="peopleType" style="width: 90%" onblur='' disabled><option dataset="peopleTypeSelect"></option></select></td>								
						</tr>
						<tr>
							<td class="FieldLabel"><label>性别:</label></td>
							<td class="FieldInput"><label name='性别' id="sex" field="sex" style="width: 90%" dataset="SEX"></label></td>				
							<td class="FieldLabel"><label>出生日期:</label></td>
							<td class="FieldInput"><label name='出生日期' field="birthday" type="text" id="birthday" format="Y-m-d"  readonly="readonly"  style="width: 90%"/></td>
							<td class="FieldLabel"><label>民族:</label></td>
							<td class="FieldInput"><label name='民族' id="folk" field="folk"  style="width: 90%" dataset="folkSelect"></label></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>最高学历:</label></td>
							<td class="FieldInput"><label name="最高学历" id="education" field="education" style="width: 90%" dataset="educationSelect" ></label></td>
							<td class="FieldLabel"><label>电话:</label></td>
							<td class="FieldInput"><label type="text" name="电话" id="phone" field="phone"  style="width: 90%"/></td>	
							<td class="FieldLabel"><label>社会组织职务:</label></td>
							<td class="FieldInput"><label name="社会组织职务" id="sorgDuties" field="sorgDuties" style="width: 90%" dataset="sorgDutiesSelect"  ></label></td>
						</tr>
						<tr>			
							<td class="FieldLabel"><label>主要任职单位:</label></td>
							<td class="FieldInput" colspan='3'><label type="text" name="主要任职单位" id="workName" field="workName" style="width: 90%" /></td>				
							<td class="FieldLabel"><label>主要任职单位职务:</label></td>
							<td class="FieldInput"><label type="text" name="主要任职单位工作职务" id="workDuties" field="workDuties" style="width: 90%" /></td>				
						</tr>
						<tr>
							<td class="FieldLabel" width="14%"><label>专业技术职称:</label></td>
							<td class="FieldInput" width="21%"><label name="专业技术职称" id="profession" field="profession" type="text" style="width: 90%" /></td>				
							<td class="FieldLabel" width="14%"><label>专职/兼职:</label></td>
							<td class="FieldInput" width="18%"><label name='专职/兼职' id="ifFulltime" field="ifFulltime" style="width: 90%" dataset="ifFullTimeDS"></label></td>				
							<td class="FieldLabel" width="14%"><label>生活困难标识:</label></td>
							<td class="FieldInput" width="19%"><label name="生活困难标识" id="ifPoor" field="ifPoor"  style="width: 90%" dataset='comm_yesorno'></label></td>			
						</tr>
		</table>
		</fieldset>
		<div id="fullSystemInDiv" style="display:none;">
				<fieldset>
				<legend>转入情况</legend>
				<table width="100%">
					<tr>
						<td class="FieldLabel"  width="14%"><label>转入类型:</label></td>
						<td class="FieldInput"  width="21%"><label id="inType"  field="inType" dataset="inTypeSelect"></label></td>	
						<td class="FieldLabel"  width="14%"><label>转入时间:</label></td>
						<td class="FieldInput"  width="19%"><label id="inTime" format="Y-m-d"  field="inTime" ></label></td>		
						<td class="FieldLabel"  width="14%"><label>从何单位转入:</label></td>
						<td class="FieldInput"  width="19%"><label  id="inFromOrgan" field="inFromOrgan"  style="width:100%"/></td>
					</tr>
				</table>
				</fieldset>
		 </div>	
		 <div id="fullSystemOutDiv" style="display:none;">
				<fieldset>
				<legend>转出情况</legend>
				<table width="100%">
					<tr>
						<td class="FieldLabel"  width="14%"><label>转出类型:</label></td>
						<td class="FieldInput"  width="21%"><label id="outType"  field="outType" dataset="outTypeSelect"></label></td>	
						<td class="FieldLabel"  width="14%"><label>转出时间:</label></td>
						<td class="FieldInput"  width="19%"><label id="outTime" format="Y-m-d"  field="outTime" ></label></td>		
						<td class="FieldLabel"  width="14%"><label>转出到何单位:</label></td>
						<td class="FieldInput"  width="19%"><label  id="outToOrgan" field="outToOrgan"  style="width:100%"/></td>
					</tr>
				</table>
				</fieldset>
		 </div>	
		<div id="dangyuanDiv" style="display:block">
		<fieldset>
			<legend>相关信息</legend>
			<table width="100%">
				<tr>
					<td class="FieldLabel" width="14%"><label>社会组织党内职务:</label></td>
					<td class="FieldInput" width="21%"><label type="text" name="社会组织党内职务" id="partyDuties" field="partyDuties" style="width: 90%"/></td>			
					<td class="FieldLabel" width="14%"><label>党建指导员标识:</label></td>
					<td class="FieldInput" width="18%"><label name="党建指导员标识" id="ifInstrctor" field="ifInstrctor" style="width: 90%" dataset='comm_yesorno'></label></td>			
					<td class="FieldLabel" width="14%"><label>跨支部党员标识:</label></td>
					<td class="FieldInput" width="19%"><label name="跨支部党员标识" id="ifOtherBranch" field="ifOtherBranch" style="width: 90%" dataset='comm_yesorno'></label></td>			
				</tr>
				<tr>		
					<td class="FieldLabel"><label>隶属组织分类:</label></td>
					<td class="FieldInput"><label name='隶属组织分类' id="belongOrgType" field="belongOrgType" style="width: 90%"  dataset="belongOrgTypeSelect"/></td>		
					<td class="FieldLabel"><label>隶属组织:</label></td>
					<td class="FieldInput"><label name='隶属组织' id="belongOrg" field="belongOrg" style="width: 90%"/></td>				
					<td class="FieldLabel"><label>组织关系是否在服务中心管理:</label></td>
					<td class="FieldInput"><label name='组织关系是否在服务中心管理' id="relation" field="relation" style="width: 90%" dataset="comm_yesorno"></label></td>
				</tr>
				<tr>	
					<td class="FieldLabel" width="14%"><label>申请入党日期:</label></td>
					<td class="FieldInput" width="21%"><label name='申请入党日期' type="text" id="applicationDate" field="applicationDate" format="Y-m-d"  readonly="readonly" style="width: 90%"/></td>			
					<td class="FieldLabel" width="14%"><label>列为入党积极分子日期:</label></td>
					<td class="FieldInput" width="18%"><label name='列为入党积极分子日期' type="text"  id="activistsDate" field="activistsDate" format="Y-m-d"  readonly="readonly" style="width: 90%"/></td>
					<td class="FieldLabel" width="14%"><label>列为发展对象日期:</label></td>
					<td class="FieldInput" width="19%"><label name='列为发展对象日期' type="text" id="developDate" field="developDate" format="Y-m-d"  readonly="readonly" style="width: 90%"/></td>			
				</tr>
				<tr>
					<td class="FieldLabel"><label>列为预备党员日期:</label></td>
					<td class="FieldInput"><label type="text" name="列为预备党员日期" id="joinDate" field="joinDate" format="Y-m-d"  readonly="readonly" style="width: 90%"/></td>
					<td class="FieldLabel"><label>转正日期:</label></td>
					<td class="FieldInput"><label type="text" name="转正日期" id="normalDate" field="normalDate" format="Y-m-d"  readonly="readonly" style="width: 90%"/></td>
					<td class="FieldLabel"><label>转正情况:</label></td>
					<td class="FieldInput"><label name='转正情况' id="normalInfo" field="normalInfo" style="width: 90%" dataset='normalInfoSelect'></label></td>
				</tr>
			</table>
		</fieldset>
		</div>
		<div id="yubeiDiv" style="display:block">
		<fieldset>
			<legend>相关信息</legend>
			<table width="100%">
				<tr>
					<td class="FieldLabel" width="14%"><label>社会组织党内职务:</label></td>
					<td class="FieldInput" width="21%"><label type="text" name="社会组织党内职务" id="partyDuties" field="partyDuties" style="width: 90%"/></td>			
					<td class="FieldLabel" width="14%"><label>党建指导员标识:</label></td>
					<td class="FieldInput" width="18%"><label name="党建指导员标识" id="ifInstrctor" field="ifInstrctor" style="width: 90%" dataset='comm_yesorno'></label></td>			
					<td class="FieldLabel" width="14%"><label>跨支部党员标识:</label></td>
					<td class="FieldInput" width="19%"><label name="跨支部党员标识" id="ifOtherBranch" field="ifOtherBranch" style="width: 90%" dataset='comm_yesorno'></label></td>			
				</tr>
				<tr>		
					<td class="FieldLabel"><label>隶属组织:</label></td>
					<td class="FieldInput" colspan='3'><label name='隶属组织' id="belongOrg" field="belongOrg" style="width: 90%"/></td>				
					<td class="FieldLabel"><label>组织关系是否在服务中心管理:</label></td>
					<td class="FieldInput"><label name='组织关系是否在服务中心管理' id="relation" field="relation" style="width: 90%" dataset="comm_yesorno"></label></td>
				</tr>
				<tr>	
					<td class="FieldLabel" width="14%"><label>申请入党日期:</label></td>
					<td class="FieldInput" width="21%"><label name='申请入党日期' type="text" id="applicationDate" field="applicationDate" format="Y-m-d"  readonly="readonly" style="width: 90%"/></td>			
					<td class="FieldLabel" width="14%"><label>列为入党积极分子日期:</label></td>
					<td class="FieldInput" width="18%"><label name='列为入党积极分子日期' type="text"  id="activistsDate" field="activistsDate" format="Y-m-d"  readonly="readonly" style="width: 90%"/></td>
					<td class="FieldLabel" width="14%"><label>列为发展对象日期:</label></td>
					<td class="FieldInput" width="19%"><label name='列为发展对象日期' type="text" id="developDate" field="developDate" format="Y-m-d"  readonly="readonly" style="width: 90%"/></td>			
				</tr>
				<tr>
					<td class="FieldLabel"><label>列为预备党员日期:</label></td>
					<td class="FieldInput"><label type="text" name="列为预备党员日期" id="joinDate" field="joinDate" format="Y-m-d"  readonly="readonly" style="width: 90%"/></td>
					<td class="FieldLabel"></td>
					<td class="FieldInput"></td>
					<td class="FieldLabel"></td>
					<td class="FieldInput"></td>
				</tr>
			</table>
		</fieldset>
		</div>
		<div id="fazhanDiv" style="display:none">
		<fieldset>
			<legend>相关信息</legend>
			<table width="100%">
				<tr>	
					<td class="FieldLabel" width="14%"><label>申请入党日期:</label></td>
					<td class="FieldInput" width="21%"><label name='申请入党日期' type="text" id="applicationDate" field="applicationDate" format="Y-m-d"  readonly="readonly" style="width: 90%"/></td>			
					<td class="FieldLabel" width="14%"><label>列为入党积极分子日期:</label></td>
					<td class="FieldInput" width="18%"><label name='列为入党积极分子日期' type="text"  id="activistsDate" field="activistsDate" format="Y-m-d"  readonly="readonly" style="width: 90%"/></td>
					<td class="FieldLabel" width="14%"><label>列为发展对象日期:</label></td>
					<td class="FieldInput" width="19%"><label name='列为发展对象日期' type="text" id="developDate" field="developDate" format="Y-m-d"  readonly="readonly" style="width: 90%"/></td>			
				</tr>
			</table>
		</fieldset>
		</div>
		<div id="jijifenziDiv" style="display:none">
		<fieldset>
			<legend>相关信息</legend>
			<table width="100%">
				<tr>	
					<td class="FieldLabel" width="14%"><label>申请入党日期:</label></td>
					<td class="FieldInput" width="21%"><label name='申请入党日期' type="text" id="applicationDate" field="applicationDate" format="Y-m-d"  readonly="readonly" style="width: 90%"/></td>			
					<td class="FieldLabel" width="14%"><label>列为入党积极分子日期:</label></td>
					<td class="FieldInput" width="18%"><label name='列为入党积极分子日期' type="text"  id="activistsDate" field="activistsDate" format="Y-m-d"  readonly="readonly" style="width: 90%"/></td>
					<td class="FieldLabel" width="14%"></td>
					<td class="FieldInput" width="19%"></td>			
				</tr>
			</table>
		</fieldset>
		</div>
		<div id="shenqingrenDiv" style="display:none">
		<fieldset>
			<legend>相关信息</legend>
			<table width="100%">
				<tr>	
					<td class="FieldLabel" width="14%"><label>申请入党日期:</label></td>
					<td class="FieldInput" width="21%"><label name='申请入党日期' type="text" id="applicationDate" field="applicationDate" format="Y-m-d"  readonly="readonly" style="width: 90%"/></td>			
					<td class="FieldLabel" width="14%"></td>
					<td class="FieldInput" width="18%"></td>
					<td class="FieldLabel" width="14%"></td>
					<td class="FieldInput" width="19%"></td>			
				</tr>
			</table>
		</fieldset>
		</div>
		</form>
	</next:Html>
</next:Panel>
			<next:EditGridPanel id="partyPraiseGrid" dataset="somPartyPraiseInsertDataSet" stripeRows="true" title="奖惩情况" height="100%" >
				<next:Columns>
					<next:RowNumberColumn/>
					<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column header="内码" field="praiseId" width="15%" editable="true" hidden="true"><next:TextField/></next:Column>
					<next:Column header="奖惩批准日期" field="praiseDate" width="10%" editable="true"><next:DateTimeField allowBlank="true" format="Y-m-d"/></next:Column>
					<next:Column header="奖惩类型" field="praiseOrPunnish" width="10%" editable="true"><next:ComboBox dataset="praiseOrPunnishSelect" typeAble="false"></next:ComboBox></next:Column>
					<next:Column header="奖惩事项分类" field="praiseItemType" width="20%" editable="true"><next:ComboBox dataset="praiseTypeSelect" typeAble="false"></next:ComboBox></next:Column>
					<next:Column header="奖惩名称" field="praiseName" width="30%" editable="true" ><next:TextField/></next:Column>
					<next:Column header="表彰授予称号" field="grantedTitle" width="10%" editable="true"><next:ComboBox id="grantedTitleComboBox" dataset="grantedTitleSelect" typeAble="false"></next:ComboBox></next:Column>
					<next:Column header="奖惩批准单位名称" field="praiseOrg" width="30%" editable="true"><next:TextField/></next:Column>
					<next:Column header="文件号" field="fileNo" width="15%" editable="true"><next:TextField/></next:Column>
					<next:Column header="相关文件" field="fileName" width="25%" editable="true"><next:TextField/></next:Column>
					<next:Column header="下载附件" field="" width="10%" editable="false" renderer="download_praise"><next:TextField /></next:Column>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="somPartyPraiseInsertDataSet"/>
				</next:BottomBar>
			</next:EditGridPanel>	
		</next:Tabs>
	</next:TabPanel>				  
</next:Panel>
<jsp:include page="../../comm/upload/partyUpload.jsp" flush="true"/>	 
</body>
</html>