<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<html>
<head>
<title>人行部门查询列表</title>
<next:ScriptManager />
<script>
			var organCode='<%=ExtBspInfo.getUserInfo(request).getAreaCode()%>';
			var organId='<%=ExtBspInfo.getUserInfo(request).getOrganId()%>';
</script>
<script type="text/javascript" src="externalcomm.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
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
	<!--经济核对_人行填报信息的dataset-->
	<model:dataset id="externalBankDataset"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyBankQueryCmd"
		global="true" pageSize="10" method="queryExtBank">
		
	</model:dataset>
	<!-- 属地 -->
	<model:dataset id="domicileDataset" autoLoad="false"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CITY'></model:param>
			<model:param name="value" value='ID'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>

<!--业务查询-->
<next:Panel name="form" width="100%" border="0"
	bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true"
	title="->  您的位置 : 人行填报信息列表">
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox"><legend
			class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton"
			src='<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>'
			onclick="collapse(this)" /> </legend>
		<div>
		<form style="width: 100%; height: 100%;" class="L5form">
		<table border="1" width="100%">
			<tr>
				<td class="FieldLabel">户主姓名:</td>
				<td class="FieldInput"><input type="text" id="name" style="width:170px"
					class="TextEditor" /></td>
				<td class="FieldLabel">户主身份证号:</td>
				<td class="FieldInput"><input type="text" id="idCard" style="width:160px"
					field="身份证号" class="TextEditor" /></td>
				<td class="FieldButton">
				<button onclick="query()">查 询</button>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel">核对时间:</td>
				<td class="FieldInput">
					<input type="text" id="startTime" style="width:80px"
					name="startTime" readonly="readonly" format="Y-m-d"
					onclick="LoushangDate(this)">---<input type="text" id="endTime"
					name="endTime" readonly="readonly" format="Y-m-d" style="width:80px"
					onclick="LoushangDate(this)">
				</td>
				<td class="FieldLabel">行政区划:</td>
				<td class="FieldInput">
					<select id="familyAddressh"  style="width:160px">
						<option dataset="domicileDataset"></option>
					</select>
				</td>
				<td class="FieldButton">
				<button onclick="reset()">重 置</button>
				</td>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>

<!--经济核对_地税填报信息的列表-->
<next:GridPanel id="editGridPanel" name="editGridPanel" width="100%"
	stripeRows="true" height="100%" dataset="externalBankDataset" 
	notSelectFirstRow="true" title="人行填报信息的列表">
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:Column id="name" header="人员姓名" field="NAME" width="15%">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="idCard" header="人员身份证件号码" field="ID_CARD" width="17%">
			<next:TextField allowBlank="false" />
		</next:Column>
		
		<next:Column id="accountName" header="开户人姓名" field="ACCOUNT_NAME" hidden="true" width="15%">
			<next:TextField />
		</next:Column>

		<next:Column id="totlSavings" header="存款金额合计(元)" field="TOTAL_SAVINGS" align="right" width="15%" renderer="formatNum">
			<next:TextField />
		</next:Column>
		<next:Column id="totalBond" header="债券总金额(元)" field="TOTAL_BOND" align="right" width="15%" renderer="formatNum">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="familyAddress" header="所在地区" field="FAMILY_ADDRESS" dataset="domicileDataset" width="100">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="checkTime" header="核对日期" field="CHECK_TIME" width="100">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="checkPeople" header="核对人" field="CHECK_PEOPLE" width="100">
			<next:TextField allowBlank="false" />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="externalBankDataset" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
