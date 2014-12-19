<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil" %>
<%@page import="org.loushang.next.skin.SkinUtils"%>

<%
	String reportOrganCode = BspUtil.getCorpOrgan().getOrganCode();//填报单位的organCode
	String provinceFlag = reportOrganCode.substring(reportOrganCode.length()-3);//省标志
	String cityFlag = reportOrganCode.substring(reportOrganCode.length()-2);//市标志
%>

<html>
	<head>
		<title>城市医疗救助工作情况回退</title>
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
			var id = '<%=request.getParameter("id")%>';
			//var organId= '<%=request.getParameter("organId")%>';
		</script>
	</head>
<body>
<next:Panel  name="form" width="98%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
	<next:Html>		
				<div>
					<form name="frm" style="width: 95%; height: 100%;" class="L5form" action="../../../../../ReportServer" target="Rpt_CityMedicalAssistanceCityReject">
						<table  border="1" width="100%" >
							<tr>
								<td class="FieldLabel"><button onclick="reject()">回退</button> </td>
							</tr>
						</table>
					</form>
				</div>
	</next:Html>
</next:Panel>
<iframe id="Rpt_CityMedicalAssistanceCityReject" name="Rpt_CityMedicalAssistanceCityReject" width="100%" height="100%">
	
</iframe>
</body>
<script type="text/javascript">
	var provinceFlag = '<%=provinceFlag%>';
	var cityFlag = '<%=cityFlag %>';
	
	if(cityFlag == "00") {//市级用户
		document.getElementById("Rpt_CityMedicalAssistanceCityReject").src = "../../../../../ReportServer?reportlet=Rpt_CityMedicalAssistanceCityReject.cpt&op=write&id="+id;
	}else {//区县级用户
		L5.Msg.alert("提示", "区县级用户没有回退业务！");
	}	
	
	//城市医疗救助工作情况回退
	function reject() {
		L5.MessageBox.confirm('确定', '你确定要回退吗？',function(sta){
			if(sta=="yes"){
				var command = new L5.Command("com.inspur.cams.drel.rpt.cmd.RptCitymedicalassistanceCommand");
				command.setParameter("RPT_CITYMEDICALASSISTANCE.ID@=", id);
				command.execute("forRetreat");
				var msg = command.getReturn("message");
				L5.Msg.alert("提示",msg,function(){L5.forward("jsp/cams/drel/manage/rpt/Rpt_CityMedicalAssistanceSummary.jsp");});	
			}else 
			return;
		});	
		
	}
</script>
</html>
