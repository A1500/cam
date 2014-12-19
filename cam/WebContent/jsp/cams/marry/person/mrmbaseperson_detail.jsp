<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<%@page import="com.inspur.cams.marry.base.cmd.MrmBasePersonCommand"%>

<html>
	<head>
		<title>人员基本信息表编辑</title>
		<next:ScriptManager/>
		<script>
			var idField='<%=request.getParameter("dataBean")%>';
		
		</script>
		<script type="text/javascript" src="mrmbaseperson_detail.js"></script>
		<script type="text/javascript" src="../../bpt/comm/bptComm.js"></script>
		<script type="text/javascript">var rootPath='<%=SkinUtils.getRootUrl(request)%>';</script>
		<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ISEditPhoto.js"></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.marry.base.cmd.MrmBasePersonQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmBasePerson"></model:record>
	</model:dataset>
	<!-- 职务信息 -->
	<model:dataset id="dsPosition" cmd="com.inspur.cams.marry.base.cmd.MrmPositionQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmPosition"></model:record>
	</model:dataset>
		<!-- 民族 -->
	<model:dataset id="NationDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	<!-- 是否颁证员 -->
	<model:dataset id="bzycodeDataset" enumName="MRM.BZYCODE.TYPE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 职务 -->
	<model:dataset id="zwDataset" enumName="MRM.ZW.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 人员性质 -->
	<model:dataset id="kindDataset" enumName="MRM.KIND.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 政治面貌 -->
	<model:dataset id="PoliticalDataset" enumName="POLITICAL.LANDSCAPE" autoLoad="true" global="true"></model:dataset>
	<!-- 学历 -->
	<model:dataset id="EducationDataset" enumName="EDUCATION.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 是否编制 -->
	<model:dataset id="yesornoDataset" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 计算机管理类型 -->
	<model:dataset id="computerTypeDataset" enumName="MRM.COMPUTERTYPE" autoLoad="true" global="true"></model:dataset>
		<!-- 岗位状态 -->
	<model:dataset id="workstateDataset" enumName="MRM.WORK.TYPE" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:TabPanel id="personTabPanel" name="personTabPanel">
