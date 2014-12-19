<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<html>
<head>
<%
	String nameValue=request.getParameter("name");
	String name="";
	if("accept".equals(nameValue)){
		name="受理";
	}else if("check".equals(nameValue)){
		name="审核";
	}else if("audit".equals(nameValue)){
		name="审批";
	}
%>
<title>新申请结束</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="<%=SkinUtils.getJS(request,"camsCheck.js") %>"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "ISPrint.js") %>"></script>
<script type="text/javascript" src="../../print/samApplyPrint.js"></script>
<script type="text/javascript">
    <%
    String organArea=BspUtil.getCorpOrgan().getOrganCode();
	String organName=DicUtil.getTextValueFromDic("DIC_CITY","ID",organArea,"NAME");
    %>
	var organArea='<%=organArea%>';
	var organName='<%=organName%>';
	var nameValue='<%=nameValue%>';
	function init(){
		query();
		document.getElementById("lrdwmc").value=organName;
		document.getElementById("lrdwId").value=organArea;
	}
//明细
function detailHref(value,cellmeta,record,rowindex,colindex,dataset){
	return '<a href="javascript:detail(\''+record.get("APPLY_ID")+'\',\''+record.get("FAMILY_ID")+'\')">'+value+'</a>';
}

function detail(applyId,FAMILY_ID){
			var width = screen.width-100;
		    var height = screen.height-140;
			 var url="../../../comm/samRuralAreasFamilyDetail.jsp?treatmentId="+""+"&assistanceType="+"03"+"&applyId="+applyId;
			window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
}
	//查询
	function query(){
		var lrdwId=document.getElementById("lrdwId").value;
	    if(""==lrdwId){
	    	lrdwId=organArea;
	    }
		var regDateStart=document.getElementById("regDateStart").value;
		var regDateEnd=document.getElementById("regDateEnd").value;
		var familyName=document.getElementById("familyName").value;
		var idCard=document.getElementById("idCard").value;
		var mysetwhere="FAMILY_NAME:"+familyName+"&FAMILY_CARD_NO:"+idCard+"&DOMICILE_CODE:"+lrdwId+"&APPLY_DATE:"+regDateStart+"-"+regDateEnd;
		applyDataSet.setParameter("mysetwhere",mysetwhere);
		applyDataSet.load();
		noReclick(applyDataSet,"queryId");
		if (regDateStart > regDateEnd) {
			alert("开始日期不能大于结束日期，请重新输入！");
			regDateStart.focus();
			return false;
	     }
	}
	/**
	 * 选择属地行政区划窗口
	 */
	function func_ForDomicileSelect() {
		var revalue = window.showModalDialog(
				L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&organCode="
						+ organArea + "&organName="
						+ escape(encodeURIComponent(organName)), "",
				"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
		if (revalue != "" && revalue != undefined) {
			var list = revalue.split(";");
			document.getElementById("lrdwId").value = list[0];
			document.getElementById("lrdwmc").value = list[1];
		}
	}
	//获取当前时间
	function getCurrent(){
		
		return (new Date()).getTime();
	}
</script>
</head>
<body>

<model:datasets>
	<!-- 业务信息 -->
	<model:dataset id="applyDataSet" cmd="com.inspur.cams.drel.sam.cmd.SamApplyInfoQueryCmd" method="queryJieShu" global="true"  >
		<model:record>
			<model:field name="RESULT_REASON" type="string" />
		</model:record>
		<model:params>
			<model:param name="processType" value='samFive'></model:param>
			<model:param name="actDefName" value='<%=name%>'></model:param>
		</model:params>
	</model:dataset>
	<!-- 意见 -->
	<model:dataset id="opinionDataSet" enumName="SAM_OPINION_TYPE" autoLoad="true" global="true"></model:dataset>
	
</model:datasets>
			<next:Panel width="100%" height="100%">
				<next:Panel title="结束业务查询" width="100%" autoHeight="true" titleCollapse="true" collapsible="true"  >	
					<next:Html>			
							<form class="L5form">
								<table  border="1" width="100%">
									<tr>
									 	<td class="FieldLabel" style="width:10%">地区</td>
						                <td class="FieldInput" style="width:20%">
						                 <input type="text" id="lrdwmcquery" readonly name="lrdwmc" id="lrdwmc" value="<%=organName%>" style='width:80%'/>
									  <input type="text" style="display: none;"  name="lrdwId" id="lrdwId" value="<%=BspUtil.getCorpOrgan().getOrganCode()%>"/>
									  <img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"  style="cursor:hand" onclick="func_ForDomicileSelect()" />
						               
						               </td>
						                <td class="FieldLabel" style="width:10%">登记日期</td>
						                <td class="FieldInput" style="width:20%"><input type="text" id="regDateStart"  format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" style = "padding-right:20px;background:url('<%= SkinUtils.getImage(request, "default/rl.gif ") %> ') no-repeat scroll right center transparent; "/>
						                	至<input type="text" id="regDateEnd" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" style = "padding-right:20px;background:url('<%= SkinUtils.getImage(request, "default/rl.gif ") %> ') no-repeat scroll right center transparent; "/></td>
						                <td class="FieldButton" style="width:10%"><button style="width:100" id="queryId" onclick="query();">查询</button></td>
									</tr>
									<tr>
									 	<td class="FieldLabel" style="width:10%">户主姓名</td>
						                <td class="FieldInput" style="width:10%"><input type="text"  id="familyName" style='width:80%' maxlength="30"/></td>
						                <td class="FieldLabel" style="width:10%">身份证号码</td>
						                <td class="FieldInput" style="width:10%"><input type="text" id="idCard" style="width:79%" maxlength="18"/></td>
						                 <td class="FieldButton" style="width:10%"><button type="reset" style="width:100">重置</button></td>
									</tr>
								</table>
							</form>
					</next:Html>
				</next:Panel>
				 <next:GridPanel  clickToSelectedForChkSM="true"id="YiBanGridPanel" title="结束业务列表" dataset="applyDataSet" width="100%" height="100%" stripeRows="true" notSelectFirstRow="true">
					<next:TopBar>		
						<next:ToolBarItem symbol="->"></next:ToolBarItem>	
						<next:ToolBarItem text="" /> 	
					</next:TopBar>
					<next:Columns>
		   				<next:RowNumberColumn/>
		   				<next:CheckBoxColumn></next:CheckBoxColumn>
		   				<next:Column  header="街道（乡镇）" field="TOWM_NAME"  width="200"  ></next:Column>	
						<next:Column  header="社区（村）" field="DOMICILE_NAME"  width="200"  ></next:Column>							
				        <next:Column header="户主姓名" field="FAMILY_NAME" width="150"  renderer="detailHref" ></next:Column>
			        	<next:Column header="身份证号码" field="FAMILY_CARD_NO" width="150" ></next:Column>
						<next:Column header="五保证号" field="CARD_NO" width="130" align="center"></next:Column>
						<next:Column header="登记日期" field="APPLY_DATE" width="150" ></next:Column>
						<next:Column header="结束原因" field="CUR_OPINION" width="150" ></next:Column>
						<next:Column header="结束时间" field="FINISH_TIME" width="150" ></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="applyDataSet" />
					</next:BottomBar>
				</next:GridPanel>
			</next:Panel>

</body>

</html>