<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.bsp.id.util.MaxValueUtil"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%
	String jtid = request.getParameter("dataBean");
	String cyid = MaxValueUtil.nextStringValue("CYID");
	String organArea = BspUtil.getCorpOrgan().getOrganCode();
	String photoId = request.getParameter("photoId");
	String photoTable = "COM_PHOTO";
	if(photoId!=null && photoId.length()>0){
		photoTable = photoTable+"_"+photoId.substring(0,6);
	}
%>
<html>
<head>
<title>社会救助_家庭信息</title>
<next:ScriptManager />
<script>
var idField='<%=request.getParameter("dataBean")%>';
var peopleId='<%=request.getParameter("peopleId")%>';
var method='<%= request.getParameter("method")%>';
var organArea='<%= organArea%>';
</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsPhoto.js")%>'></script>
<script type="text/javascript" src="samFamilyEdit.js"></script>
<script type="text/javascript" src="FamilyComm.js"></script>
<script type="text/javascript" src="IDCard.js"></script>
<script type="text/javascript" src="crjEditPhoto.js"></script>
<script type="text/javascript" src="MultiSimpleinsertHelp.js"></script>
</head>

<body>
<model:datasets>
	<!-- 家庭信息 -->
	<model:dataset id="BaseinfoFamilyDS" cmd="com.inspur.cams.drel.sam.cmd.SamBaseFamilyQueryCmd"  >
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoFamily"></model:record>
	</model:dataset>
	<!-- 家庭成员信息 -->
	<model:dataset id="BaseinfoPeopleDS" pageSize="-1" cmd="com.inspur.cams.drel.sam.cmd.SamBasePeopleCmd">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople"></model:record>
	</model:dataset>
    <!-- 救助类型 -->
	<model:dataset id="assistanceTypeDS"  cmd="com.inspur.cams.drel.sam.cmd.SamFamilyAssistanceCmd">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamFamilyAssistance"></model:record>
	</model:dataset>
	<!-- 家庭成员编辑 -->
	<model:dataset id="BaseinfoPeopleDS2" cmd="com.inspur.cams.drel.sam.cmd.SamBasePeopleCmd" >
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople"></model:record>
	</model:dataset>
	<model:dataset id="BaseinfoPeopleDS3" cmd="com.inspur.cams.drel.sam.cmd.SamBasePeopleCmd"  global="true" autoLoad="false">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople"></model:record>
	</model:dataset>
	<!-- 住房状况类型 -->
	<model:dataset id="DmZfzklxDataSet" cmd="com.inspur.cams.drel.dicm.cmd.DmQueryCommand" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.drel.dicm.data.DmBean"></model:record>
		<model:params>
			<model:param name="tableName" value='DM_ZFZKLX'></model:param>
		</model:params>
	</model:dataset>
	<!-- 行政区划 -->
	<model:dataset id="DmXzqhDataSetStreet" cmd="com.inspur.cams.drel.dicm.cmd.DmQueryCommand" global="true" autoLoad="false">
		<model:record fromBean="com.inspur.cams.drel.dicm.data.DmBean"></model:record>
		<model:params>
			<model:param name="tableName" value='DM_XZQH'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="DmXzqhDataSetVillage" cmd="com.inspur.cams.drel.dicm.cmd.DmQueryCommand" global="true" autoLoad="false">
		<model:record fromBean="com.inspur.cams.drel.dicm.data.DmBean"></model:record>
		<model:params>
			<model:param name="tableName" value='DM_XZQH'></model:param>
		</model:params>
	</model:dataset>
	<!-- 房屋结构类型 -->
	<model:dataset id="DmFwjgDataSet" cmd="com.inspur.cams.drel.dicm.cmd.DmQueryCommand" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.drel.dicm.data.DmBean"></model:record>
		<model:params>
			<model:param name="tableName" value='DM_FWJG'></model:param>
		</model:params>
	</model:dataset>
	<!-- 救助类型 -->
	<model:dataset id="DmJzlxDataSet"
		cmd="com.inspur.cams.drel.dicm.cmd.DmQueryCommand" global="true" pageSize="20" autoLoad="true">
		<model:record fromBean="com.inspur.cams.drel.dicm.data.DmBean"></model:record>
		<model:params>
			<model:param name="tableName" value='DM_JZLX'></model:param>
		</model:params>
	</model:dataset>
	<!-- 与户主关系 -->
	<model:dataset id="DmHzgxDataSet" cmd="com.inspur.cams.drel.dicm.cmd.DmQueryCommand" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.drel.dicm.data.DmBean"></model:record>
		<model:params>
			<model:param name="tableName" value='DM_HZGX'></model:param>
			<model:param name="valueField" value='HZGXDM'></model:param>
			<model:param name="textField" value='HZGXMC'></model:param>
		</model:params>
	</model:dataset>
	<!-- 性别代码-->
	<model:dataset id="DmXbDataSet" cmd="com.inspur.cams.drel.dicm.cmd.DmQueryCommand" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.drel.dicm.data.DmBean"></model:record>
		<model:params>
			<model:param name="tableName" value='DM_XB'></model:param>
		</model:params>
	</model:dataset>
	<!-- 民族代码-->
	<model:dataset id="DmMzDataSet" cmd="com.inspur.cams.drel.dicm.cmd.DmQueryCommand" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.drel.dicm.data.DmBean"></model:record>
		<model:params>
			<model:param name="tableName" value='DM_MZ'></model:param>
		</model:params>
	</model:dataset>
	<!-- 户籍性质-->
	<model:dataset id="DmHjxzDataSet" cmd="com.inspur.cams.drel.dicm.cmd.DmQueryCommand" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.drel.dicm.data.DmBean"></model:record>
		<model:params>
			<model:param name="tableName" value='DM_HJXZ'></model:param>
		</model:params>
	</model:dataset>
	<!-- 婚姻状况-->
	<model:dataset id="DmHyzkDataSet" cmd="com.inspur.cams.drel.dicm.cmd.DmQueryCommand" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.drel.dicm.data.DmBean"></model:record>
		<model:params>
			<model:param name="tableName" value='DM_HYZK'></model:param>
		</model:params>
	</model:dataset>
	<!-- 医疗状况-->
	<model:dataset id="DmYlzkDataSet" cmd="com.inspur.cams.drel.dicm.cmd.DmQueryCommand" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.drel.dicm.data.DmBean"></model:record>
		<model:params>
			<model:param name="tableName" value='DM_YLZK'></model:param>
		</model:params>
	</model:dataset>
	<!-- 职业状况-->
	<model:dataset id="DmZyDataSet" cmd="com.inspur.cams.drel.dicm.cmd.DmQueryCommand" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.drel.dicm.data.DmBean"></model:record>
		<model:params>
			<model:param name="tableName" value='DM_ZY'></model:param>
		</model:params>
	</model:dataset>

    <!-- 自然灾害 -->
	<model:dataset id="SamFamilyCalamityDataSet" pageSize="5" cmd="com.inspur.cams.drel.sam.cmd.SamFamilyCalamityCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamFamilyCalamity"></model:record>
	</model:dataset>
	<!-- 灾害种类 -->
	<model:dataset id="DmZhzlDataSet" cmd="com.inspur.cams.drel.dicm.cmd.DmQueryCommand" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.drel.dicm.data.DmBean"></model:record>
		<model:params>
			<model:param name="tableName" value='DM_ZHZL'></model:param>
			<model:param name="valueField" value='ZHZLDM'></model:param>
			<model:param name="textField" value='ZHZLMC'></model:param>
		</model:params>
	</model:dataset>
	<!-- 灾害损失金额 -->
	<model:dataset id="DmZhssjeDataSet" cmd="com.inspur.cams.drel.dicm.cmd.DmQueryCommand" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.drel.dicm.data.DmBean"></model:record>
		<model:params>
			<model:param name="tableName" value='DM_ZHSSJE'></model:param>
			<model:param name="valueField" value='ZHSSJEDM'></model:param>
			<model:param name="textField" value='ZHSSJEMC'></model:param>
		</model:params>
	</model:dataset>
	<!-- 人员残疾信息 -->
	<model:dataset id="SamPeopleDisabilityDataSet" cmd="com.inspur.cams.drel.sam.cmd.SamPeopleDisabilityCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamPeopleDisability"></model:record>
	</model:dataset>
   <!-- 残疾类型 -->
	<model:dataset id="DmCjlxDataSet" cmd="com.inspur.cams.drel.dicm.cmd.DmQueryCommand" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.drel.dicm.data.DmBean"></model:record>
		<model:params>
			<model:param name="tableName" value='DM_CJLX'></model:param>
			<model:param name="valueField" value='CJLXDM'></model:param>
			<model:param name="textField" value='CJLXMC'></model:param>
		</model:params>
	</model:dataset>
	<!-- 残疾等级 -->
	<model:dataset id="DmCjdjDataSet" cmd="com.inspur.cams.drel.dicm.cmd.DmQueryCommand" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.drel.dicm.data.DmBean"></model:record>
		<model:params>
			<model:param name="tableName" value='DM_CJDJ'></model:param>
		    <model:param name="valueField" value='CJDJDM'></model:param>
			<model:param name="textField" value='CJDJMC'></model:param>
		</model:params>
	</model:dataset>
    <!-- 人员教育信息 -->
	<model:dataset id="SamPeopleEduDataSet" cmd="com.inspur.cams.drel.sam.cmd.SamPeopleEduCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamPeopleEdu"></model:record>
	</model:dataset>
    <!-- 教育状况 -->
	<model:dataset id="DmJyzkDataSet" cmd="com.inspur.cams.drel.dicm.cmd.DmQueryCommand" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.drel.dicm.data.DmBean"></model:record>
		<model:params>
			<model:param name="tableName" value='DM_JYZK'></model:param>
			<model:param name="valueField" value='JYZKDM'></model:param>
			<model:param name="textField" value='JYZKMC'></model:param>
		</model:params>
	</model:dataset>
	<!-- 教育状况年级 -->
	<model:dataset id="DmJyzknjDataSet" cmd="com.inspur.cams.drel.dicm.cmd.DmQueryCommand" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.drel.dicm.data.DmBean"></model:record>
		<model:params>
			<model:param name="tableName" value='DM_JYZKNJ'></model:param>
			<model:param name="valueField" value='JYZKNJDM'></model:param>
			<model:param name="textField" value='JYZKNJMC'></model:param>
		</model:params>
	</model:dataset>
    <!-- 人员患病信息 -->
	<model:dataset id="SamPeopleDiseaseDataSet" cmd="com.inspur.cams.drel.sam.cmd.SamPeopleDiseaseCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamPeopleDisease"></model:record>
	</model:dataset>
    <!-- 患病种类-->
	<model:dataset id="DmHbzlDataSet" cmd="com.inspur.cams.drel.dicm.cmd.DmQueryCommand" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.drel.dicm.data.DmBean"></model:record>
		<model:params>
			<model:param name="tableName" value='DM_HBZL'></model:param>
			<model:param name="valueField" value='HBZLDM'></model:param>
			<model:param name="textField" value='HBZLMC'></model:param>
		</model:params>
	</model:dataset>
	<!-- 医疗支出 -->
	<model:dataset id="DmYlzcDataSet" cmd="com.inspur.cams.drel.dicm.cmd.DmQueryCommand" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.drel.dicm.data.DmBean"></model:record>
		<model:params>
			<model:param name="tableName" value='DM_YLZC'></model:param>
			<model:param name="valueField" value='YLZCDM'></model:param>
			<model:param name="textField" value='YLZCMC'></model:param>
		</model:params>
	</model:dataset>
    <!-- 人员事故信息 -->
	<model:dataset id="SamPeopleAccidentDataSet" cmd="com.inspur.cams.drel.sam.cmd.SamPeopleAccidentCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamPeopleAccident"></model:record>
	</model:dataset>
	<!-- 事故种类-->
	<model:dataset id="DmSgzlDataSet" cmd="com.inspur.cams.drel.dicm.cmd.DmQueryCommand" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.drel.dicm.data.DmBean"></model:record>
		<model:params>
			<model:param name="tableName" value='DM_SGZL'></model:param>
			<model:param name="valueField" value='SGZLDM'></model:param>
			<model:param name="textField" value='SGZLMC'></model:param>
		</model:params>
	</model:dataset>
	<!-- 事故损失-->
	<model:dataset id="DmSgssDataSet" cmd="com.inspur.cams.drel.dicm.cmd.DmQueryCommand" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.drel.dicm.data.DmBean"></model:record>
		<model:params>
			<model:param name="tableName" value='DM_SGSS'></model:param>
			<model:param name="valueField" value='SGSSDM'></model:param>
			<model:param name="textField" value='SGSSMC'></model:param>
		</model:params>
	</model:dataset>
	<!-- 供养方式-->
	<model:dataset id="supportWayDS"  enumName="SAM.SUPPORT_WAY"  autoLoad="true" global="true"></model:dataset>
    <!-- 开户银行-->
	<model:dataset id="bankCodeDS"  enumName="BANK.CODE"  autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:Panel width="98%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="提交" handler="modifyClick" />
		<next:ToolBarItem iconCls="undo" text="返回" handler="returnClick" />
	</next:TopBar>
	<next:TabPanel id="tabPanels" height="900" width="100%" activeTab="0">
		<next:Tabs>
			<next:Panel title="困难户家庭信息" name="社会基本信息" height="600">
				<next:AnchorLayout>
					<next:Panel title="基本信息" autoHeight="true" collapsible="true">
						<next:Html>
							<form id="YgjzJtxxForm" method="post" dataset="BaseinfoFamilyDS" onsubmit="return false"   class="L5form">
							<table border="0" width="100%">
									<tr>
									<td class="FieldLabel"  width="10%">户主姓名：</td>
									<td class="FieldInput"  width="20%"><input type="text" id="familyName" name="户主姓名" maxlength="25" field="familyName" onchange="checkCN('familyName','familyCardNo','户主姓名');" style="width:60%"/><font color="red">*</font></td>
									<td class="FieldLabel"  width="10%">身份证号：</td>
									<td class="FieldInput"  width="20%"><input type="text" id="familyCardNo"  name="身份证号" maxlength="18" onchange="checkIDCard('familyCardNo','户主身份证');checkIfRepeat();"   style="width:60%" field="familyCardNo" /><font color="red">*</font><br>若该人无身份证,<a href="#" onClick="getMaxCode('familyCardNo');">请点击此处获取编号</a></td>
									<td class="FieldLabel"   width="15%">人口数量：</td>
									<td class="FieldInput"  width="20%"><span onmousemove="this.setCapture();" onmouseout="this.releaseCapture();">
									<input type="text" style="width: 20%" name="peopleNum" maxlength="2" field="peopleNum" readonly="true"/></span>&nbsp;&nbsp;<font color=green>自动生成</font></td>
								</tr>
								<tr >
									<td class="FieldLabel" >地址_镇：</td>
									<td class="FieldInput"  > <select id="town" name="地址_镇" field="town" onchange="setXzqhVillage()" style="width:60%">
																					<option dataset="DmXzqhDataSetStreet"></option> </select><font color="red">*</font></td>
									<td class="FieldLabel"  >地址_村(居)：</td>
									<td class="FieldInput"  > <select id="village" name="地址_村(居)" style="width:60%" field="village"> <option dataset="DmXzqhDataSetVillage"></option> </select></td>
									<td class="FieldLabel"  nowrap>家庭地址：</td>
									<td class="FieldInput"  ><input type="text" name="address" maxlength="50" field="address" style="width:60%"/></td>
								</tr>
								<tr>
									<td class="FieldLabel" >宅电：</td>
									<td class="FieldInput" ><input type="text" id="familyPhone" name="familyPhone" maxlength="20" onchange="checkDhhm();" field="familyPhone" style="width:60%"/></td>
									<td class="FieldLabel" >手机：</td>
									<td class="FieldInput"  ><input type="text" id="familyMobile" name="familyMobile" maxlength="20" onchange="checkSjhm();" style="width:60%" field="familyMobile" /></td>
									<td class="FieldLabel"   nowrap >其他联系方式：</td>
									<td class="FieldInput"  ><input type="text" name="familyOtherPhone" maxlength="25" field="familyOtherPhone" style="width:60%"/></td>
								</tr>
								<tr >
									<td class="FieldLabel"  nowrap="nowrap"  >家庭年总收入:<br>(单位：元)&nbsp</td>
									<td class="FieldInput"  ><input type="text" id="yearIncome" name="家庭年总收入" maxlength="9" field="yearIncome"  onchange=" CheckTxt('yearIncome','家庭年总收入');" style="width:60%"/><font color="red">*</font></td>
									<td class="FieldLabel"  nowrap="nowrap" >家庭年人均收入：<br>(单位：元)&nbsp</td>
									<td class="FieldInput"  ><span onmousemove="this.setCapture();" onmouseout="this.releaseCapture();">
									<input type="text" name="yearAverageIncome" maxlength="9" style="width:60%" field="yearAverageIncome" readonly="true"/></span>&nbsp;<font color=green>自动生成</font></td>
									<td class="FieldLabel"  rowspan="4">照片:</td>
		   						     <td class="FieldInput" nowrap  rowspan="4">
		   						       <img id="PHOTO_IMG" name="PHOTO_IMG" width=150 height=200
                                         src="<%=SkinUtils.getRootUrl(request) %>download?table=<%=photoTable %>&column=PHOTO_CONTENT&pk=PHOTO_ID&PHOTO_ID='<%=photoId %>'"
                                         onerror="javascript:this.src='<%=SkinUtils.getImage(request,"default.jpg")%>'" alt="暂无图片"
                                         ondblclick="editPhoto(1,'photoTemp','PHOTO_IMG')"
                                        />
                                        <input type="hidden" name="photoTemp" id="photoTemp" />
		   						    </td>

								</tr>
								<tr>
									<td class="FieldLabel" >住房状况类型：</td>
									<td class="FieldInput"  ><select id="houseStatus" name="住房状况类型" field="houseStatus" onchange="selectStructure()" style="width:60%"> <option dataset="DmZfzklxDataSet"></option> </select><font color="red">*</font></td>
									<td class="FieldLabel"  id="fwzk">房屋结构：</td>
									<td class="FieldInput"  ><select  name="buildingStructure" field="buildingStructure" style="width:60%"> <option dataset="DmFwjgDataSet"></option> </select></td>
								</tr>
								<tr>
									<td class="FieldLabel"  nowrap="nowrap" > 建筑面积 :<br>(单位：平方米)&nbsp</td>
									<td class="FieldInput"  ><input type="text" name="buildArea" maxlength="6"  field="buildArea" onchange=" CheckTxt('buildArea','建筑面积');" style="width:60%"/></td>
									<td class="FieldLabel"  nowrap > 人均建筑面积: <br>(单位：平方米) &nbsp</td>
									<td class="FieldInput"  ><span onmousemove="this.setCapture();" onmouseout="this.releaseCapture();">
									<input type="text" name="buildAverageArea" maxlength="6" style="width:60%" field="buildAverageArea" readonly="true"/></span>&nbsp;<font color=green>自动生成</font></td>

								</tr>
							    <tr>
									<td class="FieldLabel">备注:</td>
									<td colspan="3" class="FieldInput"><textarea name="note" field="note"  cols="80" rows="3" style="width:90%;height:95%"/></textarea></td>
								</tr>
								<input type="hidden" name="familyId" id="familyId" value="<%=jtid%>">
								<input type="hidden" name="peopleId" id="peopleId" value="<%=cyid%>">
								<input type="hidden" name="province" field="province">
								<input type="hidden" name="city" field="city">
								<input type="hidden" name="county" field="county">
								<input type="hidden" name="monthIncome" field="monthIncome">
								<input type="hidden" name="monthAverageIncome" field="monthAverageIncome">
								<!--家庭状态标志  -->
								<input type="hidden" name="familyStateFlag" field="familyStateFlag">
								<!--录入人姓名  -->
								<input type="hidden" name="regPeople" field="regPeople">
								<!--录入人ID  -->
								<input type="hidden" name="regId" field="regId">
								<!--录入单位名称  -->
								<input type="hidden" name="regOrgName" field="regOrgName">
								<!--录入单位区划 -->
								<input type="hidden" name="regOrgArea" field="regOrgArea">
								<!--录入单位ID -->
								<input type="hidden" name="regOrg" field="regOrg">
								<!--录入时间 -->
								<input type="hidden" name="regTime" field="regTime">
								<!--修改人姓名 -->
								<input type="hidden" name="modPeople" field="modPeople">
								<!--修改人ID -->
								<input type="hidden" name="modId" field="modId">
								<!--修改单位名称 -->
								<input type="hidden" name="modOrgName" field="modOrgName">
								<!--修改单位区划 -->
								<input type="hidden" name="modOrgArea" field="modOrgArea">
								<!--修改单位ID -->
								<input type="hidden" name="modOrg" field="modOrg">
								<input type="hidden" name="modTime" field="modTime">
								<input type="hidden" name="checkPeople" field="checkPeople">
								<input type="hidden" name="checkId" field="checkId">
								<input type="hidden" name="checkOrgArea" field="checkOrgArea">
								<input type="hidden" name="checkTime" field="checkTime">
								<input type="hidden" name="isDel" field="isDel">
								<input type="hidden" name="curActivity" field="curActivity" value="ACCEPT">
								<input type="hidden" name="photoPeople" id="photoPeople" />
							</table>
							</form>
						</next:Html>
					</next:Panel>