<next:Tabs>
<next:Panel  title="人员基本信息表" width="100%" height="98%" autoWidth="true" autoHeight="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
	
		<next:ToolBarItem iconCls="delete"  text="关闭" handler="back"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="ds" onsubmit="return false" style="padding: 0px;" class="L5form">
		<table border="1"  width="100%" >
			<input type="hidden" id="personId" name="personId" field="personId">
			<input type="hidden" id="deptId" name="deptId" field="deptId" /> 
			<input type="hidden" id="deptName" name="deptName" field="deptName" />
	   		<tr>
				<td  class="FieldLabel" nowrap="nowrap" width="16%">姓名：</td>
				<td class="FieldInput" width="16%"><label name="name" field="name"  /> </td>
				
				<td  class="FieldLabel" nowrap="nowrap" width="16%">身份证件号：</td>
				<td class="FieldInput" width="16%"><label name="cardNo" field="cardNo" onblur="func_CheckIdCard();func_ShowBirthDate();" title="身份证件号码" style="width:155" maxlength="18"/></td>
			
			<td class="FieldLabel" width="10%" rowspan="3" width="16%">照片:</td>
				<td nowrap colspan="1" rowspan="3" width="16%">
					<div id="photoDiv">
						<img id="img" name="RELATIONER_PHOTOC_IMG" width=82.5 height=110 src="<%=SkinUtils.getRootUrl(request) %>/jsp/cams/marry/image/default.jpg" 
						align="top" ondblclick="editPhoto(1,'photo','RELATIONER_PHOTOC_IMG');"
						onerror="javascript:this.src='<%=SkinUtils.getRootUrl(request) %>/jsp/cams/marry/image/default.jpg'" alt="暂无图片" />
						<input type="hidden" id="photo" name="photo"/>
					</div>
				</td>	
	   		<tr>	
	   			<td  class="FieldLabel" nowrap="nowrap">性别：</td>
				<td class="FieldInput">
				<label name="sex" id="sex" field="sex"  dataset="SexDataset"/>
				</td>
				
				<td  class="FieldLabel" nowrap="nowrap">出生日期：</td>
				<td class="FieldInput"><label name="birthDate" field="birthDate" readonly="readonly" /> </td>
			</tr>
			<tr>
				<td  class="FieldLabel" >政治面貌：</td>
				<td class="FieldInput">
				<label id="politics" name="politics" field="politics" dataset="PoliticalDataset" />
				</td>
				
				<td  class="FieldLabel" nowrap="nowrap">民族：</td>
				<td class="FieldInput">
					<label name="nation" id="nation" field="nation" dataset="NationDataset"/>
				</td>
			</tr>
	   		<tr>
	   			<td  class="FieldLabel" >毕业院校：</td>
				<td class="FieldInput"><label name="college" field="college"  /> </td>
				
				<td  class="FieldLabel" >专业：</td>
				<td class="FieldInput"><label name="specialty" field="specialty"  /> </td>
				
				<td  class="FieldLabel" >学位：</td>
				<td class="FieldInput"><label name="degree" field="degree"  /> </td>
			</tr>
			<tr>
				<td  class="FieldLabel" >学历：</td>
				<td class="FieldInput">
				<label id="culture" name="culture" field="culture" dataset="EducationDataset"  />
				</td>
			
				<td  class="FieldLabel" >职务：</td>
				<td class="FieldInput"><label name="technical" field="technical" dataset="zwDataset" /> </td>
				<td  class="FieldLabel" >手机：</td>
				<td class="FieldInput"><label name="mobile" field="mobile"  /> </td>		
			</tr>
	   		<tr>
				<td  class="FieldLabel" >参加工作时间：</td>
				<td class="FieldInput"><label name="workDate" field="workDate"/> </td>
			
				<td  class="FieldLabel" >人员编制性质：</td>
				<td class="FieldInput">
					<label name="kind" field="kind" dataset="kindDataset" /> 
				</td>
				
				<td  class="FieldLabel" >是否编制：</td>
				<td class="FieldInput">
				<label name="organization" field="organization"  dataset="yesornoDataset" />
				</td>
			</tr>
			<tr>	
				<td  class="FieldLabel" >系统操作权限：</td>
				<td class="FieldInput">
				<label name="computerType" field="computerType" dataset="computerTypeDataset" />
				</td>
				
				<td  class="FieldLabel" >资格证编号：</td>
				<td class="FieldInput"><label name="certificateId" field="certificateId"  /> </td>
				
				<td  class="FieldLabel" >初次发证时间：</td>
				<td class="FieldInput" ><label name="djyccfzsj" field="djyccfzsj" format="Y-m-d" /> </td>
			</tr>
			<tr>
				<td  class="FieldLabel" >从事婚姻工作开始时间：</td>
				<td class="FieldInput"><label name="marryStartDate" field="marryStartDate" format="Y-m-d"  /><img  src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this)" /> </td>
			
				<td  class="FieldLabel" >从事婚姻工作结束时间：</td>
				<td class="FieldInput"><label name="marryEndDate" field="marryEndDate" format="Y-m-d"  /><img  src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this)" /> </td>
				
				<td class="FieldLabel" width="10%" rowspan="3">签名:</td>
				<td nowrap rowspan="2">
					<div id="qmDiv">
						<img id="img1" name="RELATIONER_PHOTOC_IMG1" width=144 height=44 src="<%=SkinUtils.getRootUrl(request) %>/jsp/cams/marry/image/qianming.jpg" 
						align="top" ondblclick="editPhoto(11,'qmName','RELATIONER_PHOTOC_IMG1');"
						onerror="javascript:this.src='<%=SkinUtils.getRootUrl(request) %>/jsp/cams/marry/image/qianming.jpg'" alt="暂无图片" />
						<input type="hidden" id="qmName" name="qmName"/>
					</div>
				</td>	
			   
			</tr>
			<tr>
				<td  class="FieldLabel" >离岗原因：</td>
				<td class="FieldInput" colspan="1"><label name="departureReason" field="departureReason" style="width:90%" /> </td>
			<td  class="FieldLabel" >岗位状态：</td>
				<td class="FieldInput">
				<label id="organization" name="workstate" field="workstate"  dataset="workstateDataset" />
				</td>
					
			</tr>
			<tr>
				<td  class="FieldLabel" >是否颁证员：</td>
				<td class="FieldInput" colspan="5">
				<label name="bzyCode" field="bzyCode"  dataset="bzycodeDataset" />
				 </td>
			</tr>		
		</table>
		</form>
   </next:Html>
</next:Panel>



</next:Tabs>
</next:TabPanel>
</body>
</html>