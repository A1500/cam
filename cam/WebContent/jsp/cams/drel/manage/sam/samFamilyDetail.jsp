<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.bsp.id.util.MaxValueUtil"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%
	String organArea = BspUtil.getCorpOrgan().getOrganCode();
%>
<html>
<head>
<title>社会救助_家庭信息</title>
<next:ScriptManager />
<script>
			var idField='<%=request.getParameter("familyId")%>';
			var method='<%= request.getParameter("method")%>';
			var photoId='<%=request.getParameter("photoId")%>';
			var organArea='<%= organArea%>';
</script>
<script type="text/javascript">
function backToList(){
	var url='jsp/cams/drel/manage/sam/samFamilyList.jsp';
	var text = '困难户家庭登记';
	L5.forward(url,text);
}
</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src="samFamilyDetail.js"></script>
</head>
<body>
<model:datasets>

	<!-- 家庭信息 -->
	<model:dataset id="YgjzJtxxDataSet" cmd="com.inspur.cams.drel.sam.cmd.SamBaseFamilyQueryCmd" >
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoFamily"></model:record>
	</model:dataset>
	<!-- 家庭成员信息 -->
	<model:dataset id="YgjzJtxxCyxxDataSet"  cmd="com.inspur.cams.drel.sam.cmd.SamBasePeopleCmd" >
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople"></model:record>
	</model:dataset>
	<!-- 救助类型 -->
	<model:dataset id="assistanceTypeDS"  cmd="com.inspur.cams.drel.sam.cmd.SamFamilyAssistanceCmd">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamFamilyAssistance"></model:record>
	</model:dataset>
	<!-- 家庭成员信息 -->
	<model:dataset id="YgjzJtxxCyxxDataSet2"  cmd="com.inspur.cams.drel.sam.cmd.SamBasePeopleCmd" >
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople"></model:record>
	</model:dataset>

	<!-- 住房状况类型 -->
	<model:dataset id="DmZfzklxDataSet" cmd="com.inspur.cams.drel.dicm.cmd.DmQueryCommand" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.drel.dicm.data.DmBean"></model:record>
		<model:params>
			<model:param name="tableName" value='DM_ZFZKLX'></model:param>
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
	<model:dataset id="DmJzlxDataSet" 	cmd="com.inspur.cams.drel.dicm.cmd.DmQueryCommand" global="true" 	autoLoad="true">
		<model:record fromBean="com.inspur.cams.drel.dicm.data.DmBean"></model:record>
		<model:params>
			<model:param name="tableName" value='DM_JZLX'></model:param>
			<model:param name="valueField" value='JZLXDM'></model:param>
			<model:param name="textField" value='JZLXMC'></model:param>
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
	<!--供养方式-->
	<model:dataset id="supportWayDS"  enumName="SAM.SUPPORT_WAY"  autoLoad="true" global="true"></model:dataset>
    <!-- 开户银行-->
	<model:dataset id="bankCodeDS"  enumName="BANK.CODE"  autoLoad="true" global="true"></model:dataset>
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