<next:Panel  width="100%" autoHeight="true">
			<next:Html>
				<form id="accountForm" method="post"  onsubmit="return false" class="L5form">
					<table width="100%">
					<tr>
						<td class="FieldInput" colspan="7">救助类型</td>
					</tr>
					<tr>
						<td class="FieldInput" >
							<input type="checkbox"  onclick="setCityMi(this)" id="cityMi" name="cityMi"  />
							<label>城市低保</label>
							<input type="checkbox"  onclick="setCountryMi(this)" id="countryMi" name="countryMi"  />
							<label>农村低保</label>
							<input type="checkbox"  onclick="setFiveMi(this)" id="fiveMi" name="fiveMi"  />
							<label>农村五保</label>
							<input type="checkbox"  onclick="setGiveMi(this)" id="giveMi" name="giveMi"  />
							<label>优抚</label>
							<input type="checkbox"  onclick="setHandicapped(this)" id="handicapped" name="handicapped"  />
							<label>残疾人</label>
							<input type="checkbox"  onclick="setPmother(this)" id="pmother" name="pmother"  />
							<label>单亲特困母亲</label>
							<input type="checkbox"  onclick="setKstudent(this)" id="kstudent" name="kstudent"  />
							<label>困难学生</label>
							<input type="checkbox"  onclick="setThreeNothing(this)" id="threeNothing" name="threeNothing"  />
							<label>“三无”对象</label>
							<input type="checkbox"  onclick="setTemployee(this)" id="temployee" name="temployee"  />
							<label>特困职工</label>
							<input type="checkbox"  onclick="setOther(this)" id="other" name="other"  />
							<label>其他</label>
						</td>
					</tr>
					</table>

				   <table width="100%"   id="isDetail" style="display:none">
				   	<tr><td class="FieldInput" colspan="6">详细信息</td></tr>
					<tr>
						<td class="FieldLabel" width="16%"><label>证件号码：</label></td>
						<td class="FieldInput" width="16%"><input type="text" name="cardNo" id="cardNo"     style="width:95%" /></td>
						<td class="FieldLabel" width="16%"><label>发证机关名称：</label></td>
						<td class="FieldInput" width="16%"><input type="text" name="signOrgName" id="signOrgName"  style="width:95%" /></td>
						<td class="FieldLabel" width="18%"><label>发证日期：</label></td>
						<td class="FieldInput" width="18%"><input type="text" name="signDate" id="signDate" style="width:85%" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly"/></td>
					</tr>
					<tr>
						<td class="FieldLabel" ><label>有效日期起：</label></td>
						<td class="FieldInput" ><input type="text" name="cardValidateBegin" id="cardValidateBegin"    style="width:95%" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly"/></td>
						<td class="FieldLabel" ><label>有效日期止：</label></td>
						<td class="FieldInput" ><input type="text" name="cardValidateEnd" id="cardValidateEnd"     style="width:95%" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly"/></td>
						<td class="FieldLabel" ><label>保障起始年月：</label></td>
						<td class="FieldInput" ><input type="text" name="assistanceBegin" id="assistanceBegin"   style="width:85%" format="Y-m" onclick="LoushangDate(this)" readonly="readonly"/></td>
					</tr>
					<tr>
						<td class="FieldLabel" ><label>开户银行：</label></td>
						<td class="FieldInput" ><select name="bank" id="bank"  style="width:95%"><option  dataset="bankCodeDS"></option></select></td>
						<td class="FieldLabel" ><label>开户名称：</label></td>
						<td class="FieldInput" ><input type="text" name="accountName" id="accountName"    style="width:95%" /></td>
						<td class="FieldLabel" ><label>银行账号：</label></td>
						<td class="FieldInput" ><input type="text" name="accountCode" id="accountCode"    style="width:85%" /></td>
					</tr>

					</table>
				  <table id="isCity" width="100%" style="display:none">
				    <tr><td class="FieldInput" colspan="6">城市低保</td></tr>
					<tr >
						<td class="FieldLabel" width="16%"><label>户月救助金额（元）：</label></td>
						<td class="FieldInput" width="16%"><input type="text" name="assistanceMon" id="assistanceMon"  onchange=" CheckTxt('assistanceMon','户月救助金额');" style="width:95%" /></td>
						<td class="FieldLabel" width="16%"><label>其中分类施保金额（元）：</label></td>
						<td class="FieldInput" colspan='3'><input type="text" name="assistanceClassMon" id="assistanceClassMon" onchange=" CheckTxt('assistanceClassMon','分类施保金额');" style="width:28%" /></td>
					</tr>

					</table>

				   <table id="isCountry" width="100%"  style="display:none">
                    <tr><td class="FieldInput" colspan="6">农村低保</td></tr>
					<tr>
						<td class="FieldLabel" width="16%"><label>户月救助金额（元）：</label></td>
						<td class="FieldInput" width="16%"><input type="text" name="nassistanceMon" id="nassistanceMon" onchange=" CheckTxt('nassistanceMon','户月救助金额');"  style="width:95%" /></td>
						<td class="FieldLabel" width="16%"><label>其中分类施保金额（元）：</label></td>
						<td class="FieldInput" colspan='3'><input type="text" name="nassistanceClassMon" id="nassistanceClassMon" onchange=" CheckTxt('nassistanceClassMon','分类施保金额');" style="width:28%" /></td>
					</tr>

					</table>

				   <table id="isFive" width="100%"  style="display:none">
                    <tr><td class="FieldInput" colspan="6">农村五保</td></tr>
					<tr>
						<td class="FieldLabel" width="16%"><label>供养方式：</label></td>
						<td class="FieldInput" width="16%"><select name="supportWay" id="supportWay"   style="width:95%"><option  dataset="supportWayDS"></option></select></td>
						<td class="FieldLabel" width="16%"><label>户月救助金额（元）：</label></td>
						<td class="FieldInput" colspan='3'><input type="text" name="cassistanceMon" id="cassistanceMon" onchange=" CheckTxt('cassistanceMon','户月救助金额');"  style="width:28%" /></td>
					</tr>

					</table>
				</form>
			</next:Html>
			</next:Panel>

			<next:EditGridPanel height="220" id="YgjzJtxxZrzhEditGridPanel" width="98%" autoWidth="true" collapsible="true" animCollapse="true"
					 autoScroll="true" name="YgjzJtxxZrzhEditGridPanel" stripeRows="true" dataset="SamFamilyCalamityDataSet" title="社会救助_家庭信息_自然灾害">
						<next:Columns>
							<next:RowNumberColumn width="30" />
							<next:CheckBoxColumn></next:CheckBoxColumn>
							<next:Column id="familyId" header="家庭ID" field="familyId" width="150" hidden="true">
								<next:TextField allowBlank="false" />
							</next:Column>
							<next:Column id="calamityDate" header="受灾时间" field="calamityDate" width="150" align="center">
								<next:DateField allowBlank="false" format="Y-m-d"/>
							</next:Column>
							<next:Column id="calamityType" header="灾害种类" field="calamityType" width="150" align="center">
								<next:ComboBox dataset="DmZhzlDataSet" displayField="text" valueField="value" typeAhead="true" />
							</next:Column>
							<next:Column id="lossMon" header="灾害损失_金额" field="lossMon" width="150" align="center">
								<next:ComboBox dataset="DmZhssjeDataSet" displayField="text" valueField="value" typeAhead="true" />
							</next:Column>
						</next:Columns>
						<next:TopBar>
							<next:ToolBarItem symbol="->"></next:ToolBarItem>
							<next:ToolBarItem iconCls="add" text="增加" handler="addYgjzJtxxZrzh" />
							<next:ToolBarItem iconCls="remove" text="删除" handler="removeYgjzJtxxZrzh" />
							<next:ToolBarItem xtype="tbseparator" />
							<next:ToolBarItem iconCls="undo" text="取消" handler="undoJtxxZrzh" />
						</next:TopBar>
						<next:BottomBar>
							<next:PagingToolBar dataset="SamFamilyCalamityDataSet" />
						</next:BottomBar>
			</next:EditGridPanel>

		</next:AnchorLayout>
	</next:Panel>

	<next:Panel title="家庭成员基本信息" name="anchor-div" height="100%">
				<next:AnchorLayout>
					<next:GridPanel id="YgjzJtxxCyxxEditGridPanel" name="YgjzJtxxCyxxEditGridPanel" width="98%" stripeRows="true" height="900" dataset="BaseinfoPeopleDS" title="社会救助_家庭信息_成员信息">
						<next:TopBar>
							<next:ToolBarItem symbol="->"></next:ToolBarItem>
							<next:ToolBarItem text="增加" iconCls="add" handler="addYgjzJtxxCyxx" />
							<next:ToolBarItem text="修改" iconCls="edit" handler="modifyCyxx" />
							<next:ToolBarItem text="删除" iconCls="remove" handler="removeYgjzJtxxCyxx" />
						</next:TopBar>
						<next:Columns>
							<next:RowNumberColumn width="30" />
							<next:CheckBoxColumn></next:CheckBoxColumn>
							<next:Column id="peopleId" header="成员ID" field="peopleId" width="80" hidden="true">
								<next:TextField allowBlank="false" />
							</next:Column>
							<next:Column id="familyId" header="家庭ID" field="familyId" hidden="true" align="center">
								<next:TextField allowBlank="false" editable="false" />
							</next:Column>
							<next:Column header="与户主关系" field="relationshipType" width="100" dataset="DmHzgxDataSet"  align="center"/>
							<next:Column id="name" header="姓名" field="name" width="100" align="center">
								<next:TextField />
							</next:Column>
							<next:Column id="idCard" header="身份证号" field="idCard" width="150" align="center">
								<next:TextField />
							</next:Column>
							<next:Column id="sex" header="性别" field="sex" width="100" align="center" dataset="DmXbDataSet">
								<next:TextField />
							</next:Column>
							<next:Column id="regPeople" header="录入人" field="regPeople" width="100" align="center">
								<next:TextField />
							</next:Column>
							<next:Column id="regTime" header="录入时间" field="regTime" width="150" align="center">
								<next:TextField />
							<next:Column id="photocId" header="照片" field="photoId" width="140" hidden="true" align="center">
								<next:TextField />
							</next:Column>
							</next:Column>
						</next:Columns>
					</next:GridPanel>
				</next:AnchorLayout>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>

