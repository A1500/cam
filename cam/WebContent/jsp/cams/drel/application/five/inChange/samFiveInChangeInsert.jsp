<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<html>
<head>
<title>农村五保县（区）内变更</title>
<next:ScriptManager />
<script type="text/javascript">
	<%
		String applyId=request.getParameter("applyId");//业务主键
		String beginDateOriginal=request.getParameter("beginDate");//原救助开始日期
		String nowTime= DateUtil.getDay();
		String nowMonth= DateUtil.getMonth();
		String organArea=BspUtil.getCorpOrgan().getOrganCode();
		String organName=DicUtil.getTextValueFromDic("DIC_CITY","ID",organArea,"NAME");
		String organCodeStr = UserCommand.getSubOrganCode(organArea) ;
	%>
	var applyId='<%=applyId%>';
	var beginDateOriginal='<%=beginDateOriginal%>';
	var nowTime='<%=nowTime%>';
	var nowMonth='<%=nowMonth%>';
	var organArea = '<%=organArea%>';
	var organName = '<%=organName%>';
	var rootPath='<%=SkinUtils.getRootUrl(request)%>';
	//获取当前时间
	function getCurrent(){		
		return (new Date()).getTime();
	}
</script>
<script type="text/javascript" src="samFiveInChangeInsert.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/somPhoto.js")%>'></script>
<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ISEditPhoto.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>	

<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>jsp/cams/comm/dicm/autoComplete.js"></script>
<link href="<%=SkinUtils.getRootUrl(request)%>jsp/cams/comm/dicm/autoComplete.css" rel="stylesheet" type="text/css" />

