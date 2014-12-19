
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<html>
	<head>
		<title>发放明细列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="samReleaseDetailList.js"></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"DatePicker.js")%>'></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
		<script type="text/javascript">
		    var releaseId='<%=request.getParameter("releaseId")%>';
		    var assistanceType='<%=request.getParameter("assistanceType")%>';
		    var releaseDate='<%=request.getParameter("releaseDate")%>';
	        var ifSpecial = '<%=request.getParameter("ifSpecial") %>';
		    <%
		    String organArea=BspUtil.getCorpOrgan().getOrganCode();
			String organName=DicUtil.getTextValueFromDic("DIC_CITY","ID",organArea,"NAME");
			
			String areaCode = BspUtil.getOrganCode();  
			String filterAreaCode="";
			if(areaCode.endsWith("0000000000")){
				filterAreaCode=areaCode;
			}else if (areaCode.endsWith("00000000")){
				filterAreaCode=areaCode+","+areaCode.substring(0,2)+"0000000000";
			}else if (areaCode.endsWith("000000")){
				filterAreaCode=areaCode+","+areaCode.substring(0,4)+"00000000"+","+areaCode.substring(0,2)+"0000000000";
			}else{
				filterAreaCode= areaCode.substring(0,4)+"00000000"+","+areaCode.substring(0,2)+"0000000000";
			}
		    %>
			var organArea='<%=organArea%>';
			var organName='<%=organName%>';
			var filterAreaCode = '<%= filterAreaCode %>';
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
	<model:dataset id="releaseDetailListDs" cmd="com.inspur.cams.drel.funds.release.cmd.SamReleaseDetailQueryCmd"  method="queryDetailByIfSpecial" global="true" pageSize="15">
		<model:record fromBean="com.inspur.cams.drel.funds.release.data.SamReleaseDetail"></model:record>
	</model:dataset>
	<model:dataset id="bankDs" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
        <model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
        <model:params>
            <model:param name="dic" value='DIC_BANK'></model:param>
        </model:params>
    </model:dataset>
	<!-- 救助类型 -->
	<model:dataset id="AssistanceDataset" autoLoad="true"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_assitance_Type'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
			<model:param name="includeCode" value='01,02,03'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="samAssistanceItemDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" >
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SAM_ASSISTANCE_ITEM'></model:param>
			<model:param name="value" value='ITEM_CODE'></model:param>
			<model:param name="text" value='ITEM_NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<next:Panel  name="form" width="100%" border="0">
	<next:Html>	
		<fieldset>
			<legend>查询条件
				<img class="GroupBoxExpandButton" src=<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%> onclick="collapse(this)" />
			</legend>
			<div>
				<form class="L5form" id="queryForm">
					<table width="100%" >
						<tr>
					    	<td class="FieldLabel" nowrap="nowrap" width="100">地区</td>
					        <td class="FieldInput" >
					        	<input type="text" id="domicileName" style="width: 175"
									readonly="readonly" /><img
									src="<%=SkinUtils.getImage(request, "l5/help.gif")%>"
									style="cursor: hand" onclick="areaSelect()"/>
								<input type="text" id="domicileCode" name="carCode" style="display: none"/>
					        </td>
					    	<td class="FieldLabel" nowrap="nowrap" width="100">户主姓名</td>
					        <td class="FieldInput" >
					        	<input type="text" name="familyName" id="familyName"/>
					        </td>
							<td class="FieldButton">
								<button onclick="query()">查 询</button>
							</td>
					    </tr>
					    <tr>
					        <td class="FieldLabel" nowrap="nowrap" width="100">身份证号码</td>
					        <td class="FieldInput" >
					        	<input type="text" name="familyCardNo" style="width: 175" id="familyCardNo"/>
					        </td>
					        <td class="FieldLabel" nowrap="nowrap" width="100">救助对象</td>
					        <td class="FieldInput" >
					        	<select name="assistanceType" id="assistanceType">
					        		<option dataset="AssistanceDataset"></option>
					        	</select>
					        </td>
					        <td nowrap="nowrap" class="FieldButton" >
								
						    </td>
					     </tr>
					     <tr>
					     	
				<td class="FieldLabel" style="width: 100;">发放年月</td>
				<td class="FieldInput"><input type="text" name="发放日期"style="width: 175" id="qReleaseDate"  onclick="setmonth(this)" readonly  style = "padding-right:20px;background:url('<%= SkinUtils.getImage(request, "default/rl.gif ") %> ') no-repeat scroll right center transparent; "/> 
				</td>
					<td class="FieldLabel" nowrap="nowrap" width="100" >专项补贴类别</td>
					<td class="FieldInput">
						<select id="itemCodeQuery" title="专项补贴类别">
							<option dataset='samAssistanceItemDataset'/>
						</select>
					</td>
				</td>
					        <td nowrap="nowrap" class="FieldButton">
								<button  onclick="resetQ()">重 置</button>
						    </td>
					     </tr>
					</table>
				</form>
			</div>
		</fieldset>
	</next:Html>
</next:Panel>
<next:GridPanel id="editGridPanel" name="samreleasedetailGrid" title="补贴明细" width="100%" stripeRows="true" height="100%"  notSelectFirstRow="true" clickToSelectedForChkSM="true"dataset="releaseDetailListDs">
    <next:TopBar>
        <next:ToolBarItem symbol="->"></next:ToolBarItem>
        <next:ToolBarItem iconCls="chart"  text="导出CSV" handler="exportDetail"/>
    </next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="domicileName" header="地区" field="domicileName" width="120"  align="center">
            <next:TextField  />
        </next:Column>
		<next:Column id="name" header="姓名" field="name" width="90"  align="center">
			<next:TextField  />
		</next:Column>
		<next:Column id="idCard" header="身份证号码" field="idCard" width="200"  align="center">
			<next:TextField  />
		</next:Column>
		<next:Column  header="专项补贴类别" field="releaseItem" dataset="samAssistanceItemDataset" width="100"  align="center">
			<next:TextField  />
		</next:Column>
		<next:Column id="assistancePeopleNum" header="保障人数" field="assistancePeopleNum" width="90" align="right">
			<next:NumberField  />
		</next:Column>
		<next:Column id="releaseMonSum" header="补贴金(元)" field="releaseMonSum" width="90" renderer="formatMoney"align="right" >
            <next:NumberField  />
        </next:Column>
		<next:Column id="accountName" header="账户名称" field="accountName" width="90"  align="center">
            <next:TextField  />
        </next:Column>
		<next:Column id="bank" header="开户银行" field="bank" width="120" dataset="bankDs" align="center">
			<next:TextField  />
		</next:Column>
		<next:Column id="accountNumber" header="账号" field="accountNumber" width="180"  align="center">
			<next:TextField  />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="releaseDetailListDs"/>
	</next:BottomBar>
	
</next:GridPanel>
</body>
</html>