<next:TabPanel id="tabPanels"  height="950" width="98%" activeTab="0">
		<next:Tabs>
			<next:Panel title="困难户家庭信息" name="阳光基本信息" autoHeight="true" autoWidth="true">
			<next:TopBar>
				<next:ToolBarItem symbol="->" />
				<next:ToolBarItem iconCls="undo" text="返回" handler="backToList" />
			</next:TopBar>
				<next:AnchorLayout>
					<next:Panel title="基本信息" autoHeight="true" collapsible="true" animCollapse="true"  autoWidth="true">
						<next:Html>
							<form id="YgjzJtxxForm" method="post" dataset="YgjzJtxxDataSet" onsubmit="return false"   class="L5form">
							<table border="0" style="width:100%;word-wrap:break-word;overflow:hidden;">
								<tr>
									<td class="FieldLabel" nowrap="nowrap"  style="width: 10%">户主姓名:</td>
									<td class="FieldInput" style="width: 20%"><label   name="familyName" id="familyName" field="familyName" ></label></td>
									<td class="FieldLabel" nowrap="nowrap"  style="width: 10%">身份证号:</td>
									<td class="FieldInput" style="width: 20%"><label id="familyCardNo" name="familyCardNo" field="familyCardNo" maxlength="18" size="18" style="width:150px"/></td>
									<td class="FieldLabel" style="width: 10%">人口数量:</td>
									<td class="FieldInput" style="width: 20%"><label id="peopleNum" name="peopleNum"  field="peopleNum" readOnly="true" /></td>
 								</tr>
								<tr>
									<td class="FieldLabel" nowrap="nowrap"  style="width: 10%">地址_镇:</td>
									<td class="FieldInput" style="width: 20%">
									<span onmousemove="this.setCapture();" onmouseout="this.releaseCapture();">
								    <select id="town"  name="town" field="town" onchange="setXzqhVillage()" style="width:60%" >
										<option dataset="DmXzqhDataSetStreet"></option>
									</select></span>
									</td>
									<td class="FieldLabel" nowrap="nowrap" style="width: 10%">地址_村（居）:</td>
									<td class="FieldInput" style="width: 20%">
									<span onmousemove="this.setCapture();" onmouseout="this.releaseCapture();">
										<select name="village"  style="width:60%" field="village" >
										<option dataset="DmXzqhDataSetVillage"></option>
									</select></span>
									</td>
									<td class="FieldLabel" nowrap="nowrap"  style="width: 10%">家庭住址:</td>
									<td class="FieldInput" style="width: 20%"><label name="address" field="address" /></td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width: 10%">宅电:</td>
									<td class="FieldInput" style="width: 20%"><label name="familyPhone" field="familyPhone" /></td>
									<td class="FieldLabel" style="width: 10%">手机:</td>
									<td class="FieldInput" style="width: 20%"><label name="familyMobile"  style="width:150px" field="familyMobile" /></td>
									<td class="FieldLabel" nowrap="nowrap"  style="width: 10%">其他联系方式:</td>
									<td class="FieldInput" style="width: 20%"><label name="familyOtherPhone" field="familyOtherPhone" /></td>
								</tr>
								<tr>
									<td class="FieldLabel" nowrap="nowrap" style="width: 10%">家庭年总收入:</td>
									<td class="FieldInput" style="width: 20%"><label name="yearIncome" field="yearIncome" /><font color="red">*</font></td>
									<td class="FieldLabel" nowrap="nowrap"  style="width: 10%">家庭年人均收入:</td>
									<td  class="FieldInput" ><label name="yearAverageIncome"  style="width:150px" field="yearAverageIncome" readonly="true"/>&nbsp;<font color=green>自动生成</font></td>
									<td class="FieldLabel" width="10%" rowspan="4">照片:</td>
		   						    <td nowrap colspan="1" rowspan="4">
			   						    <img id="photoImg" name="PHOTO_IMG" width=150 height=200
	                                         src="";
	                                         onerror="javascript:this.src='<%=SkinUtils.getImage(request,"default.jpg")%>'" alt="暂无图片"
	                                        />
	                                        <input type="hidden" name="photoTemp" id="photoTemp" />
		   						    </td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width: 10%">住房状况类型:</td>
									<td class="FieldInput" style="width: 20%">
										  <label name="houseStatus" field="houseStatus" dataset="DmZfzklxDataSet">
									</td>
									<td id="fwzk" class="FieldLabel" style="width: 10%">房屋结构:</td>
									<td  class="FieldInput" >
									 <label name="buildingStructure" field="buildingStructure" dataset="DmFwjgDataSet">
									</td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width: 10%">房屋建筑面积:</td>
									<td class="FieldInput" style="width: 20%"><label id="buildArea" name="buildArea" field="buildArea" /></td>
									<td class="FieldLabel" style="width: 10%">人均建筑面积:</td>
									<td class="FieldInput"  ><label name="buildAverageArea" field="buildAverageArea"  style="width:150px" readonly="true"/>&nbsp;<font color=green>自动生成</font></td>
								</tr>
								<tr>
									<td class="FieldLabel">备注：</td>
									<td colspan="3" class="FieldInput"><textarea name="note" field="note" disabled="disabled" rows="3" style="width:90%;height:95%"/></textarea></td>
								</tr>
								<input type="hidden" name="familyId" field="familyId">
								<input type="hidden" name="photoId" field="photoId">
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
							<input type="checkbox"  onclick="setCityMi(this)" id="cityMi" name="cityMi" disabled="disabled" />
							<label>城市低保</label>
							<input type="checkbox"  onclick="setCountryMi(this)" id="countryMi" name="countryMi" disabled="disabled" />
							<label>农村低保</label>
							<input type="checkbox"  onclick="setFiveMi(this)" id="fiveMi" name="fiveMi" disabled="disabled" />
							<label>农村五保</label>
							<input type="checkbox"  onclick="setGiveMi(this)" id="giveMi" name="giveMi" disabled="disabled" />
							<label>优抚</label>
							<input type="checkbox"  onclick="setHandicapped(this)" id="handicapped" name="handicapped" disabled="disabled" />
							<label>残疾人</label>
							<input type="checkbox"  onclick="setPmother(this)" id="pmother" name="pmother" disabled="disabled" />
							<label>单亲特困母亲</label>
							<input type="checkbox"  onclick="setKstudent(this)" id="kstudent" name="kstudent" disabled="disabled" />
							<label>困难学生</label>
							<input type="checkbox"  onclick="setThreeNothing(this)" id="threeNothing" name="threeNothing" disabled="disabled" />
							<label>“三无”对象</label>
							<input type="checkbox"  onclick="setTemployee(this)" id="temployee" name="temployee" disabled="disabled" />
							<label>特困职工</label>
							<input type="checkbox"  onclick="setOther(this)" id="other" name="other" disabled="disabled" />
							<label>其他</label>
						</td>
					</tr>
					</table>

				   <table width="100%"   id="isDetail" style="display:none">
				  	<tr><td class="FieldInput" colspan="6">详细信息</td></tr>
					<tr>
						<td class="FieldLabel" width="16%"><label>证件号码：</label></td>
						<td class="FieldInput" width="16%"><label id="cardNo" name="cardNo" field="cardNo" /></td>
						<td class="FieldLabel" width="16%"><label>发证机关名称：</label></td>
						<td class="FieldInput" width="16%"><label id="signOrgName" name="signOrgName" field="signOrgName" /></td>
						<td class="FieldLabel" width="18%"><label>发证日期：</label></td>
						<td class="FieldInput" width="18%"><label id="signDate" name="signDate" field="signDate" /></td>
					</tr>
					<tr>
						<td class="FieldLabel" ><label>有效日期起：</label></td>
						<td class="FieldInput" ><label id="cardValidateBegin" name="cardValidateBegin" field="cardValidateBegin" /></td>
						<td class="FieldLabel" ><label>有效日期止：</label></td>
						<td class="FieldInput" ><label id="cardValidateEnd" name="cardValidateEnd" field="cardValidateEnd" /></td>
						<td class="FieldLabel" ><label>保障起始年月：</label></td>
						<td class="FieldInput" ><label id="assistanceBegin" name="assistanceBegin" field="assistanceBegin" /></td>
					</tr>
					<tr>
						<td class="FieldLabel" ><label>开户银行：</label></td>
						<td class="FieldInput" >
                          <span onmousemove="this.setCapture();" onmouseout="this.releaseCapture();">
							<select id="bank"  name="bank" field="bank"  style="width:95%" >
							 <option dataset="bankCodeDS"></option>
							</select>
                          </span>
                        </td>
						<td class="FieldLabel" ><label>开户名称：</label></td>
						<td class="FieldInput" ><label id="accountName" name="accountName" field="accountName" /></td>
						<td class="FieldLabel" ><label>银行账号：</label></td>
						<td class="FieldInput" ><label id="accountCode" name="accountCode" field="accountCode" /></td>
					</tr>

					</table>
				   <table id="isCity" width="100%" style="display:none">
				   <tr><td class="FieldInput" colspan="6">城市低保</td></tr>
					<tr >
						<td class="FieldLabel" width="16%"><label>户月救助金额（元）：</label></td>
						<td class="FieldInput" width="16%"><label id="assistanceMon" name="assistanceMon" field="assistanceMon" /></td>
						<td class="FieldLabel" width="16%"><label>其中分类施保金额（元）：</label></td>
						<td class="FieldInput" colspan='3'><label id="assistanceClassMon" name="assistanceClassMon" field="assistanceClassMon" /></td>
					</tr>

					</table>

				   <table id="isCountry" width="100%"  style="display:none">
				    <tr><td class="FieldInput" colspan="6">农村低保</td></tr>

					<tr>
						<td class="FieldLabel" width="16%"><label>户月救助金额（元）：</label></td>
						<td class="FieldInput" width="16%"><label id="nassistanceMon" name="nassistanceMon" field="nassistanceMon" /></td>
						<td class="FieldLabel" width="16%"><label>其中分类施保金额（元）：</label></td>
						<td class="FieldInput" colspan='3'><label id="nassistanceClassMon" name="nassistanceClassMon" field="nassistanceClassMon" /></td>
					</tr>

					</table>

				   <table id="isFive" width="100%"  style="display:none">
				    <tr><td class="FieldInput" colspan="6">农村五保</td></tr>
					<tr>
						<td class="FieldLabel" width="16%"><label>供养方式：</label></td>
						<td class="FieldInput" width="16%">
						  <span onmousemove="this.setCapture();" onmouseout="this.releaseCapture();">
							<select id="supportWay"  name="supportWay" field="supportWay"  style="width:95%" >
							 <option dataset="supportWayDS"></option>
							</select>
						  </span>
						</td>
						<td class="FieldLabel" width="16%"><label>户月救助金额（元）：</label></td>
						<td class="FieldInput" colspan='3'><label id="cassistanceMon" name="cassistanceMon" field="cassistanceMon" /></td>
					</tr>

					</table>
				</form>
			</next:Html>
			</next:Panel>

			<next:GridPanel id="YgjzJtxxZrzhEditGridPanel" name="YgjzJtxxZrzhGridPanel" width="100%" stripeRows="true" height="300" dataset="SamFamilyCalamityDataSet" title="自然灾害">
							<next:Columns>
								<next:RowNumberColumn width="30" />
								<next:Column id="calamityDate" header="受灾时间" field="calamityDate" width="150" align="center">
								     <next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="calamityType" header="灾害种类" field="calamityType" width="150" align="center">
								    <next:ComboBox dataset="DmZhzlDataSet" displayField="text" valueField="value" typeAhead="true" />
								</next:Column>
								<next:Column id="lossMon" header="灾害损失" field="lossMon" width="150" align="center">
								    <next:ComboBox dataset="DmZhssjeDataSet" displayField="text" valueField="value" typeAhead="true" />
								</next:Column>
							</next:Columns>
							<next:BottomBar><next:PagingToolBar dataset="SamFamilyCalamityDataSet" /></next:BottomBar>
			</next:GridPanel>

				</next:AnchorLayout>
			</next:Panel>
			<next:Panel title="家庭成员基本信息" name="anchor-div" height="100%">
				<next:AnchorLayout>
					<next:GridPanel id="YgjzJtxxCyxxEditGridPanel" name="YgjzJtxxCyxxEditGridPanel" width="98%" stripeRows="true" height="950" dataset="YgjzJtxxCyxxDataSet" title="社会救助_家庭信息_成员信息">
						<next:TopBar>
							<next:ToolBarItem symbol="->" ></next:ToolBarItem>
							<next:ToolBarItem text="明细" iconCls="detail" handler="jtxxCyxxDetail" ></next:ToolBarItem>
						</next:TopBar>
						<next:Columns>
							<next:RowNumberColumn width="30" />
							<next:RadioBoxColumn></next:RadioBoxColumn>
							<next:Column id="peopleId" header="成员ID" field="peopleId" hidden="true" width="80">
								<next:TextField allowBlank="false" />
							</next:Column>
							<next:Column id="familyId" header="家庭ID" field="familyId" hidden="true" align="center">
								<next:TextField allowBlank="false" editable="false" />
							</next:Column>
							<next:Column header="与户主关系" field="relationshipType" width="100" dataset="DmHzgxDataSet"  align="center"/>
							<next:Column id="name" header="姓名" field="name" width="100" align="center">
								<next:TextField />
							</next:Column>
							<next:Column id="idCard" header="身份证号" field="idCard" width="140" align="center">
								<next:TextField />
							</next:Column>
							<next:Column id="sex" header="性别" field="sex" width="100" align="center" dataset="DmXbDataSet">
								<next:TextField />
							</next:Column>
							<next:Column id="regPeople" header="录入人" field="regPeople" width="100" align="center">
								<next:TextField />
							</next:Column>
							<next:Column id="regTime" header="录入时间" field="regTime" width="140" align="center">
								<next:TextField />
							</next:Column>
							<next:Column id="photocId" header="照片" field="photoId" width="140" hidden="true" align="center">
								<next:TextField />
							</next:Column>
						</next:Columns>
					</next:GridPanel>
				</next:AnchorLayout>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>

