<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.bsp.id.util.MaxValueUtil"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%
	String jtid = MaxValueUtil.nextStringValue("JTID");
	String cyid = MaxValueUtil.nextStringValue("CYID");
	String organArea = BspUtil.getCorpOrgan().getOrganCode();

%>
<html>
<head>
<title>社会救助_家庭信息</title>
<next:ScriptManager />
<script>
			var idField='<%=request.getParameter("dataBean")%>';
			var method='<%= request.getParameter("method")%>';
			var organArea='<%= organArea%>';
</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsPhoto.js")%>'></script>
<script type="text/javascript" src="samFamilyInsert.js"></script>
<script type="text/javascript" src="IDCard.js"></script>
<script type="text/javascript" src="FamilyComm.js"></script>
</head>

<body>
<model:datasets>
	<model:dataset id="BaseinfoFamilyDS"  cmd="com.inspur.cams.drel.sam.cmd.SamBaseFamilyQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoFamily"></model:record>
	</model:dataset>
	<!-- 家庭户主身份证重复信息 -->
	<model:dataset id="BaseinfoFamilyDS1"  cmd="com.inspur.cams.drel.sam.cmd.SamBaseFamilyQueryCmd" >
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoFamily"></model:record>
	</model:dataset>
	<!-- 家庭成员信息 -->
	<model:dataset id="BaseinfoPeopleDS2"  cmd="com.inspur.cams.drel.sam.cmd.SamBasePeopleCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople"></model:record>
	</model:dataset>
	<!-- 救助类型 -->
	<model:dataset id="assistanceTypeDS"  cmd="com.inspur.cams.drel.sam.cmd.SamFamilyAssistanceCmd">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamFamilyAssistance"></model:record>
	</model:dataset>
	<!-- 住房状况类型 -->
	<model:dataset id="DmZfzklxDataSet" cmd="com.inspur.cams.drel.dicm.cmd.DmQueryCommand" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.drel.dicm.data.DmBean"></model:record>
		<model:params>
			<model:param name="tableName" value='DM_ZFZKLX'></model:param>
		</model:params>
	</model:dataset>
	<!-- 房屋结构类型 -->
	<model:dataset id="DmFwjgDataSet" cmd="com.inspur.cams.drel.dicm.cmd.DmQueryCommand" global="true" autoLoad="false">
		<model:record fromBean="com.inspur.cams.drel.dicm.data.DmBean"></model:record>
		<model:params>
			<model:param name="tableName" value='DM_FWJG'></model:param>
			<model:param name="valueField" value='FWJGDM'></model:param>
			<model:param name="textField" value='FWJGMC'></model:param>
		</model:params>
	</model:dataset>

	<!-- 救助类型 -->
	<model:dataset id="DmJzlxDataSet" cmd="com.inspur.cams.drel.dicm.cmd.DmQueryCommand" global="true" pageSize="20" autoLoad="true">
		<model:record fromBean="com.inspur.cams.drel.dicm.data.DmBean"></model:record>
		<model:params>
			<model:param name="tableName" value='DM_JZLX'></model:param>
		</model:params>
	</model:dataset>

	<model:dataset id="jzlxDs" cmd="com.inspur.cams.drel.dicm.cmd.DmQueryCommand" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.drel.dicm.data.DmBean">
		</model:record>
		<model:params>
			<model:param name="tableName" value='DM_JZLX'></model:param>
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
	<!-- 供养方式-->
	<model:dataset id="supportWayDS"  enumName="SAM.SUPPORT_WAY"  autoLoad="true" global="true"></model:dataset>
	<!-- 开户银行-->
	<model:dataset id="bankCodeDS"  enumName="BANK.CODE"  autoLoad="true" global="true"></model:dataset>
	<!-- 人员照片 -->
	<model:dataset id="comPhotoDs"
		cmd="com.inspur.cams.comm.comphoto.cmd.ComPhotoQueryCmd">
		<model:record
			fromBean="com.inspur.cams.comm.comphoto.data.ComPhoto"></model:record>
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

</model:datasets>

