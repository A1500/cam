<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil" %>
<%@ page import="com.inspur.cams.comm.util.DateUtil" %>
<%@page import="org.loushang.next.skin.SkinUtils"%>

<%
	String reportCorpOrganId = BspUtil.getCorpOrgan().getOrganId();//填报单位organId
	String reportCorpOrganName = BspUtil.getCorpOrgan().getOrganName();//填报单位名称
	String reporterOrganId = BspUtil.getEmpOrgan().getOrganId();//填写人organId
	String reportTime = DateUtil.getDay();//填报时间
	String reportOrganCode = BspUtil.getCorpOrgan().getOrganCode();//填报单位的organCode
	String provinceFlag = reportOrganCode.substring(reportOrganCode.length()-3);//省标志
	String cityFlag = reportOrganCode.substring(reportOrganCode.length()-2);//市标志
%>

<html>
	<head>
		<title>城市医疗救助工作情况填报</title>
		<next:ScriptManager/>
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
<next:Panel  name="form" width="98%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox"><legend
					class="GroupBoxTitle">填报条件 <img
					class="GroupBoxExpandButton"
					src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
					onclick="collapse(this)" /> </legend>
				<div>
					<form name="frm" style="width: 95%; height: 100%;" class="L5form" action="../../../../../ReportServer" target="Rpt_CityMedicalAssistanceReport">
						<table  border="1" width="100%" >
							<input type="hidden" id="reportlet" name="reportlet" />
							<input type="hidden" id="op" name="op" />
							<input type="hidden" id="reportCorpOrganId" name="reportCorpOrganId" />
							<input type="hidden" id="reporterOrganId" name="reporterOrganId" />
							<input type="hidden" id="reportTime" name="reportTime" />
							<input type="hidden" id="reportOrganCode" name="reportOrganCode" />
							<input type="hidden"  id="reportcorp" name="reportcorp" />
							<input type="hidden"  id="reported" name="reported" />
							<tr>
								<td class="FieldLabel">年份:</td>
								<td class="FieldInput"><input type="text"  id="reportyear" format="Y" onclick="LoushangDate(this)" class="TextEditor" title="年份" value="<%=request.getParameter("year")%>" disabled="disabled"/></td>
								<td class="FieldLabel">季度:</td>
								<td class="FieldInput"><input type="text"  id="reportquarter" class="TextEditor" title="季度" value="<%=request.getParameter("quarter")%>" disabled="disabled"/></td>		
								<td class="FieldLabel"><button onclick="report()">上报</button> </td>
								<td class="FieldLabel"><button onclick="back()">返回</button> </td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>
<iframe id="Rpt_CityMedicalAssistanceReport" name="Rpt_CityMedicalAssistanceReport" width="100%" height="100%">
	
</iframe>
</body>
<script type="text/javascript">
	var now = L5.server.getSysDate();//获取服务器的时间
	var provinceFlag = '<%=provinceFlag %>';
	var cityFlag = '<%=cityFlag %>';
	var reportOrganCode = '<%=reportOrganCode%>';

	
	if(provinceFlag == "000" && reportOrganCode!='371000') {//省级汇总 汇总市级已上报的数据
		document.getElementById("Rpt_CityMedicalAssistanceReport").src = "../../../../../ReportServer?reportlet=Rpt_CityMedicalAssistanceProvinceSummary.cpt&op=write&reportCorpOrganId=<%=reportCorpOrganId %>&reporterOrganId=<%=reporterOrganId %>&reportTime=<%=reportTime %>&reportOrganCode=<%=reportOrganCode%>&reportyear=<%=request.getParameter("year")%>&reportquarter=<%=request.getParameter("quarter")%>&reported=1&id=<%=request.getParameter("id")%>";
	}else if(cityFlag == "00") {//市级汇总 汇总区县级已上报的数据
		document.getElementById("Rpt_CityMedicalAssistanceReport").src = "../../../../../ReportServer?reportlet=Rpt_CityMedicalAssistanceCitySummary.cpt&op=write&reportCorpOrganId=<%=reportCorpOrganId %>&reporterOrganId=<%=reporterOrganId %>&reportTime=<%=reportTime %>&reportOrganCode=<%=reportOrganCode%>&reportyear=<%=request.getParameter("year")%>&reportquarter=<%=request.getParameter("quarter")%>&reported=0&id=<%=request.getParameter("id")%>";
	}else {//其他
		L5.Msg.alert("提示", "市级以下没有汇总业务！",function(){window.history.go(-1);});
	}
	
	//设置默认值
	function setDefault() {
		var year = document.getElementById("reportyear").value;
		var quarter = document.getElementById("reportquarter").value;
		var reportcorp = document.getElementById("reportcorp").value;
		var nowYear = now.getYear();
		if(year == ""){
			document.getElementById("reportyear").value = nowYear;
		}
		if(quarter == ""){
			document.getElementById("reportquarter").value = "1";
		}
		if(reportcorp == ""){
			document.getElementById("reportcorp").value = '<%=reportCorpOrganName%>';
		}
	}
	function getParam(ElementId) {
		var value=document.getElementById(ElementId).value;
		if(value=="") value=undefined;
		return value;
	}
	
	//城市医疗救助工作情况上报
	function report() {
		setDefault();		
		L5.MessageBox.confirm('确定', '确定要进行上报吗?',function(state){
		if(state=="yes"){
			var command = new L5.Command("com.inspur.cams.drel.rpt.cmd.RptCitymedicalassistanceCommand");
			command.setParameter("RPT_CITYMEDICALASSISTANCE.REPORTYEAR@=", getParam("reportyear"));
			command.setParameter("RPT_CITYMEDICALASSISTANCE.REPORTQUARTER@=", getParam("reportquarter"));
			command.setParameter("RPT_CITYMEDICALASSISTANCE.REPORTCORP@=", getParam("reportcorp"));
			//必须使用异步方式，然后转向必须在afterExecute回调函数中。
   			command.afterExecute = function(){
   			var msg = command.getReturn("message", false);
	   		if (msg==null || msg=="") {
	   			L5.Msg.alert("提示", "请先填报数据再上报！");
				return;
			}else{
				if(msg == "上报成功！") {
					var url = "jsp/cams/drel/manage/rpt/Rpt_CityMedicalAssistanceSummary.jsp";
	       			var text = "城市医疗救助工作情况填报";
					L5.Msg.alert("提示", msg,function(){L5.forward(url, text);});
				}	
			}
			}
			command.execute("report");
		}else{
			return false;
		}
		});
	}
	function back() {
		var url = "jsp/cams/drel/manage/rpt/Rpt_CityMedicalAssistanceSummary.jsp";
		var text = "城市医疗救助工作情况填报";
		L5.forward(url, text);
	}
</script>
</html>