<next:Window id="people_win" title="家庭成员信息明细" width="780" height="480" closeAction="hide" autoScroll="true" >
        <next:Panel height="300"  width="96%" title="基本信息" collapsible="true" animCollapse="true" >
			<next:Html>
				<form  dataset="YgjzJtxxCyxxDataSet2" class="L5form">
				<table width="100%">
					<tr>
						<td class="FieldLabel" nowrap="nowrap"  width="10%">姓名:</td>
						<td class="FieldInput" width="20%" ><label name="name" field="name" /><font color="red">*</font></td>
						<td class="FieldLabel" nowrap="nowrap"  width="10%">身份证号:</td>
						<td class="FieldInput" width="20%"><label id="jtcysfzh" style="width:140" name="idCard" field="idCard" /><font color="red">*</font></td>
					    <td class="FieldLabel" width="10%" rowspan="5">照片:</td>
		   				<td nowrap colspan="1" rowspan="5">
		   				 <img id="photoPeople" name="PHOTO_PEOPLE" width=150 height=200
                                     src="";
                                     onerror="javascript:this.src='<%=SkinUtils.getImage(request,"default.jpg")%>'" alt="暂无图片"
                                   />

					    </td>
					</tr>
					<tr>
						<td class="FieldLabel" nowrap="nowrap" width="10%">户主关系:</td>
						<td class="FieldInput" width="20%"><label name="relationshipType" field="relationshipType" dataset="DmHzgxDataSet"></label></td>
						<td class="FieldLabel" nowrap="nowrap" width="10%">性别:</td>
						<td class="FieldInput" width="20%"> <label name="sex" field="sex" dataset="DmXbDataSet"></label></td>
					</tr>
					<tr>
						<td class="FieldLabel" nowrap="nowrap" width="10%">出生日期:</td>
						<td class="FieldInput" width="20%"><label id="birthday"   style="width:140" name="birthday" field="birthday" /><font color="red">*</font></td>
						<td class="FieldLabel" nowrap="nowrap" width="10%">户籍性质:</td>
						<td class="FieldInput" width="20%"> <label name="domicileType" field="domicileType" dataset="DmHjxzDataSet"></label></td>
					</tr>
					<tr>
						<td class="FieldLabel" nowrap="nowrap" width="10%">民族:</td>
						<td class="FieldInput" width="20%"><label name="nation" field="nation" dataset="DmMzDataSet"></label></td>
						<td class="FieldLabel" nowrap="nowrap" width="10%">婚姻状况:</td>
						<td class="FieldInput" width="20%"><label id="marriageCode" name="marriageCode" field="marriageCode" dataset="DmHyzkDataSet"></label></td>
					</tr>
					<tr>
						<td class="FieldLabel" nowrap="nowrap" width="10%">手机:</td>
						<td class="FieldInput" width="20%"><label name="telMobile" field="telMobile" /></td>
						<td class="FieldLabel" nowrap="nowrap" width="10%">其他联系方式:</td>
						<td class="FieldInput" width="20%"><label name="telOther" field="telOther" /></td>
					 </tr>
					<tr>
						<td class="FieldLabel" nowrap="nowrap"  width="10%">年收入:</td>
						<td class="FieldInput" width="20%"><label name="incomeYear" field="incomeYear" /><font color="red">*</font></td>
						<td class="FieldLabel" nowrap="nowrap"  width="10%">职业状况:</td>
						<td class="FieldInput" width="20%"><label name="employmentCode" field="employmentCode" dataset="DmZyDataSet"></label></td>
				    	<td class="FieldLabel" nowrap="nowrap"  width="10%">医疗状况:</td>
						<td class="FieldInput" width="20%"> <label name="safeguardType" field="safeguardType" dataset="DmYlzkDataSet"></label></td>
				    </tr>
					<tr>
						<td class="FieldLabel" nowrap="nowrap"  width="10%">工作单位_名称:</td>
						<td class="FieldInput" width="20%"><label name="workUnitName"  style="width:140" field="workUnitName" /></td>
						<td class="FieldLabel" nowrap="nowrap"  width="10%">工作单位_电话:</td>
						<td class="FieldInput" width="20%"><label name="workUnitTel" field="workUnitTel" /></td>
						<td class="FieldLabel" nowrap="nowrap"  width="10%">工作单位_地址:</td>
						<td class="FieldInput" width="20%"><label name="workUnitAdd" field="workUnitAdd" /></td>
				     </tr>
				     <input type="hidden" name="photoc2Id" field="photoId">
				    </table>
				</form>
				</next:Html>
            </next:Panel>

				<next:GridPanel id="cyxx" name="OnlineGrid" width="96%" height="158" dataset="SamPeopleDisabilityDataSet" collapsible="true" stripeRows="true" title="社会救助-残疾信息">
					<next:Columns>
					    <next:RowNumberColumn width="30"/>
						<next:Column id="disabilityType" header='残疾类型' field="disabilityType" width="150" sortable="false">
							<next:ComboBox dataset="DmCjlxDataSet" displayField="text" valueField="value" typeAhead="true" />
						</next:Column>
						<next:Column id="disabilityLevel" header='残疾等级' field="disabilityLevel" width="150" sortable="false">
							<next:ComboBox dataset="DmCjdjDataSet" displayField="text" valueField="value" typeAhead="true" />
						</next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="SamPeopleDisabilityDataSet"/>
					</next:BottomBar>
				 </next:GridPanel>

                <next:GridPanel id="jyxx" name="OnlineGrid" width="96%" height="158" dataset="SamPeopleEduDataSet" collapsible="true" stripeRows="true" title="社会救助-教育信息">
					<next:Columns>
					    <next:RowNumberColumn width="30"/>
						<next:Column id="regDate" header='登记时间' field="regDate" width="150" sortable="false">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="education" header='教育状况' field="education" width="150" sortable="false">
							<next:ComboBox dataset="DmJyzkDataSet" displayField="text" valueField="value" typeAhead="true" />
						</next:Column>
						<next:Column id="grade" header='教育状况年级' field="grade" width="150" sortable="false">
							<next:ComboBox dataset="DmJyzknjDataSet" displayField="text" valueField="value" typeAhead="true" />
						</next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="SamPeopleEduDataSet"/>
					</next:BottomBar>
				 </next:GridPanel>

				<next:GridPanel id="sgxx" name="OnlineGrid" width="96%" height="158" dataset="SamPeopleAccidentDataSet" collapsible="true" stripeRows="true" title="社会救助-事故信息">
					<next:Columns>
					    <next:RowNumberColumn width="30"/>
						<next:Column id="accidentDate" header='事故时间' field="accidentDate" width="150" sortable="false">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="accidentType" header='事故种类' field="accidentType" width="150" sortable="false">
							<next:ComboBox dataset="DmSgzlDataSet" displayField="text" valueField="value" typeAhead="true" />
						</next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="SamPeopleAccidentDataSet"/>
					</next:BottomBar>
				 </next:GridPanel>

				<next:GridPanel id="hbxx" name="OnlineGrid" width="96%" height="158" dataset="SamPeopleDiseaseDataSet" collapsible="true" stripeRows="true" title="社会救助-患病信息">
					<next:Columns>
					    <next:RowNumberColumn width="30"/>
						<next:Column id="diseaseDate" header='患病时间' field="diseaseDate" width="150" sortable="false">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="diseaseType" header='患病种类' field="diseaseType" width="150" sortable="false">
							<next:ComboBox dataset="DmHbzlDataSet" displayField="text" valueField="value" typeAhead="true" />
						</next:Column>
						<next:Column id="costMon" header='医疗支出_金额' field="costMon" width="150" sortable="false">
							<next:ComboBox dataset="DmYlzcDataSet" displayField="text" valueField="value" typeAhead="true" />
						</next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="SamPeopleDiseaseDataSet"/>
					</next:BottomBar>
				 </next:GridPanel>

	<next:Buttons>
		<next:ToolButton text="关闭" handler="hide"></next:ToolButton>
	</next:Buttons>
</next:Window>
</body>
</html>
