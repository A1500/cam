<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>人员明细页面</title>
<next:ScriptManager />
<script type="text/javascript" src="lowBptPeopleQueryDetail.js"></script>
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
	
	<model:dataset id="peopleinfods"
		cmd="com.inspur.cams.fis.base.cmd.FisFuneralDeadInfoQueryCmd" method="queryBptLowInfo" pageAble="flase">
		<model:record>
			<model:field name="BEGIN_DATE" type="string"/> 
			<model:field name="DISENDDATE" type="string"/> 
			<model:field name="WARENDDATE" type="string"/> 
			<model:field name="TESTDATE" type="string"/>
			 <model:field name="DISDATE" type="string"/> 
			 <model:field name="WBFLAG" type="string"/> 
			<model:field name="RETFLAG" type="string"/> 
			<model:field name="MARFLAG" type="string"/> 
			<model:field name="DEMOILLFLAG" type="string"/> 
			<model:field name="DISFLAG" type="string"/> 
			<model:field name="SEX" type="string"/> 
			<model:field name="RETENDDATE" type="string"/> 
			<model:field name="MARENDDATE" type="string"/> 
			<model:field name="ID_CARD" type="string"/> 
			<model:field name="END_DATE" type="string"/> 
			<model:field name="MARDATE" type="string"/> 
			<model:field name="WARFLAG" type="string"/> 
			<model:field name="NCFLAG" type="string"/> 
			<model:field name="NATION" type="string"/> 
			<model:field name="CSFLAG" type="string"/> 
			<model:field name="TESTFLAG" type="string"/> 
			<model:field name="DEMOILLEDDDATE" type="string"/> 
			<model:field name="RETDATE" type="string"/> 
			<model:field name="WARDATE" type="string"/> 
			<model:field name="DEMODATE" type="string"/> 
			<model:field name="TESTENDDATE" type="string"/> 
			<model:field name="NAME" type="string"/> 
			<model:field name="ADDRESS" type="string"/> 
			<model:field name="DEPFLAG" type="string"/> 
			<model:field name="DEPDATE" type="string"/> 
			<model:field name="DEPENDDATE" type="string"/> 
			<model:field name="DEMOENDDATE" type="string"/> 
			<model:field name="DEMOILLFLAG" type="string"/> 
			<model:field name="DEMOFLAG" type="string"/> 
		</model:record>
		
	</model:dataset>
