<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<%@page import="com.inspur.cams.drel.comm.RoleCmp" %>
<html>
<head>
<%
	String nameValue="";
	String name="";
	
	if(RoleCmp.getIfRoleName("城市低保业务受理审核")){
		name="审核";
		nameValue="check";
	}
	if(RoleCmp.getIfRoleName("城市低保业务审批")){
			name="审批";
			nameValue="audit";
	}
%>
<title>新申请已办</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"ISPrint.js")%>'></script>
<script type="text/javascript" src='../../print/samChangePrint.js'></script>
<script type="text/javascript">
    <%
    String organArea=BspUtil.getCorpOrgan().getOrganCode();
	String organName=DicUtil.getTextValueFromDic("DIC_CITY","ID",organArea,"NAME");
    %>
	var organArea='<%=organArea%>';
	var organName='<%=organName%>';
    var assistanceType="01";
    var assistanceTypeName="城市居民最低生活保障";
    var currentDate="<%=DateUtil.getMonth() %>";
	var nameValue='<%=nameValue%>';
	function init(){
		query();
		applyDataSet.on('load',function(){
			applyDataSet.each(function(record, index){
				var isFinish=record.get('IS_FINISH');
				if(isFinish == '1'){
					record.set('ACTIVE_ACT_DEF_NAMES',"结束");
				}
			});
			applyDataSet.commitChanges();
		});
		document.getElementById("lrdwmc").value=organName;
		document.getElementById("lrdwId").value=organArea;
	}
	//查看待办流程图
	function showState(){
		var daiBanTaskGridPanel=L5.getCmp("YiBanGridPanel");
		var selecteds=daiBanTaskGridPanel.getSelectionModel().getSelections();
		if(selecteds.length!=1){
			L5.Msg.alert("提示","请选择一条您要查看的记录");
			return false;
		}
		var assignmentId=selecteds[0].get("ID");
		var url='jsp/workflow/monitor/flowview.jsp?assignmentId='+assignmentId;
		L5.forward(url);
	}
//明细
function detailHref(value,cellmeta,record,rowindex,colindex,dataset){
	return '<a href="javascript:detail(\''+record.get("APPLY_ID")+'\',\''+record.get("FAMILY_ID")+'\')">'+value+'</a>';
}

function detail(applyId,FAMILY_ID){
			var width = screen.width-100;
		    var height = screen.height-140;
	var url='samCityChangeDetail.jsp?method=detail&name='+nameValue+'&applyId='+applyId+"&hrefFlg="+getCurrent();
	window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
}
	//打印
    function printNotice(){
        printChangeNotice("YiBanGridPanel");
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
	<model:dataset id="applyDataSet" cmd="com.inspur.cams.drel.sam.cmd.SamApplyInfoQueryCmd" method="queryYiBan" global="true"  >
		<model:params>
			<model:param name="processType" value='reCheckCity'></model:param>
			<model:param name="actDefName" value='<%=name%>'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="noticePrintDs" cmd="com.inspur.cams.drel.sam.cmd.SamApplyInfoQueryCmd" method="queryNoticePrintData" global="true"  >
    </model:dataset>
	<!-- 变更事项 -->
    <model:dataset id="samChangeItemDs" enumName="SAM_CHANGE_ITEM" autoLoad="true" global="true"></model:dataset>
	
</model:datasets>
			<next:Panel name="form" width="100%" border="0">
				<next:Html>
					<fieldset><legend>查询条件 </legend>
					<div>
					<form class="L5form">
						<table width="100%">
							<tr>
								<td class="FieldLabel" style="width:10%">地区</td>
							   	<td class="FieldInput" style="width:23%">
							        <input type="text" id="lrdwmcquery" readonly name="lrdwmc" id="lrdwmc" value="<%=organName%>" style='width:80%'/>
									<input type="text" style="display: none;"  name="lrdwId" id="lrdwId" value="<%=BspUtil.getCorpOrgan().getOrganCode()%>"/>
										  <img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"  style="cursor:hand" onclick="func_ForDomicileSelect()" />
							     </td>
							     <td class="FieldLabel" style="width:10%">户主姓名</td>
							     <td class="FieldInput" style="width:23%"><input type="text"  id="familyName" style='width:80%' maxlength="30"/></td>
							     <td class="FieldLabel" style="width:10%">身份证号码</td>
							     <td class="FieldInput" style="width:23%"><input type="text" id="idCard" style="width:79%" maxlength="18"/></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width:10%">登记日期</td>
							    <td class="FieldInput" style="width:23%" colspan="3">
									<input type="text" id="regDateStart"  format="Y-m-d" onclick="LoushangDate(this)" 
							           style = "padding-right:20px;background:url('<%= SkinUtils.getImage(request, "default/rl.gif ") %> ') no-repeat scroll right center transparent; "/>
							           ~<input type="text" id="regDateEnd" format="Y-m-d" onclick="LoushangDate(this)" 
							               		style = "padding-right:20px;background:url('<%= SkinUtils.getImage(request, "default/rl.gif ") %> ') no-repeat scroll right center transparent; "/>
							    </td>
								<td class="FieldButton" style="width:10%"  colspan="2">
								<button style="width:100" id="queryId" onclick="query();">查询</button>
								   &nbsp;&nbsp;&nbsp;&nbsp;
								<button type="reset" style="width:100">重置</button>
							    </td>
							</tr>
						</table>
					</form>
				</next:Html>
			</next:Panel>
				 <next:GridPanel  clickToSelectedForChkSM="true"id="YiBanGridPanel" dataset="applyDataSet" width="100%" height="100%" stripeRows="true" notSelectFirstRow="true">
					<next:TopBar>	
						<next:ToolBarItem id="qrToolbar" text="城市低保复查已办家庭查询信息"></next:ToolBarItem>		
						<next:ToolBarItem symbol="->"></next:ToolBarItem>	
						<next:ToolBarItem iconCls="detail" text="查看流转状态" handler="showState"/>
						<next:ToolBarItem iconCls="print"  text="打印公示书" handler="printNotice"/> 	
					</next:TopBar>
					<next:Columns>
		   				<next:RowNumberColumn/>
		    			<next:CheckBoxColumn></next:CheckBoxColumn>
						<next:Column  header="社区（村）" field="DOMICILE_NAME"  width="200"  ></next:Column>							
				        <next:Column header="户主姓名" field="FAMILY_NAME" width="150"  ></next:Column>
			        	<next:Column header="身份证号码" field="FAMILY_CARD_NO" width="150" ></next:Column>
						<next:Column header="登记日期" field="APPLY_DATE" width="150" ></next:Column>
						<next:Column header="当前环节" field="ACTIVE_ACT_DEF_NAMES" width="140" ></next:Column>
						<next:Column header="结束原因" field="CUR_OPINION" width="150" ></next:Column>
						<next:Column header="结束时间" field="FINISH_TIME" width="150" ></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="applyDataSet" />
					</next:BottomBar>
				</next:GridPanel>
</body>
</html>