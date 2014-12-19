<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<html>
<head>
<title>人员基本信息编辑</title>
<next:ScriptManager></next:ScriptManager>
<%
	String peopleId = request.getParameter("peopleId");
	if(peopleId==null){
		peopleId = IdHelp.getUUID32();
	}
%>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var companyId='<%=request.getParameter("companyId")%>';
	var peopleId='<%=peopleId%>';
	var rootPath='<%=SkinUtils.getRootUrl(request)%>';
</script>
<script type="text/javascript" src="jcmPeopleInfo.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/somPhoto.js")%>'></script>
<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ISEditPhoto.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="jcmPeopleInfoDataSet" cmd="com.inspur.cams.jcm.cmd.JcmPeopleInfoQueryCmd" global="true" pageSize="20">
		<model:record fromBean="com.inspur.cams.jcm.data.JcmPeopleInfo"/>
	</model:dataset>
		<model:dataset id="jcmPeopleResumeDataSet" cmd="com.inspur.cams.jcm.cmd.JcmPeopleResumeQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.jcm.data.JcmPeopleResume"/>
	</model:dataset>
	<model:dataset id="jcmPeopleCompanyDataSet" cmd="com.inspur.cams.jcm.cmd.JcmPeopleCompanyQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.jcm.data.JcmPeopleCompany"/>
	</model:dataset>
	<model:dataset id="jcmPeopleExamDataSet" cmd="com.inspur.cams.jcm.cmd.JcmPeopleExamQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.jcm.data.JcmPeopleExam"/>
	</model:dataset>
	

	<!-- 是否-->
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 有无-->
	<model:dataset id="comm_haveorno" enumName="COMM.HAVEORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 性别 -->
	<model:dataset id="sex" enumName="COMM.SEX"
		autoLoad="true" global="true"></model:dataset>
	<!-- 文化程度-->
	<model:dataset id="eduDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='dic_education'></model:param>
		</model:params>
	</model:dataset>
	<!-- 政治面貌-->
	<model:dataset id="sorgPoliticsDS" autoLoad="true"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_POLITICAL'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 民族 -->
	<model:dataset id="NationDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset> 
</model:datasets>
<next:Panel width="100%"  >
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:TabPanel>
<next:Tabs>
<next:Panel title ="基本信息" width="100%" >
<next:Html>
<form id="form1" method="post" dataset="jcmPeopleInfoDataSet" onsubmit="return false" class="L5form">
<fieldset>
	<legend>人员基本信息</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:15%">姓名：</td>
			<td class="FieldInput" style="width:18%"><input type="text" name="姓名" id="peopleName" field="peopleName" maxlength="50" /></td>
			<td class="FieldLabel" style="width:18%">性别：</td>
			<td class="FieldInput" style="width:18%"><select  name="性别" id="peopleSex" field="peopleSex" maxlength="50" >
				<option dataset="sex"></option>
			</select></td>
			<td class="FieldInput" style="width: 18%" rowspan="4">
				<div  id="photoDiv" >
					<img id="img" name="FAMILY_IMG"  width=85 height=120  src="<%=SkinUtils.getRootUrl(request) %>jsp/cams/sorg/comm/signet/default.jpg" 
						align="top" ondblclick="editPhoto(4,'familyPhotoId','FAMILY_IMG');"
						onerror="javascript:this.src='<%=SkinUtils.getRootUrl(request) %>jsp/cams/sorg/comm/signet/default.jpg'" alt="暂无图片" />
					<input type="hidden" id="familyPhotoId" name="familyPhotoId"/>
				</div>
			</td>
			
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">身份证号：</td>
			<td class="FieldInput" style="width:18%"><input type="text" style="width:150" name="身份证号" id="peopleCard" field="peopleCard" maxlength="18" /></td>
			<td class="FieldLabel" style="width:18%">民族：</td>
			<td class="FieldInput" style="width:18%"><select  name="民族" style="width:150" id="peopleNation" field="peopleNation" maxlength="50" >
				<option dataset="NationDataset"></option></select>
			</td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">参加工作时间：</td>
			<td class="FieldInput" style="width:18%" colspan="3"><input type="text" style="width:150" name="参加工作时间" onclick="LoushangDate(this)" readonly="readonly" format="Y-m-d"  id="jobStartTime" field="jobStartTime" maxlength="50" /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">出生年月：</td>
			<td class="FieldInput" style="width:18%"><input type="text" onclick="LoushangDate(this)" readonly="readonly" format="Y-m-d" name="出生年月" id="peopleBirthday" field="peopleBirthday" maxlength="50" /></td>
			<td class="FieldLabel" style="width:15%">政治面貌：</td>
			<td class="FieldInput" style="width:18%"><select  name="政治面貌" id="peoplePolitics" field="peoplePolitics" maxlength="50" >
				<option dataset="sorgPoliticsDS"></option></select>
			</td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">学历：</td>
			<td class="FieldInput" style="width:18%"><select type="text" name="学历" id="peopleEdu" field="peopleEdu" maxlength="50">
				<option dataset="eduDataSet"></option>
			</select></td>
			<td class="FieldLabel" style="width:15%">毕业院校：</td>
			<td class="FieldInput" style="width:18%"><input type="text" name="毕业院校" id="peopleSchool" field="peopleSchool" maxlength="50" /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">家庭住址：</td>
			<td class="FieldInput" style="width:18%" colspan="5"><input  type="text" style="width:100%" name="家庭住址" id="peopleAdress" field="peopleAdress"  /></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>