</model:datasets>
<next:Panel  name="form" id="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox"><legend
					class="GroupBoxTitle">查询条件 <img
					class="GroupBoxExpandButton"
					src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
					onclick="collapse(this)" /> </legend>
				<div>
					<form style="width: 95%; height: 100%;" class="L5form">
						<table  border="1" width="100%" >
							<tr >
								<td class="FieldLabel"  width="15%">姓名：</td>
								<td class="FieldInput"  ><input type="text"  id="name"  title="姓名"  /></td>	
								<td class="FieldLabel" nowrap="nowrap">身份证件号码：</td>
								<td class="FieldInput" ><input type="text"  id="idCard" title="身份证件号码"  style="width:200"/></td>
								<td class="FieldInput"  width="25%" >
								<button onclick="query()">查 询</button>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<button onclick="personalscan()">刷身份证</button>
								 </td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>
		<next:Panel id="people_info" width="100%" autoHeight="true" title="人员信息" >
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="print" text="word" handler="print" />
		</next:TopBar>
			<next:Html>
				<form id="editForm1" method="post" dataset="peopleinfods"
						onsubmit="return false" class="L5form">
				<table width="100%">
				
					<tr>
						<td class="FieldLabel" rowspan="3" width="8%">基本信息</td>
						<td class="FieldLabel" width="12%">姓名</td>
						<td class="FieldInput">
							<label type="text" name="姓名" field="NAME" />
						</td>
						<td class="FieldLabel" width="12%">性别</td>
						<td class="FieldInput">
							<label name="性别" field="SEX" />
							<label name="性别" field="LOWSEX" />
						</td>
						<td class="FieldLabel" width="12%">民族</td>
						<td class="FieldInput">
							<label name="民族" field="NATION" />	
						</td>
					</tr>
					<tr>
						<td class="FieldLabel">身份证号</td>
						<td class="FieldInput" colspan="5">
							<label  field="ID_CARD" />
						</td>
					</tr>
					<tr>
						<td class="FieldLabel">住址</td>
						<td class="FieldInput" colspan="5">
							<label type="text" name="住址" field="ADDRESS" />
						</td>
					</tr>
					<tr>
						<td class="FieldLabel" rowspan="3">低保五保</td>
						<td class="FieldLabel" rowspan="3">类别</td>
						<td class="FieldInput" width="15%"><font color="red"><label type="text" field="CSFLAG" style="width:10"></label></font>&nbsp;&nbsp;<label>城市低保</label></td>
						<td class="FieldLabel" rowspan="3">保障开始时间</td>
						<td class="FieldInput" rowspan="3"width="15%"><label  field="BEGIN_DATE" /></td>
						<td class="FieldLabel" rowspan="3">退保时间</td>
						<td class="FieldInput" rowspan="3" width="15%"><label  field="END_DATE" /></td>
					</tr>
					<tr>
						<td class="FieldInput"><font color="red"><label type="text" field="NCFLAG"  style="width:10"></label></font>&nbsp;&nbsp;<label>农村低保</label></td>
						
					</tr>
					<tr>
						<td class="FieldInput"><font color="red"><label type="text" field="WBFLAG"  style="width:10"></label></font>&nbsp;&nbsp;<label>农村五保</label></td>
						
					</tr>
					<tr>
						<td class="FieldLabel" rowspan="8">优待抚恤</td>
						<td class="FieldLabel" rowspan="8">类别</td>
						<td class="FieldInput"><font color="red"><label type="text" field="DISFLAG"  style="width:10"></label></font>&nbsp;&nbsp;<label>伤残军人</label></td>
						<td class="FieldLabel" rowspan="8">批准时间</td>
						<td class="FieldInput"><label  field="DISDATE" /></td>
						<td class="FieldLabel" rowspan="8">终止时间</td>
						<td class="FieldInput"><label  field="DISENDDATE" /></td>
					</tr>
					<tr>
						<td class="FieldInput"><font color="red"><label type="text" field="DEPFLAG"  style="width:10"></label></font>&nbsp;&nbsp;<label>三属人员</label></td>
						<td class="FieldInput"><label  field="DEPDATE" /></td>
						<td class="FieldInput"><label  field="DEPENDDATE" /></td>
					</tr>
					<tr>
						<td class="FieldInput"><font color="red"><label type="text" field="DEMOFLAG"  style="width:10"></label></font>&nbsp;&nbsp;<label>在乡复原员军人</label></td>
						<td class="FieldInput"><label  field="DEMODATE" /></td>
						<td class="FieldInput"><label  field="DEMOENDDATE" /></td>
					</tr>
					<tr>
						<td class="FieldInput"><font color="red"><label type="text" field="DEMOILLFLAG"  style="width:10"></label></font>&nbsp;&nbsp;<label>带病回乡军人</label></td>
						<td class="FieldInput"><label  field="DEMOILLDATE" /></td>
						<td class="FieldInput"><label  field="DEMOILLENDDATE" /></td>
					</tr>
					<tr>
						<td class="FieldInput"><font color="red"><label type="text" field="WARFLAG"  style="width:10"></label></font>&nbsp;&nbsp;<label>参战退役军人</label></td>
						<td class="FieldInput"><label  field="WARDATE" /></td>
						<td class="FieldInput"><label  field="WARENDDATE" /></td>
					</tr>
					<tr>
						<td class="FieldInput"><font color="red"><label type="text" field="TESTFLAG"  style="width:10"></label></font>&nbsp;&nbsp;<label>参试退役军人</label></td>
						<td class="FieldInput"><label  field="TESTDATE" /></td>
						<td class="FieldInput"><label  field="TESTENDDATE" /></td>
					</tr>
					<tr>
						<td class="FieldInput"><font color="red"><label type="text" field="RETFLAG"  style="width:10"></label></font>&nbsp;&nbsp;<label>60岁以上退役老兵</label></td>
						<td class="FieldInput"><label  field="RETDATE" /></td>
						<td class="FieldInput"><label  field="RETENDDATE" /></td>
					</tr>
					<tr>
						<td class="FieldInput"><font color="red"><label type="text" field="MARFLAG"  style="width:10"></label></font>&nbsp;&nbsp;<label>部分烈士子女</label></td>
						<td class="FieldInput"><label  field="MARDATE" /></td>
						<td class="FieldInput"><label  field="MARENDDATE" /></td>
					</tr>
					<input type="hidden" id="docpath" value="jsp/cams/fis/query/lowBptInfo.doc"/>
			<input type="hidden" id="nameprint" name="printQuery" queryData="queryData" value=""/>
			<input type="hidden" id="idcardprint" name="printQuery" queryData="queryData" value=""/>
			<input type="hidden" id="scaconfPath" value="lowBptInfo/lowBptInfoPrintDao"/>
			<input type="hidden" id="method" value="queryLowBptInfo"/>
				</table>
				</form>
				<!-- 打印相关 -->
			
				
			</next:Html>
		</next:Panel>
</body>
</html>