</head>
<body>
<model:datasets>
	<!-- 业务信息 -->
	<model:dataset id="applyDataSet"
		cmd="com.inspur.cams.drel.sam.cmd.SamApplyInfoQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplyInfo">
		</model:record>
	</model:dataset>
	<!-- 家庭基本信息 -->
	<model:dataset id="familyDataSet" cmd="com.inspur.cams.drel.sam.cmd.BaseinfoFamilyQueryCmd" global="true"  >
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoFamily">
			<model:field name="address" type="string" rule="require|length{200}" />
			<model:field name="beginDate" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<!-- 家庭成员信息 -->
	<model:dataset id="peopleListDataSet"
		cmd="com.inspur.cams.drel.sam.cmd.BaseinfoPeopleQueryCmd" method='queryPeopleForSam'
		global="true">
		<model:record
			fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople"></model:record>
	</model:dataset>
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO"
		autoLoad="true" global="true"></model:dataset>
	<!-- 健康状况 -->
	<model:dataset id="healthCodeDataset" enumName="SAM_HEALTH_CODE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 残疾类别 -->
	<model:dataset id="disabilityTypeDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_DISABILITY_TYPE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 与户主关系 -->
	<model:dataset id="relationshipTypeDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_RELATIONSHIP_TYPE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 职业状况-->
	<model:dataset id="employmentCodeDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_EMPLOYMENT_CODE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 文化程度-->
	<model:dataset id="eduDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='dic_education'></model:param>
		</model:params>
	</model:dataset>
	<!-- 供养机构 -->
	<model:dataset id="supportOrgDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SAM_SUPPORT_ORGAN'></model:param>
			<model:param name="value" value='ORGAN_ID'></model:param>
			<model:param name="text" value='ORGAN_NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 劳动能力 -->
	<model:dataset id="laborCapacityDataset" enumName="SAM_LABOR_CAPACITY"
		autoLoad="true" global="true"></model:dataset>
	<!-- 供养方式 -->
	<model:dataset id="supportWayDataset" enumName="SAM.SUPPORT_WAY" autoLoad="true" global="true"></model:dataset>
	<!-- 学业状况 -->
	<model:dataset id="eduStatusDataset" enumName="SAM_EDU_STATUS" autoLoad="true" global="true"></model:dataset>
	<!-- 生活自理能力 -->
	<model:dataset id="selfCareAbilityDataset" enumName="SAM_SELF_CARE_ABILITY" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="dicCityDs" cmd="com.inspur.cams.comm.diccity.cmd.DicCityQueryCommand" global="true" pageSize="8">
		<model:record fromBean="com.inspur.cams.comm.diccity.data.DicCity"></model:record>
			<model:params>
			<model:param name="id@rlike" value='<%=organCodeStr%>'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<next:Panel height="100%" autoScroll="true" id="tab">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem id="saveId" disabled="" iconCls="save" text="保存" handler="save" />
		<next:ToolBarItem iconCls="undo" text="关闭" handler="returnBack" />
	</next:TopBar>
	<next:Panel title="家庭基本信息" titleCollapse="true" collapsible="true"
		autoHeight="true" autoScroll="true">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="detail" text="家庭详细信息"
				handler="detailexpand" />
		</next:TopBar>
		<next:Html>
			<form method="post" onsubmit="return false" class="L5form"
				dataset="familyDataSet">
			<table width="100%">
				<input type="hidden" name="familyId" field="familyId" value="1" />
				<tr>					
				<td class="FieldLabel" style="width: 15%">户主姓名</td>
				<td class="FieldInput" style="width: 18%"><label
					name="户主姓名" title="户主姓名" field="familyName"  style="width:80%" ></label>		</td>				
				<td class="FieldLabel" style="width: 15%">身份证号</td>
				<td class="FieldInput" style="width: 18%"><label
					name="身份证号" title="身份证号" field="familyCardNo" style="width:80%" /></label></td>
				
				<td class="FieldLabel" style="width: 15%" rowspan="4">照片</td>
				<td class="FieldInput" style="width: 18%" rowspan="4">
					<div id="photoDiv">
						<img id="img" name="FAMILY_IMG"  width=140 height=90  src="<%=SkinUtils.getRootUrl(request) %>jsp/cams/sorg/comm/signet/default.jpg" 
							align="top" 
							onerror="javascript:this.src='<%=SkinUtils.getRootUrl(request) %>jsp/cams/sorg/comm/signet/default.jpg'" alt="暂无图片" />
						<input type="hidden" id="familyPhotoId" name="familyPhotoId"/>
					</div>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%">供养方式</td>
				<td class="FieldInput" style="width: 18%"><label id='supportWay' /></td>
				<td class="FieldLabel" style="width: 15%">供养机构</td>
				<td class="FieldInput" style="width: 18%"><label id='supportOrg' /></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%">地区<font color="red" >(点击？选择或者输入汉字、首字母拼音检索)</font></td>
				<td class="FieldInput" style="width: 18%">
				  <input type="text" style="width:78%" name="地区" id="lrdwmc" field="domicileName" onkeyup="findDiv2(this,'lrdwId','popup','','dicCityDs','PY_CAPITAL@like','NAME@like','id','name','30')" onblur="clearDiv()"  style="width:300"/>
                	 <div id="popup" style="width:300px; height: 150px; display: none;position: absolute;background-color: #FFFFFF;" >  
    								<ul></ul> </div>
				<input type="hidden"  name="地区编码" id="lrdwId" field="domicileCode" />
				 <img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"  style="cursor:hand" onclick="func_ForDomicileSelect()" /><font color="red">*</font>
				</td>
				<td class="FieldLabel" style="width: 15%">邮政编码</td>
	                     <td class="FieldInput" style="width: 18%"><input type="text"
	                         name="居住地邮编" title="居住地邮编" field="familyPostcode" maxlength="6" style="width:80%" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%">家庭地址</td>
				<td class="FieldInput" style="width: 18%" colspan="3"><input type="text"
					name="家庭地址" title="家庭地址" field="address" maxlength="100" style="width:93%" /><font color="red">*</font></td>				
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%">联系人</td>
				<td class="FieldInput" style="width: 18%"><input type="text" maxlength="20"
					name="联系人" title="联系人" field="familyContact" style="width:80%" /></td>
				<td class="FieldLabel" style="width: 15%">联系电话</td>
				<td class="FieldInput" style="width: 18%"><input type="text" maxlength="20"
					name="联系电话" title="联系电话" field="familyMobile" style="width:80%" /></td>		
				<td class="FieldLabel" style="width: 15%"></td>
				<td class="FieldInput" style="width: 18%"></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%">供养人口数</td>
				<td class="FieldInput" style="width: 18%"><label field="assistancePeopleNum" style="width:80%" ></label></td>
				<td class="FieldLabel" style="width: 15%">变更后救助开始月份</td>
				<td class="FieldInput" style="width: 18%"><input type="text"
					name="救助开始月份" title="救助开始月份" id="beginDate" field="beginDate" style="width:80%" onclick="WdatePicker({dateFmt:'yyyy-MM'})" readonly="readonly"/><font color="red">*</font>
				</td>
				<td class="FieldLabel" style="width: 15%"></td>
				<td class="FieldInput" style="width: 18%"></td>
			</tr>
			</table>
			</form>
		</next:Html>
	</next:Panel>

	<next:EditGridPanel id="peoplePanel" titleCollapse="true"
		collapsible="true" stripeRows="true" autoHeight="true"
		dataset="peopleListDataSet" title="家庭成员基本信息">
		<next:Columns>
			<next:RowNumberColumn />
		    <next:RadioBoxColumn></next:RadioBoxColumn> 	
			<next:Column  id="name" field="NAME" header="姓名" width="100" renderer="getName">
				<next:TextField editable="false"/>
			</next:Column>
			
			<next:Column field="RELATIONSHIP_TYPE" header="与户主关系" width="115">
				<next:ComboBox editable="false" dataset="relationshipTypeDataset" displayField="text" valueField="value" typeAhead="true" />
			</next:Column>
			
			<next:Column   field="HEALTH_CODE" header="健康状况" width="100" >
				<next:ComboBox editable="false" dataset="healthCodeDataset" displayField="text" valueField="value" typeAhead="true" />
			</next:Column>
			<next:Column   field="IS_ASSISTANCE" header="是否供养对象" width="100">
					<next:ComboBox editable="false" dataset="comm_yesorno" displayField="text" valueField="value" typeAhead="true" />
				</next:Column>
			<next:Column   field="DISABILITY_TYPE" header="残疾类别" width="100" >
				<next:ComboBox editable="false" dataset="disabilityTypeDataset" displayField="text" valueField="value" typeAhead="true" />
			</next:Column>
			
			<next:Column   field="EDU_STATUS" header="学业状况" width="100">
				<next:ComboBox editable="false" dataset="eduStatusDataset" displayField="text" valueField="value" typeAhead="true" />
			</next:Column>
			
			<next:Column  field="SELF_CARE_ABILITY" header="生活自理能力" width="100">
				<next:ComboBox editable="false" dataset="selfCareAbilityDataset" displayField="text" valueField="value" typeAhead="true" />
			</next:Column>
		</next:Columns>
	</next:EditGridPanel>
</next:Panel>
</body>
</html>
