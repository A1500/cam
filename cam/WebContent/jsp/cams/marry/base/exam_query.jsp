<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
	<head>
		<title>考试成绩查询</title>
		<next:ScriptManager/>
		<script type="text/javascript">
		var organCode = '<%=BspUtil.getOrganCode()%>';
		var organType = '<%=BspUtil.getOrganType()%>';
		</script>
		<script type="text/javascript" src="exam_query.js"></script>
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
	<model:dataset id="ds" cmd="com.inspur.cams.marry.base.cmd.MrmQualificationExamQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmQualificationExam"></model:record>
	</model:dataset>
	<!-- 是否补正 -->
	<model:dataset id="yesornoDataset" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 考试结果 -->
	<model:dataset id="ksjgDataset" enumName="MRM.KSJG.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 补考结果 -->
	<model:dataset id="bkjgDataset" enumName="MRM.BKJG.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 初考复考标志 -->
	<model:dataset id="ckfkbzDataset" enumName="MRM.CKFKBZ.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 年度 -->
	<model:dataset id="ndYearDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='MRM_EXAM_SCHEDULE'></model:param>
			<model:param name="value" value='ND_YEAR'></model:param>
			<model:param name="text" value='ND_YEAR'></model:param>
		</model:params>
	</model:dataset>
	<!-- 资格证状态 -->
	<model:dataset id="zgzztDataset" enumName="MRM.ZGZZT.TYPE" autoLoad="true" global="true"></model:dataset>
	
</model:datasets>

<next:Panel  name="form" width="100%" autoScroll="true" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox"><legend
					class="GroupBoxTitle">查询条件 <img
					class="GroupBoxExpandButton"
					src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
					onclick="collapse(this)" /> </legend>
				<div>
					<form style="width: 100%; height: 100%;" class="L5form">
						<table  border="1" width="100%" >
							<tr>	
								<td class="FieldLabel" nowrap>年度:</td>
								<td class="FieldInput">
								<select id="ndYear" class="TextEditor" title="年度" >
									<option dataset="ndYearDataset" />
								</select>
								</td>	
								<td class="FieldLabel" nowrap>考试结果:</td>
								<td class="FieldInput">
									<select id="ksjg" class="TextEditor" title="考试结果" >
										<option dataset="ksjgDataset" />
									</select>
								</td>	
								<td class="FieldLabel" align="center" nowrap ><button onclick="query()">查 询</button>&nbsp;&nbsp;&nbsp;<button onclick="rest()">重 置</button></td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel clickToSelectedForChkSM="true" notSelectFirstRow="true" id="editGridPanel" name="mrmqualificationexamGrid" width="100%" height="98%" stripeRows="true" dataset="ds" title="考试成绩查询列表">
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
		
		<next:Column id="name" header="姓名" field="NAME" width="90" align="center"/>
		
		<next:Column id="ndYear" header="年度" field="ND_YEAR" width="90" align="center"/>
	
		<next:Column id="ksqs" header="考试期数" field="KSQS" width="90" align="center"/>
	
		
	
		<next:Column id="ksjg" header="考试结果" field="KSJG" width="90" align="center">
			<next:ComboBox triggerAction="all" valueField="value" displayField="text" dataset="ksjgDataset" typeAble="false" />
		</next:Column>
		
		<next:Column id="bkjg" header="补考结果" field="BKJG" width="90" align="center">
			<next:ComboBox triggerAction="all" valueField="value" displayField="text" dataset="bkjgDataset" typeAble="false" />
		</next:Column>
		
		<next:Column id="zgzzt" header="资格证状态" field="ZGZZT" width="90" align="center" dataset="zgzztDataset"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