<next:EditGridPanel id="resumeGrid" title="简历信息" dataset="jcmPeopleResumeDataSet" width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="增加" handler="insertResume"></next:ToolBarItem>
		<next:ToolBarItem iconCls="delete" text="删除" handler="delResume"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="peopleId" header="人员主键" hidden="true" width="15%" sortable="false"/>
		<next:Column field="resumeId" header="简历主键" hidden="true" width="15%" sortable="false"/>
		<next:Column field="timeInfo" header="时间段" width="20%" sortable="false">
			<next:TextField></next:TextField>
		</next:Column>
		<next:Column field="unit" header="单位" width="20%" sortable="false">
			<next:TextField></next:TextField>
		</next:Column>
		<next:Column field="duitInfo" header="任职情况" width="20%" sortable="false">
			<next:TextField></next:TextField>
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="jcmPeopleResumeDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>

<next:GridPanel id="companyGrid" title="工作信息" dataset="jcmPeopleCompanyDataSet" width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="增加" handler="insertCompany"></next:ToolBarItem>
		<next:ToolBarItem iconCls="delete" text="删除" handler="delCompany"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="peopleCompanyId" hidden="true" header="人员工作单位主键" width="15%" sortable="false">
			<next:TextField></next:TextField>
		</next:Column>
		<next:Column field="peopleId" hidden="true"  hidden="true" header="人员主键" width="15%" sortable="false">
			<next:TextField></next:TextField>
		</next:Column>
		<next:Column field="companyId" hidden="true" header="单位主键" width="15%" sortable="false">
			<next:TextField></next:TextField>
		</next:Column>		
		<next:Column field="peopleDepartment" header="部门" width="15%" sortable="false">
			<next:TextField></next:TextField>
		</next:Column>
		<next:Column field="companyDuty" header="职务" width="15%" sortable="false">
			<next:TextField></next:TextField>
		</next:Column>
		<next:Column field="jobTitle" header="职称" width="15%" sortable="false">
			<next:TextField></next:TextField>
		</next:Column>
		<next:Column field="roomsNum" header="房间号" width="15%" sortable="false">
			<next:TextField></next:TextField>
		</next:Column>
		<next:Column field="establishment" header="人员编制性质" width="15%" sortable="false">
			<next:TextField></next:TextField>
		</next:Column>
		<next:Column field="dutyTime" header="任职时间" width="15%" sortable="false">
			<next:DateField format="Y-m-d"></next:DateField>
		</next:Column>
		<next:Column field="jobStatus" header="岗位状态" width="15%" sortable="false">
			<next:TextField></next:TextField>
		</next:Column>
		<next:Column field="molible" header="手机" width="15%" sortable="false">
			<next:TextField></next:TextField>
		</next:Column>
		<next:Column field="phone" header="联系电话" width="15%" sortable="false">
			<next:TextField></next:TextField>
		</next:Column>
		<next:Column field="qualification" header="专业资格" width="15%" sortable="false">
		<next:TextField></next:TextField></next:Column>
		<next:Column field="rpRecord" header="奖惩记录" width="15%" sortable="false">
		<next:TextField></next:TextField></next:Column>
		<next:Column field="changeTime" header="变更时间" width="15%" sortable="false">
		<next:TextField></next:TextField></next:Column>
		<next:Column field="dutyNum" header="任职文号" width="15%" sortable="false">
		<next:TextField></next:TextField></next:Column>
		<next:Column field="dutyStatus" header="任职状态" width="15%" sortable="false">
		<next:TextField></next:TextField></next:Column>
		<next:Column field="dutySection" header="人员所属部门" width="15%" sortable="false"><next:TextField></next:TextField></next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="jcmPeopleCompanyDataSet"/>
	</next:BottomBar>
</next:GridPanel>
<next:EditGridPanel title="培训信息" id="examGrid" dataset="jcmPeopleExamDataSet" width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="增加" handler="insertExam"></next:ToolBarItem>
		<next:ToolBarItem iconCls="delete" text="删除" handler="delExam"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="peopleExamId" hidden="true" header="培训主键" width="15%" sortable="false"><next:TextField></next:TextField></next:Column>
		<next:Column field="peopleId" hidden="true" header="人员主键" width="15%" sortable="false"><next:TextField></next:TextField></next:Column>
		<next:Column field="examYear" header="培训年度" width="15%" sortable="false"><next:TextField></next:TextField></next:Column>
		<next:Column field="examContent" header="培训内容" width="15%" sortable="false"><next:TextField></next:TextField></next:Column>
		<next:Column field="examTime" header="培训时间" width="15%" sortable="false"><next:DateField format="Y-m-d"></next:DateField></next:Column>
		<next:Column field="examPlace" header="培训地点" width="15%" sortable="false"><next:TextField></next:TextField></next:Column>
		<next:Column field="isExam" header="是否考试" width="15%" sortable="false"><next:TextField></next:TextField></next:Column>
		<next:Column field="examRuslut" header="考试结果" width="15%" sortable="false"><next:TextField></next:TextField></next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="jcmPeopleExamDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
</next:Tabs>
</next:TabPanel>
</next:Panel>
</body>
</html>