<next:Panel width="98%" >
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存并录入成员" handler="saveClick" />
		<next:ToolBarItem iconCls="undo" text="返回" handler="returnClick" />
	</next:TopBar>
	<next:TabPanel id="tabPanels" height="1150" width="100%" activeTab="0">
		<next:Tabs>
			<next:Panel title="困难户家庭信息" name="阳光基本信息"  autoHeight="true" height="99.9%">
				<next:AnchorLayout>
					<next:Panel title="家庭基本信息" name="tabPanels2" autoHeight="true" collapsible="true"  >
						<next:Html>
						<form id="YgjzJtxxForm" method="post" dataset="BaseinfoFamilyDS" onsubmit="return false" class="L5form" autoHeight="true">
							<table border="0" style="width:100%;word-wrap:break-word;overflow:hidden;">
								<tr>
									<td class="FieldLabel"  width="10%">户主姓名：</td>
									<td class="FieldInput"  width="20%"><input type="text" id="familyName" name="户主姓名" maxlength="25" field="familyName" onchange="checkCN('familyName','familyCardNo','户主姓名');changeCyHzxm();" style="width:60%"/><font color="red">*</font></td>
									<td class="FieldLabel"  width="10%">身份证号：</td>
									<td class="FieldInput"  width="20%"><input type="text" id="familyCardNo"  name="身份证号" maxlength="18" onchange="checkIDCard('familyCardNo','户主身份证');checkIfRepeat();changeCySfzh();"   style="width:60%" field="familyCardNo" /><font color="red">*</font><br>若该人无身份证,<a href="#" onClick="getMaxCode('familyCardNo');">请点击此处获取编号</a></td>
									<td class="FieldLabel"  width="15%">人口数量：</td>
									<td class="FieldInput"  width="20%"><span onmousemove="this.setCapture();" onmouseout="this.releaseCapture();">
									<input type="text" style="width: 20%" name="peopleNum" maxlength="2" field="peopleNum" readonly="true"/></span>&nbsp;&nbsp;<font color=green>自动生成</font></td>
								</tr>
								<tr >

									<td class="FieldLabel"  width="10%">地址_镇：</td>
									<td class="FieldInput"  width="10%"> <select id="town" name="镇" field="town" onchange="setXzqhVillage()" style="width:60%">
																					<option dataset="DmXzqhDataSetStreet"></option> </select><font color="red">*</font></td>
									<td class="FieldLabel"  width="10%">地址_村(居)：</td>
									<td class="FieldInput"  width="15%"> <select id="village" name="村(居)" style="width:60%" field="village"> <option dataset="DmXzqhDataSetVillage"></option> </select></td>


									<td class="FieldLabel"  nowrap >地址：</td>
									<td class="FieldInput"  ><input type="text" name="address" maxlength="50" field="address" style="width:60%"/></td>
								</tr>
								<tr>
									<td class="FieldLabel"  >宅电：</td>
									<td class="FieldInput"  ><input type="text" id="familyPhone" name="familyPhone" maxlength="20" onchange="checkDhhm();" field="familyPhone" style="width:60%"/></td>
									<td class="FieldLabel"  >手机：</td>
									<td class="FieldInput"  ><input type="text" id="familyMobile" name="familyMobile" maxlength="20" onchange="checkSjhm();" style="width:60%" field="familyMobile" /></td>
									<td class="FieldLabel"  nowrap >其他联系方式：</td>
									<td class="FieldInput"  ><input type="text" name="familyOtherPhone" maxlength="25" field="familyOtherPhone" style="width:60%"/></td>
								</tr>
								<tr >
									<td class="FieldLabel"   nowrap="nowrap"  >家庭年总收入：<br>(单位：元)&nbsp</td>
									<td class="FieldInput"  ><input type="text" id="yearIncome" name="家庭年总收入" maxlength="9" field="yearIncome"  onchange=" CheckTxt('yearIncome','家庭年总收入');" style="width:60%"/><font color="red">*</font></td>
									<td class="FieldLabel"  nowrap="nowrap" >家庭年人均收入：<br>(单位：元)&nbsp</td>
									<td class="FieldInput"  colspan="1"><span onmousemove="this.setCapture();" onmouseout="this.releaseCapture();">
									<input type="text" name="yearAverageIncome" maxlength="9" style="width:60%" field="yearAverageIncome" readonly="true"/></span>&nbsp;<font color=green>自动生成</font></td>
									<td class="FieldLabel"  rowspan="4">照片:</td>
		   						    <td class="FieldInput" nowrap  rowspan="4">
		   						       <img name="PHOTO_IMG" width=150 height=200
                                         src="";
                                         onerror="javascript:this.src='<%=SkinUtils.getImage(request,"default.jpg")%>'" alt="暂无图片"
                                         ondblclick="editPhoto(1,'photoTemp','PHOTO_IMG')"
                                        />
                                        <input type="hidden" name="photoTemp" id="photoTemp" />
		   						    </td>
								</tr>
								<tr>
									<td class="FieldLabel"  >住房状况类型：</td>
									<td class="FieldInput" ><select id="houseStatus" name="住房状况类型" field="houseStatus" onchange="selectStructure()" style="width:60%"> <option dataset="DmZfzklxDataSet"></option> </select><font color="red">*</font></td>
									<td class="FieldLabel"  id="fwzk">房屋结构：</td>
									<td class="FieldInput"  ><select  name="buildingStructure" field="buildingStructure" style="width:60%"> <option dataset="DmFwjgDataSet"></option> </select></td>
								</tr>
								<tr>
									<td class="FieldLabel"  nowrap="nowrap" > 建筑面积：<br>(单位：平方米)&nbsp</td>
									<td class="FieldInput"  ><input type="text" name="buildArea" maxlength="6"  field="buildArea" onchange=" CheckTxt('buildArea','建筑面积');" style="width:60%"/></td>
									<td class="FieldLabel"  nowrap > 人均建筑面积：<br>(单位：平方米) &nbsp</td>
									<td class="FieldInput"  ><span onmousemove="this.setCapture();" onmouseout="this.releaseCapture();">
									<input type="text" name="buildAverageArea" maxlength="6" style="width:60%" field="buildAverageArea" readonly="true"/></span>&nbsp;<font color=green>自动生成</font></td>

								</tr>
							    <tr>
									<td class="FieldLabel">备注：</td>
									<td colspan="3" class="FieldInput"><textarea name="note" field="note"  cols="80" rows="2" style="width:95%;height:95%"/></textarea></td>
								</tr>
								<input type="hidden" name="familyId" id="familyId" value="<%=jtid%>" />
								<input type="hidden" name="peopleId" id="peopleId" value="<%=cyid%>" />
								<input type="hidden" name="province" field="province" />
								<input type="hidden" name="city" field="city" />
								<input type="hidden" name="county" field="county" />
								<input type="hidden" name="monthIncome" field="monthIncome" />
								<input type="hidden" name="monthAverageIncome" field="monthAverageIncome" />
								<!--家庭状态标志  -->
								<input type="hidden" name="familyStateFlag" field="familyStateFlag" />
								<!--录入人姓名  -->
								<input type="hidden" name="regPeople" field="regPeople" />
								<!--录入人ID  -->
								<input type="hidden" name="regId" field="regId" />
								<!--录入单位名称  -->
								<input type="hidden" name="regOrgName" field="regOrgName" />
								<!--录入单位区划 -->
								<input type="hidden" name="regOrgArea" field="regOrgArea" />
								<!--录入单位ID -->
								<input type="hidden" name="regOrg" field="regOrg" />
								<!--录入时间 -->
								<input type="hidden" name="regTime" field="regTime"/>
								<!--修改人姓名 -->
								<input type="hidden" name="modPeople" field="modPeople"/>
								<!--修改人ID -->
								<input type="hidden" name="modId" field="modId"/>
								<!--修改单位名称 -->
								<input type="hidden" name="modOrgName" field="modOrgName"/>
								<!--修改单位区划 -->
								<input type="hidden" name="modOrgArea" field="modOrgArea"/>
								<!--修改单位ID -->
								<input type="hidden" name="modOrg" field="modOrg"/>
								<input type="hidden" name="modTime" field="modTime"/>
								<input type="hidden" name="checkPeople" field="checkPeople"/>
								<input type="hidden" name="checkId" field="checkId"/>
								<input type="hidden" name="checkOrgArea" field="checkOrgArea"/>
								<input type="hidden" name="checkTime" field="checkTime"/>
								<input type="hidden" name="isDel" field="isDel"/>
								<input type="hidden" name="curActivity" field="curActivity" value="ACCEPT"/>
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
						<td class="FieldInput" width="18%"><input type="text" name="signDate" id="signDate"  style="width:85%" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly"/></td>
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
						<td class="FieldInput" width="16%"><input type="text" name="assistanceMon" id="assistanceMon" onchange=" CheckTxt('assistanceMon','户月救助金额');"  style="width:95%" /></td>
						<td class="FieldLabel" width="16%"><label>其中分类施保金额（元）：</label></td>
						<td class="FieldInput" colspan='3'><input type="text" name="assistanceClassMon" id="assistanceClassMon" onchange=" CheckTxt('assistanceClassMon','分类施保金额');" style="width:28%" /></td>
					</tr>

					</table>

				   <table id="isCountry" width="100%"  style="display:none">

				    <tr><td class="FieldInput" colspan="6">农村低保</td></tr>
					<tr>
						<td class="FieldLabel" width="16%"><label>户月救助金额（元）：</label></td>
						<td class="FieldInput" width="16%"><input type="text" name="nassistanceMon" id="nassistanceMon"  onchange=" CheckTxt('nassistanceMon','户月救助金额');" style="width:95%" /></td>
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
	       <next:EditGridPanel height="220" id="YgjzJtxxZrzhEditGridPanel" width="98%" autoWidth="true" collapsible="true" animCollapse="true" autoScroll="true" name="YgjzJtxxZrzhEditGridPanel" stripeRows="true" dataset="SamFamilyCalamityDataSet" title="社会救助_家庭信息_自然灾害">
						<next:Columns>
							<next:RowNumberColumn width="30" />
							<next:CheckBoxColumn></next:CheckBoxColumn>
							<next:Column id="familyId" header="家庭ID" field="familyId" width="150" hidden="true">
								<next:TextField blankText="true" />
							</next:Column>
							<next:Column id="calamityDate" header="受灾时间"  field="calamityDate" width="150">
								<next:DateField allowBlank="false" format="Y-m-d"/>
							</next:Column>
							<next:Column id="calamityType" header="灾害种类" field="calamityType" width="150">
								<next:ComboBox dataset="DmZhzlDataSet" displayField="text" valueField="value" typeAhead="true" />
							</next:Column>

							<next:Column id="lossMon" header="灾害损失_金额" field="lossMon" width="150">
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

			<next:Panel title="户主基本信息" id = "anchor-div"  name="anchor-div" height="1100" >
			  <next:AnchorLayout>
				<next:Panel title="基本信息" collapsible="true" name="tabPanels3" animCollapse="true"   width="100%"  autoScroll="true" >
			     <next:Html>
				   <form id="YgjzJtxxCyxxForm" name="YgjzJtxxCyxxForm" method="post" dataset="BaseinfoPeopleDS2" onsubmit="return false" class="L5form">
				     <table border="0" width="100%">
							<tr>
								<td class="FieldLabel" style="width: 10%">姓名：</td>
								<td class="FieldInput" style="width: 20%"><input type="text" id="name" name="姓名" field="name"  readonly="readonly" onchange="checkCN('name','idCard','户主姓名');"  style="width:60%"/><font color="red">*</font></td>
								<td class="FieldLabel" style="width: 10%">身份证号：</td>
								<td class="FieldInput" style="width: 20%"><input type="text" readonly="readonly" onchange="checkIDCard('idCard','户主身份证');getBirthdayByIdCard();"   id="idCard" style="width:60%" name="身份证号" field="idCard" /><font color="red">*</font></td>
					     		<td class="FieldLabel" width="10%" rowspan="5">照片:</td>
		   						<td nowrap colspan="1" rowspan="5">
		   						  <img name="PHOTO_PEOPLE" width=150 height=200
                                     src="";
                                     onerror="javascript:this.src='<%=SkinUtils.getImage(request,"default.jpg")%>'" alt="暂无图片"
                                     ondblclick="editPhoto(1,'photoPeople','PHOTO_PEOPLE')"
                                   />
		   						</td>
					     	</tr>
							<tr>
								<td class="FieldLabel" style="width: 10%">户主关系：</td>
								<td class="FieldInput" style="width: 20%"><select name="户主关系" disabled="disabled" field="relationshipType" style="width:60%"><option dataset="DmHzgxDataSet"></option></select><font color="red">*</font></td>
								<td class="FieldLabel" style="width: 10%">性别：</td>
								<td class="FieldInput" style="width: 20%"><select name="性别" field="sex" style="width:60%"><option dataset="DmXbDataSet" ></option></select><font color="red">*</font></td>
				            </tr>
							<tr>
							     <td class="FieldLabel" style="width: 10%">出生日期：</td>
								<td class="FieldInput" style="width: 20%"><input id="birthday" type="text" maxlength="8"  style="width:60%" name="出生日期" field="birthday" format="Ymd" readonly="readonly"  onclick="LoushangDate(this)" /><font color="red">*</font></td>
								<td class="FieldLabel" style="width: 10%">户籍性质：</td>
								<td class="FieldInput" style="width: 20%"><select name="户籍性质" field="domicileType" style="width:60%"><option dataset="DmHjxzDataSet"></option></select><font color="red">*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width: 10%">民族：</td>
								<td class="FieldInput" style="width: 20%"><select id="nation" name="民族" field="nation" style="width:60%"><option dataset="DmMzDataSet"></option></select><font color="red">*</font></td>
								<td class="FieldLabel" style="width: 10%">婚姻状况：</td>
								<td class="FieldInput" style="width: 20%"><select name="婚姻状况" style="width:60%"  field="marriageCode"><option dataset="DmHyzkDataSet"></option></select><font color="red">*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width: 10%">手机：</td>
								<td class="FieldInput" style="width: 20%"><input type="text" name="telMobile" field="telMobile" onchange="checkWinSjhm();" style="width:60%"/></td>
								<td class="FieldLabel" nowrap="nowrap" style="width: 10%">其他联系方式：</td>
								<td class="FieldInput" style="width: 20%"><input type="text" name="telOther" field="telOther"  style="width:60%"/></td>

						    </tr>
							<tr>
							    <td class="FieldLabel" style="width: 10%">年收入：</td>
								<td class="FieldInput" style="width: 20%"><input type="text" name="incomeYear" field="incomeYear" maxlength="8" onchange=" CheckTxt('incomeYear','年收入');" style="width:60%"/></td>
								<td class="FieldLabel" nowrap="nowrap"  style="width: 10%">就业状况：</td>
								<td class="FieldInput" style="width: 20%"><select name="就业状况" field="employmentCode" style="width:60%"><option dataset="DmZyDataSet"></option></select><font color="red">*</font></td>
						   		<td class="FieldLabel" style="width: 10%">医疗状况：</td>
								<td class="FieldInput" style="width: 20%"><select name="医疗状况"  style="width:60%" field="safeguardType"><option dataset="DmYlzkDataSet"></option></select><font color="red">*</font></td>

						   	</tr>
							<tr>
								<td class="FieldLabel" nowrap="nowrap"  style="width: 10%">工作单位名称：</td>
								<td class="FieldInput" style="width: 20%"><input type="text" name="workUnitName"  style="width:60%" field="workUnitName"  maxlength="25"/></td>
								<td class="FieldLabel" nowrap="nowrap"  style="width: 10%">工作单位电话：</td>
								<td class="FieldInput" style="width: 20%"><input type="text" name="workUnitTel" field="workUnitTel" maxlength="20" onchange="checkWinDhhm();" style="width:60%"/></td>
								<td class="FieldLabel" nowrap="nowrap"  style="width: 10%">工作单位地址：</td>
								<td class="FieldInput" style="width: 20%"><input type="text" name="workUnitAdd" field="workUnitAdd" maxlength="100" style="width:60%"/></td>
							</tr>
					<input type="hidden" name="incomeMonth" field="incomeMonth">
				</table>
				</form>
			</next:Html>
		</next:Panel>

        <next:EditGridPanel id="YgjzCyxxCjxxEditGridPanel" name="YgjzCyxxCjxxEditGridPanel" stripeRows="true" collapsible="true" autoScroll="true"  autoWidth="true" animCollapse="true"  height="200" width="98%" dataset="SamPeopleDisabilityDataSet" title="社会救助-残疾信息">
			<next:Columns>
				<next:RowNumberColumn width="30" />
				<next:CheckBoxColumn></next:CheckBoxColumn>
				<next:Column id="peopleId" header="成员ID" field="peopleId" width="150" hidden="true">
					<next:TextField allowBlank="false" />
				</next:Column>
				<next:Column id="disabilityType" header="残疾类型" field="disabilityType" width="150">
					<next:ComboBox dataset="DmCjlxDataSet" displayField="text" valueField="value" typeAhead="true" />
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

        <next:EditGridPanel id="YgjzCyxxJyxxEditGridPanel" name="YgjzCyxxJyxxEditGridPanel" width="98%" stripeRows="true" autoScroll="true"  collapsible="true" animCollapse="true"   height="200" dataset="SamPeopleEduDataSet" title="社会救助_成员信息_教育信息">
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

        <next:EditGridPanel id="YgjzCyxxHbxxEditGridPanel" name="YgjzCyxxHbxxEditGridPanel" width="98%" stripeRows="true" autoScroll="true"  height="200" collapsible="true" animCollapse="true" autoScroll="true" dataset="SamPeopleDiseaseDataSet" title="社会救助_成员信息_患病信息">
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

        <next:EditGridPanel id="YgjzCyxxSgxxEditGridPanel" name="YgjzCyxxSgxxEditGridPanel" width="98%" stripeRows="true" autoScroll="true"  height="200" collapsible="true" animCollapse="true" autoScroll="true" dataset="SamPeopleAccidentDataSet" title="社会救助_成员信息_事故信息">
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
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
</body>
</html>
