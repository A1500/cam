<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>诚信统计查询列表</title>
<next:ScriptManager />

<script type="text/javascript" src="externalcomm.js"></script>
<script language="javascript">
		
		var struId='<%=BspUtil.getStruId()%>';
 		var organId='<%=BspUtil.getCorpOrganId()%>';
	     <%
	     	String organarea=BspUtil.getCorpOrgan().getOrganCode();
	     %>
	     var organArea='<%=organarea.substring(0, organarea.indexOf("000"))%>';
	     var organCode='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
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
   
	<!--诚信_dataset-->
	<model:dataset id="externalCreditDataset"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyFamilyQueryCmd"
		global="true" pageSize="10" method="queryCredit">
		
	</model:dataset>
	<!-- 诚信等级dataset-->
	<model:dataset id="credit_rating" enumName="CREDIT_RATING"
		autoLoad="true" global="true"></model:dataset>
	<!-- 救助类型dataset-->
	<model:dataset id="assistanceType" enumName="ASSISTANCE_TYPE"
		autoLoad="true" global="true"></model:dataset>
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
	title="->  您的位置 : 诚信统计查询列表">
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
				<td class="FieldLabel">诚信等级:</td>
				<td class="FieldInput" >
					<select id="creditRating" name="creditRating" class="FieldInput">
						<option dataset="credit_rating"></option>
					</select>
				</td>
				
				<td class="FieldLabel">救助类性:</td>
				<td class="FieldInput">
				<select id="assistanceType" name="assistanceType" class="TextEditor">
						<option dataset="assistanceType"></option>
					</select>
				</td>
				
				<td class="FieldButton">
				<button onclick="queryCredit()">查 询</button>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel">汇总审核时间起:</td>
				<td class="FieldInput" >
					<input type="text" id="startTime"
					name="startTime" readonly="readonly" format="Y-m-d" 
					onclick="LoushangDate(this)">
					
				</td>
				<td class="FieldLabel">汇总审核时间止:</td>
				<td class="FieldInput" >
					
					<input type="text" id="endTime"
					name="endTime"  readonly="readonly" format="Y-m-d" 
					onclick="LoushangDate(this)">	
					
				</td>
				<td class="FieldButton"></td>
			</tr>
			<tr>
				<td class="FieldLabel">属地行政区划:</td>
				<td class="FieldInput">
					<select id="familyAddressh" >
						<option dataset="domicileDataset"></option>
					</select>
				</td>
				<td class="FieldInput" colspan="2"><label id="et"></label></td>
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
	stripeRows="true" height="100%" dataset="externalCreditDataset" 
	notSelectFirstRow="true" title="诚信统计列表">
	
	<next:Columns>
		<next:RowNumberColumn width="30" />
		
		<next:Column id="familyAddress" header="属地行政区划" field="FAMILY_ADDRESS" width="30%"/>

		<next:Column id="creditRating" header="诚信等级" field="CREDIT_RATING" width="30%" dataset="credit_rating">
			<next:TextField allowBlank="false" />
			
		</next:Column>
		
		<next:Column id="gn" header="家庭数量" field="GN" width="30%">
			<next:TextField allowBlank="false" />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="externalCreditDataset" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
