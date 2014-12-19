
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>年检业务</title>
<next:ScriptManager />
<script type="text/javascript" src="cemeAcceptedInspectionList.js"></script>
<script>
        var orgCode ='<%=BspUtil.getParentOrgan().getOrganCode()%>';
		var orgName ='<%=BspUtil.getParentOrgan().getOrganName()%>';
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
	<model:dataset id="ds"
		cmd="com.inspur.cams.fis.ep.base.cmd.FisCemeCheckResultQueryCommand"
		global="true" method="cemecheckQuery">
	</model:dataset>
	<model:dataset id="inspectionresultDataSet"
		enumName="FIS.CEME.INSPECTION.STATUS" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="propDataSet" enumName="FIS.CEME.PROP"  autoLoad="true" global="true"></model:dataset>
	
	<model:dataset id="resultDataSet"
		enumName="FIS.CEME.RESULT" autoLoad="true" global="true"></model:dataset>
    <model:dataset id="istakeproofDataSet"
		enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>	
	
	<!-- 公墓性质 -->
	<model:dataset id="cemePropDataSet" enumName="FIS.CEME.PROP"
		autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel name="form" width="99.9%" border="0"
	 autoHeight="true">
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox"><legend
			class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton"
			src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
			onclick="collapse(this)" /> </legend>
		<div>
		<form style="width: 100%; height: 100%;" class="L5form">
		<table border="1" width="100%">
			<tr>
				<td class="FieldLabel">公墓编号:</td>
				<td class="FieldInput"><input type="text" id="cemeID"
					class="TextEditor" title="公墓编号" /></td>
				<td class="FieldLabel">管辖单位:</td>
				<td class="FieldInput" colspan="1"><input type="text"
					name="manaLevel" id="manaLevel" field="manaLevel"
					class="TextEditor" readonly="readonly" /> <input type="text"
					id="manaLevelId" field="manaLevelId" style="display: none;" /> 
					<img src="<%=SkinUtils.getImage(request, "l5/help.gif")%>" style="cursor: hand" onclick="selectUser()" /></td>
			    <td class="FieldLabel">公墓性质:</td>
					<td class="FieldInput" ><select
					         name="cemeProp" id="cemeProp">
				    <option dataset="propDataSet" title="公墓性质"></option>
				    </select>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel">年检年份:</td>
				<td class="FieldInput"><input type="text" id="year"
					class="TextEditor" title="年检年份" value="2011"/></td>
				<td class="FieldLabel">年检结果:</td>
				<td class="FieldInput"><select name="年检结果" id="result"
					field="result">
					<option dataset="inspectionresultDataSet"></option>
				</select></td>

				<td class="FieldLabel" colspan="2">
					<button onclick="query()">查 询</button> &nbsp;
					<button onclick="resetQuery()">重 置</button>
				</td>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="inspectionGrid" width="99.9%"
	stripeRows="true" height="99.9%" dataset="ds" title="年检表单">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="年检办理" iconCls="edit" handler="accepted" />
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column id="cemeId" header="公墓编号" field="CEME_ID" width="150"
			hidden="false">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="公墓名称" field="CEME_NAME" width="150">
			<next:TextField />
		</next:Column>
		
		
		<next:Column header="年检年份" field="CHECK_YEAR" width="60">
			<next:TextField />
		</next:Column>
		<next:Column header="检查时间" field="FIRST_TIME" width="80">
			<next:TextField />
		</next:Column>
		<next:Column header="年检时间" field="SECOND_TIME" width="80">
			<next:TextField />
		</next:Column>
		<next:Column header="本年度年检次数" field="CHECK_NUM" width="100" hidden="true">
			<next:TextField />
		</next:Column>
		<next:Column header="年检结果" field="CHECK_RESULT" dataset="inspectionresultDataSet">
			<next:TextField />
		</next:Column>
		<next:Column header="公墓性质" field="PROP" dataset="cemePropDataSet" width="70">
			<next:TextField />
		</next:Column>
		<next:Column header="管辖单位" field="MANA_LEVEL">
			<next:TextField />
		</next:Column>
		<next:Column header="是否领证" field="IS_TAKEPROOF" dataset="istakeproofDataSet" hidden="true">
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