<next:Window id="hello-win" title="家庭成员信息录入" width="785" height="480" closeAction="hide" modal="true" resizable="true" autoScroll="true">
	<next:AnchorLayout>
		<next:Panel title="基本信息" collapsible="true" animCollapse="true"  width="750" autoHeight="true">
			<next:Html>
				<form id="YgjzJtxxCyxxForm" name="YgjzJtxxCyxxForm" method="post" dataset="BaseinfoPeopleDS2" onsubmit="return false" class="L5form">
				<table border="0" width="760">
					<tr>
						<td class="FieldLabel" nowrap="nowrap" style="width: 10%">姓名：</td>
						<td class="FieldInput" style="width: 20%"><input type="text" onchange="checkJtcyCN('name','idCard','户主姓名');" id="name" name="name" field="name" style="width:90%" /><font color="red">*</font></td>
						<td class="FieldLabel" nowrap="nowrap" style="width: 10%">身份证号：</td>
						<td class="FieldInput" style="width: 20%"><input type="text" onchange="if(checkIDCard('idCard','户主身份证')){checkCyxxIfReapeat()};getBirthdayByIdCard();" id="idCard" style="width:90%" name="idCard" field="idCard" /><font color="red">*</font><br>若该人无身份证,<a href="#" onClick="getMaxCode2('jtcysfzh');">请点击此处获取编号</a></td>
						<td class="FieldLabel" width="10%" rowspan="5">照片:</td>
		   				<td  colspan="1" rowspan="5">
		   				<img id="PHOTO_PEOPLE" name="PHOTO_PEOPLE" width=150 height=200
                                     src="";
                                     onerror="javascript:this.src='<%=SkinUtils.getImage(request,"default.jpg")%>'" alt="暂无图片"
                                     ondblclick="editPhoto(1,'photoPeople','PHOTO_PEOPLE')"
                                   />
					    </td>
				    </tr>
					<tr>
						<td class="FieldLabel" nowrap="nowrap" style="width: 10%">户主关系：</td>
						<td class="FieldInput" style="width: 20%"><select id="relationshipType" name="relationshipType" field="relationshipType" style="width:90%"><option dataset="DmHzgxDataSet"></option></select><font color="red">*</font></td>
						<td class="FieldLabel" nowrap="nowrap" style="width: 10%">性别：</td>
						<td class="FieldInput" style="width: 20%"><select name="sex" field="sex" style="width:90%"><option dataset="DmXbDataSet" ></option></select><font color="red">*</font></td>
				   </tr>
				   <tr>
				   		<td class="FieldLabel" nowrap="nowrap" style="width: 10%">出生日期：</td>
						<td class="FieldInput" style="width: 20%"><input type="text" id="birthday"  style="width:90%" format="Y-m-d" name="birthday" field="birthday" onclick="LoushangDate(this)"/><font color="red">*</font></td>
						<td class="FieldLabel" nowrap="nowrap" style="width: 10%">户籍性质：</td>
						<td class="FieldInput" style="width: 20%"><select name="domicileType" field="domicileType" style="width:90%"><option dataset="DmHjxzDataSet"></option></select><font color="red">*</font></td>
				   </tr>
					<tr>
						<td class="FieldLabel" nowrap="nowrap" style="width: 10%">民族：</td>
						<td class="FieldInput" style="width: 20%"><select id="nation" name="nation" field="nation" style="width:90%"><option dataset="DmMzDataSet"></option></select><font color="red">*</font></td>
						<td class="FieldLabel" nowrap="nowrap" style="width: 10%">婚姻状况：</td>
						<td class="FieldInput" style="width: 20%"><select id="marriageCode" name="marriageCode" field="marriageCode" style="width:90%"><option dataset="DmHyzkDataSet"></option></select><font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel" nowrap="nowrap" style="width: 10%">手机：</td>
						<td class="FieldInput" style="width: 20%"><input type="text" name="telMobile" field="telMobile" onchange="checkWinSjhm();" style="width:90%"/></td>
						<td class="FieldLabel" nowrap="nowrap" style="width: 10%">其他联系方式：</td>
						<td class="FieldInput" style="width: 20%"><input type="text" name="telOther" field="telOther" style="width:90%"/></td>

				   </tr>
					<tr>
						<td class="FieldLabel" nowrap="nowrap" style="width: 10%">年收入：</td>
						<td class="FieldInput" style="width: 20%"><input type="text" name="incomeYear" field="incomeYear" onchange=" CheckTxt('incomeYear','年收入');" style="width:90%"/></td>
						<td class="FieldLabel" nowrap="nowrap" style="width: 10%">就业状况：</td>
						<td class="FieldInput" style="width: 20%"><select name="employmentCode" field="employmentCode" style="width:90%"><option dataset="DmZyDataSet"></option></select><font color="red">*</font></td>
					    <td class="FieldLabel" nowrap="nowrap" style="width: 10%">医疗状况：</td>
						<td class="FieldInput" style="width: 20%"><select name="ylzkdm"  style="width:90%" field="safeguardType"><option dataset="DmYlzkDataSet"></option></select><font color="red">*</font></td>
					</tr>
					<tr>
						<td class="FieldLabel" nowrap="nowrap" style="width: 10%">工作单位名称：</td>
						<td class="FieldInput" style="width: 20%"><input type="text" name="workUnitName"  style="width:90%" field="workUnitName" /></td>
						<td class="FieldLabel" nowrap="nowrap" style="width: 10%">工作单位电话：</td>
						<td class="FieldInput" style="width: 20%"><input type="text" name="workUnitTel" field="workUnitTel" onchange="checkWinDhhm();" style="width:90%"/></td>
						<td class="FieldLabel" nowrap="nowrap" style="width: 10%">工作单位地址：</td>
						<td class="FieldInput" style="width: 20%"><input type="text" name="workUnitAdd" field="workUnitAdd" style="width:90%"/></td>
					</tr>
					<input type="hidden" name="incomeMonth" field="incomeMonth">
				</table>
				</form>
			</next:Html>
		</next:Panel>

        <next:EditGridPanel id="YgjzCyxxCjxxEditGridPanel" name="YgjzCyxxCjxxEditGridPanel" stripeRows="true" collapsible="true" animCollapse="true" autoScroll="true" height="200" width="750" dataset="SamPeopleDisabilityDataSet" title="社会救助-残疾信息">
			<next:Columns>
				<next:RowNumberColumn width="30" />
				<next:CheckBoxColumn></next:CheckBoxColumn>
				<next:Column id="peopleId" header="成员ID" field="peopleId" width="150" hidden="true">
					<next:TextField allowBlank="false" />
				</next:Column>
				<next:Column id="disabilityType"  header="残疾类型" field="disabilityType" width="150">
					<next:ComboBox dataset="DmCjlxDataSet" displayField="text" valueField="value"  typeAhead="true" />
				</next:Column>
				<next:Column id="disabilityLevel" header="残疾等级" field="disabilityLevel" width="150">
					<next:ComboBox dataset="DmCjdjDataSet" displayField="text" valueField="value" typeAhead="true" />
				</next:Column>
			</next:Columns>
			<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="add" text="增加" handler="addYgjzCyxxCjxx" />
				<next:ToolBarItem iconCls="remove" text="删除" handler="removeYgjzCyxxCjxx" />
					<next:ToolBarItem iconCls="undo" text="取消" handler="undoCyxxCjxx" />
			</next:TopBar>
		</next:EditGridPanel>

		<next:EditGridPanel id="YgjzCyxxJyxxEditGridPanel" name="YgjzCyxxJyxxEditGridPanel" width="750" stripeRows="true" collapsible="true" animCollapse="true" autoScroll="true" height="200" dataset="SamPeopleEduDataSet" title="社会救助_成员信息_教育信息">
			<next:Columns>
				<next:RowNumberColumn width="30" />
				<next:CheckBoxColumn></next:CheckBoxColumn>
				<next:Column id="peopleId" header="成员ID" field="peopleId" width="150" hidden="true">
					<next:TextField allowBlank="false" />
				</next:Column>
				<next:Column id="regDate" header="登记时间" field="regDate" width="150">
						<next:DateField allowBlank="false" format="Y-m-d"/>
				</next:Column>
				<next:Column id="education" header="教育状况" field="education" width="150">
					<next:ComboBox dataset="DmJyzkDataSet" displayField="text" valueField="value" typeAhead="true" />
				</next:Column>
				<next:Column id="grade" header="教育状况年级" field="grade" width="150">
					<next:ComboBox dataset="DmJyzknjDataSet" displayField="text" valueField="value" typeAhead="true" />
				</next:Column>
			</next:Columns>
			<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="add" text="增加" handler="addYgjzCyxxJyxx" />
				<next:ToolBarItem iconCls="remove" text="删除" handler="removeYgjzCyxxJyxx" />
				<next:ToolBarItem xtype="tbseparator" />
				<next:ToolBarItem iconCls="undo" text="取消" handler="undoCyxxJyxx" />
			</next:TopBar>
			<next:BottomBar>
				<next:PagingToolBar dataset="SamPeopleEduDataSet" />
			</next:BottomBar>
		</next:EditGridPanel>

		<next:EditGridPanel id="YgjzCyxxHbxxEditGridPanel" name="YgjzCyxxHbxxEditGridPanel" width="750" stripeRows="true" height="200" collapsible="true" animCollapse="true" autoScroll="true" dataset="SamPeopleDiseaseDataSet" title="社会救助_成员信息_患病信息">
			<next:Columns>
				<next:RowNumberColumn width="30" />
				<next:CheckBoxColumn></next:CheckBoxColumn>
				<next:Column id="peopleId" header="成员ID" field="peopleId" width="150" hidden="true">
					<next:TextField allowBlank="false" />
				</next:Column>
				<next:Column id="diseaseDate" header="患病时间" field="diseaseDate" width="150">
					<next:DateField allowBlank="false" format="Y-m-d"/>
				</next:Column>
				<next:Column id="diseaseType" header="患病种类" field="diseaseType" width="150">
					<next:ComboBox dataset="DmHbzlDataSet" displayField="text" valueField="value" typeAhead="true" />
				</next:Column>
				<next:Column id="costMon" header="医疗支出_金额" field="costMon" width="150">
					<next:ComboBox dataset="DmYlzcDataSet" displayField="text" valueField="value" typeAhead="true" />
				</next:Column>
			</next:Columns>
			<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="add" text="增加" handler="addYgjzCyxxHbxx" />
				<next:ToolBarItem iconCls="remove" text="删除" handler="removeYgjzCyxxHbxx" />
				<next:ToolBarItem xtype="tbseparator" />
				<next:ToolBarItem iconCls="undo" text="取消" handler="undoCyxxHbxx" />
			</next:TopBar>
			<next:BottomBar>
				<next:PagingToolBar dataset="SamPeopleDiseaseDataSet" />
			</next:BottomBar>
		</next:EditGridPanel>

		<next:EditGridPanel id="YgjzCyxxSgxxEditGridPanel" name="YgjzCyxxSgxxEditGridPanel" width="750" stripeRows="true" height="200" collapsible="true" animCollapse="true" autoScroll="true" dataset="SamPeopleAccidentDataSet" title="社会救助_成员信息_事故信息">
			<next:Columns>
				<next:RowNumberColumn width="30" />
				<next:CheckBoxColumn></next:CheckBoxColumn>
				<next:Column id="peopleId" header="成员ID" field="peopleId" width="150" hidden="true">
					<next:TextField allowBlank="false" />
				</next:Column>
				<next:Column id="accidentDate" header="发生时间" field="accidentDate" width="150">
					<next:DateField allowBlank="false" format="Y-m-d"/>
				</next:Column>
				<next:Column id="accidentType" header="事故种类" field="accidentType" width="150">
					<next:ComboBox dataset="DmSgzlDataSet" displayField="text" valueField="value" typeAhead="true" />
				</next:Column>
				<next:Column id="lossMon" header="事故损失_金额" field="lossMon" width="150">
					<next:ComboBox dataset="DmSgssDataSet" displayField="text" valueField="value" typeAhead="true" />
				</next:Column>
			</next:Columns>
			<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="add" text="增加" handler="addYgjzCyxxSgxx" />
				<next:ToolBarItem iconCls="remove" text="删除" handler="removeYgjzCyxxSgxx" />
				<next:ToolBarItem xtype="tbseparator" />
				<next:ToolBarItem iconCls="undo" text="取消" handler="undoCyxxSgxx" />
			</next:TopBar>
			<next:BottomBar>
				<next:PagingToolBar dataset="SamPeopleAccidentDataSet" />
			</next:BottomBar>
		</next:EditGridPanel>

	</next:AnchorLayout>
	<next:Buttons>
		<next:ToolButton text="确认" handler="confirm"></next:ToolButton>
		<next:ToolButton text="关闭" handler="hide"></next:ToolButton>
	</next:Buttons>
</next:Window>
</body>
</html>
