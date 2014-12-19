
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>资格考试报名列表</title>
<next:ScriptManager />
<script type="text/javascript" src="mrmexamapplybzy_list.js"></script>

<script type="text/javascript">
	var organId='<%=BspUtil.getCorpOrgan().getOrganId()%>'
	var organCode='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
</script>
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
	<!-- 登记员资格考试安排表 -->
	<model:dataset id="apds"
		cmd="com.inspur.cams.marry.base.cmd.MrmExamScheduleQueryCommand"
		global="true">
		<model:record
			fromBean="com.inspur.cams.marry.base.data.MrmExamSchedule"></model:record>
	</model:dataset>
	<!-- 登记员考试信息 -->
	<model:dataset id="Personds"
		cmd="com.inspur.cams.marry.base.cmd.MrmBasePersonQueryCommand"
		method="examApplyDataSet" global="true">
		<model:record>
			<model:field name="kssj" />
		</model:record>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true"
		global="true"></model:dataset>
	<!-- 考试QISHU -->
	<model:dataset id="ksqsDataset" autoLoad="true"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='MRM_EXAM_SCHEDULE'></model:param>
			<model:param name="value" value='KSQS'></model:param>
			<model:param name="text" value='KSQS'></model:param>
		</model:params>
	</model:dataset>
	<!-- 年度 -->
	<model:dataset id="ndYearDataset" 
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='MRM_EXAM_SCHEDULE'></model:param>
			<model:param name="value" value='ND_YEAR'></model:param>
			<model:param name="text" value='ND_YEAR'></model:param>
		</model:params>
	</model:dataset>

	<!-- 考试QISHU -->
	<model:dataset id="ksTimeDataset" 
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='MRM_EXAM_SCHEDULE'></model:param>
			<model:param name="value" value='KSQS'></model:param>
			<model:param name="text" value='KSBEGIN_TIME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>

<next:Window id="addNewDemobilizedGrantObject" title="上传电子文件"
	resizable="false" width="600" height="100" closeAction="hide"
	modal="true">
	<next:Panel>
		<next:Html>
			<form onsubmit="return false" id="form_content"
				style="width: 99%; height: 100%;" class="L5form">
			<table border="1" width="100%">
				<tr>
					<td width="12%" nowrap="nowrap" class="FieldLabel">电子文件：</td>
					<td width="78%" nowrap="nowrap" class="FieldInput"><input
						style="width: 450px;" type="file" id="filename" name="filename"
						title="文件名" /></td>
					<td width="10%" nowrap="nowrap" align="center">
					<button onclick="upload()">上传</button>
					</td>
				</tr>
			</table>
			</form>
		</next:Html>
	</next:Panel>
</next:Window>

<next:Panel>
	<next:Html>
		<form id="editForm"  onsubmit="return false"
			style="padding: 5px;" class="L5form">
		<table border="1" width="100%">
			<tr>

				<td class="FieldLabel" width="10%" rowspan="2">年度</td>
				<td class="FieldInput" nowrap rowspan="2"><select id="ndYear" name="ndYear"
					title="年度" onchange="query()">
					<option dataset="ndYearDataset" />
				</select></td>
				<td class="FieldInput" width="70%"><label type="text" id="ksqs1"
					name="ksqs" field="ksqs" /></td>

				<td class="FieldLabel" colspan="4" rowspan="2"><button onclick="query()">查 询</button>
			</tr>
			
		</table>
		</form>
	</next:Html>

</next:Panel>
<next:EditGridPanel clicksToAssistWin="2" id="editGridPanel"
	name="mrmexamapplyGrid" width="100%" stripeRows="true" height="400"
	dataset="Personds" title="资格考试报名">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="打印" iconCls="edit" handler="commonExamapply" />
		<next:ToolBarItem text="报名" iconCls="add" handler="insert" />
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:CheckBoxColumn></next:CheckBoxColumn>

		<next:Column id="name" header="姓名" field="NAME" width="90"
			align="center" />

		<next:Column id="sex" header="性别" field="SEX" width="90"
			dataset="SexDataset" align="center" />

		<next:Column id="cardNo" header="身份证件号" field="CARD_NO" width="150" />

		<next:Column id="ksqs" header="考试期数" field="KSQS" width="90"
			align="center">
			<next:ComboBox dataset="ksqsDataset" displayField="text"
				editable="true" valueField="value" typeAhead="true" typeAble="false" />
		</next:Column>
		<next:Column id="kssj" header="考试时间" field="KSSJ_TIME" width="150"
			renderer="backTime" align="center">
			<next:ComboBox dataset="ksTimeDataset" displayField="text"
				editable="false" valueField="value" typeAhead="true"
				typeAble="false" />
		</next:Column>

		<next:Column id="fileName" header="附件名" field="FILE_NAME" width="150"
			renderer="cert_click" />

		<next:Column field="PERSON_ID" header="操作" renderer="operation"
			align="center" />
			<next:Column field="GIVE_OUT_TIME" header="考试状态"
			align="center" renderer="colorshow"/>

	</next:Columns>

</next:EditGridPanel>
<input type="hidden" id="updatefileId" value="" />
</body>
<input type="hidden" id="docpath" value=""/>
<input type="hidden" id="personId" name="printQuery" queryData="queryData" value=""/>
<input type="hidden" id="ksqs" name="printQuery" queryData="queryData" value=""/>
<input type="hidden" id="ndyearstring" name="printQuery" queryData="queryData" value=""/>
<input type="hidden" id="ksSign" name="printQuery" queryData="queryData" value=""/>
<input type="hidden" id="scaconfPath" value="mrmExamapply/mrmExamapplyDao"/>
</html>
