<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.sorg.assess.assess.util.SomAssessAssembleUtil"%>
<%@page import="com.inspur.cams.sorg.assess.assess.data.SomAssessAssemble"%>
<%@page import="com.inspur.cams.sorg.assess.assessconfig.data.SomAssessConfig"%>
<%@page import="java.util.List"%>
<html>
<head>
<title>无标题文档</title>
</head>
<% 
	SomAssessAssembleUtil somAssessAssembleUtil = new SomAssessAssembleUtil();
	String assessType = request.getParameter("assessType");
	String taskCode = request.getParameter("taskCode");
	String method = request.getParameter("method");
	List<SomAssessAssemble> list = somAssessAssembleUtil.getTreeData(assessType,taskCode);
%>
<body>
<next:ScriptManager/>
	<script>
	function save(){
		var objs = document.getElementsByName("score");
		var  addIds=[];
		for(var i=0;i<objs.length;i++){
			var id = objs[i].id;
			var value = objs[i].value;
			var obj = id +";" +value;
			addIds[i] = obj;
		}
		var command=new L5.Command("com.inspur.cams.sorg.assess.assess.cmd.SomAssessCommand"); 
		command.setParameter("addIds", addIds);
		command.setParameter("assessType", '<%=assessType%>');
		command.setParameter("taskCode", '<%=taskCode%>');
		var method = '<%=method%>';
		if(method == "INSERT"){
			command.execute("saveScore");
		}
		if(method == "UPDATE"){
			command.execute("updateScore");
		}
		if (!command.error) {
			L5.Msg.alert('提示',"保存成功！");
			//var data = new L5.Map();
			//data.put("assessType",record.get("assessType"));
			//data.put("taskCode",taskCode);
			//var url='jsp/cams/sorg/assess/assess/somassessmake.jsp';
			//var text = '开始评估打分';
			//L5.forward(url,text,data);
		}else{
			L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		}
	}
	function returnBack(){
		var url='jsp/cams/sorg/assess/assess/somassess_list.jsp';
		var text = 'SOM_ASSESS';
		L5.forward(url,text);	
	}
	
function checkScore(totalScore,obj){
	//先通过input对象向上查找到table对象
	//div
	var parentObj = obj.parentNode;
	//td2
	parentObj = parentObj.parentNode;
	//tr
	parentObj = parentObj.parentNode;
	//table
	parentObj = parentObj.parentNode;
	//获取table对象下有多少tr，有多少个tr就有多少个input
	var inputArr = parentObj.childNodes;
	var realTotalScore = 0;
	//循环tr，取到tr下的input值，并汇总
	for(var i=0;i<inputArr.length;i++){
		var inputValue = inputArr[i].childNodes[1].childNodes[0].childNodes[0].value;
		realTotalScore=parseInt(inputValue)+parseInt(realTotalScore);
	}
	//汇总值和三级指标分数比较
	if(realTotalScore>totalScore){
		L5.Msg.alert('提示',"所打分数不要超过三级指标规定分数！");
		obj.value="";
		return;
	}
	
		//先校验必须为数字
		var reg = new RegExp("^[0-9]*$");
		if(!reg.test(obj.value)){
        	L5.Msg.alert('提示',"请输入数字！");
        	obj.value="";
        	obj.focus();
        	return;
 		}
		if(obj.value>totalScore){
			L5.Msg.alert('提示',"所打分数不要超过三级指标规定分数！");
			obj.value="";
			obj.focus();
			return;
		}
	}
 </script>
</body>
	<style type="text/css">
		.table_border td
        {
            border-bottom:1px black solid;
            border-left:1px black solid;
            border-color:black;
            border-collapse: collapse;
        }
        .table_border
        {
         border-right:1px black solid;
         border-top:1px black solid;
         border-color:black;
         border-collapse: collapse;
        }
        .table_border1td
        {
            border-bottom:1px black solid;
            border-left:1px black solid;
            border-color:black;
            border-collapse: collapse;
        }
        .table_border1
        {
         border-right:1px black solid;
         border-color:black;
         border-collapse: collapse;
        }
        .td1{
        	border-bottom:1px black solid;
            border-left:1px black solid;
            border-color:black;
        }
        .td2{
            border-left:1px black solid;
            border-bottom:1px black solid;
            border-color:black;
        }
        .td3{
            border-color:black;
        }
        .bd {
			border:1px solid #518FCC;
		 }
		 .cMenu {
			 BORDER: #718BB7 1px solid;  FONT-WEIGHT: normal; FONT-SIZE: 14px; VISIBILITY: hidden;WIDTH: 100px; CURSOR: HAND; COLOR: BLACK; LINE-HEIGHT: 20px;  FONT-FAMILY: 微软雅黑,Verdana, Arial, Helvetica, sans-serif; POSITION: absolute; BACKGROUND-COLOR: #F0F0F0
		 }
		 .menuitems {
			 PADDING-RIGHT: 5px; PADDING-LEFT: 5px;
		 }
    </style>
<model:datasets>
	<model:dataset id="SomAssessConfigDataset" cmd="com.inspur.cams.sorg.assess.assessconfig.cmd.SomAssessConfigQueryCommand" global="true" >
		<model:record fromBean="com.inspur.cams.sorg.assess.assessconfig.data.SomAssessConfig">
		</model:record>
		<model:params>
			<model:param name="ASSESS_TYPE" value='<%=assessType%>'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<div align="right"  style="width:800px;margin:0 auto;">
		<input type="submit" value="保  存" onclick="save()">
		<input type="submit" value="返  回" onclick="returnBack()">
</div>	
<table width="800" height="145" align="center" cellpadding="0" cellspacing="0" class = "table_border" >
  <tr>
    <td height="90%" colspan="4"><div align="center">评估指标</div></td>
    <td width="10%" rowspan="2"><div align="center">四<br />
      级<br />
      指<br />
      标<br />
      打<br />
    分</div></td>
  </tr>
  <tr>
    <td width="20%" height="67"><div align="center">一级<br />
    指标</div></td>
    <td width="20%"><div align="center">二级<br />
    指标</div></td>
    <td width="25%"><div align="center">三级<br />
    指标</div></td>
    <td width="25%"><div align="center">四级<br />
    指标</div></td>
  </tr>
  </table>
  <table width="800" height="720"  align="center" cellpadding="0" cellspacing="0" class = "table_border1" >
  <% for(int i = 0;i<list.size();i++){%>
  <tr>
  <% SomAssessAssemble somAssessAssemble = list.get(i); %>
  <% SomAssessConfig somAssessConfig = somAssessAssemble.getThisLevelData(); %>
	  <td class="td1"  width="158"><div align="center"><%= somAssessConfig.getAssessContent()%><br />
	      （<%= somAssessConfig.getAssessScore()%>分）</div></td>
	      <% List<SomAssessAssemble> list2 = somAssessAssemble.getLowerLevelAssessAssembleList();%>
	      <td>
		      <table width="100%"  height="100%"   cellpadding="0" cellspacing="0" class = "table_border2" >
			      <% for(int j = 0;j<list2.size();j++){%>
			      		<% SomAssessAssemble somAssessAssemble2 = list2.get(j); %>
		 				<% SomAssessConfig somAssessConfig2 = somAssessAssemble2.getThisLevelData(); %>
		 				<tr>
		 				<td width="159"  class="td1" ><div align="center"><%= somAssessConfig2.getAssessContent()%><br />
			    			  （<%= somAssessConfig2.getAssessScore()%>分）</div></td>
			    		<% List<SomAssessAssemble> list3 = somAssessAssemble2.getLowerLevelAssessAssembleList();%>
			    		<td>
			      			<table width="100%" height="100%" cellpadding="0" cellspacing="0" class = "table_border3" >
			      			 <% for(int k = 0;k<list3.size();k++){%>
				      			 <% SomAssessAssemble somAssessAssemble3 = list3.get(k); %>
					 			 <% SomAssessConfig somAssessConfig3 = somAssessAssemble3.getThisLevelData(); %>
					 			 <% String inputOnchange = "checkScore("+somAssessConfig3.getAssessScore()+",this)";%>
					 			 <tr>
						 			 <td width="199"  class="td1" ><div align="center"><%= somAssessConfig3.getAssessContent()%><br />
							    			 （<%= somAssessConfig3.getAssessScore()%>分）</div></td>
							    	 <% List<SomAssessAssemble> list4 = somAssessAssemble3.getLowerLevelAssessAssembleList();%>
							    	 <td  class="td3">
							    	 	<table width="100%" height="100%" cellpadding="0" cellspacing="0" class = "table_border4" >
							    	 	 <% for(int l = 0;l<list4.size();l++){%>
							    	 	 <% SomAssessAssemble somAssessAssemble4 = list4.get(l); %>
							    	 	 <% SomAssessConfig somAssessConfig4 = somAssessAssemble4.getThisLevelData(); %>
							    	 	  <tr>
						 					 <td  width="199"  class="td2" ><div style="width:199px" align="center"><%= somAssessConfig4.getAssessContent()%>
						 					 <%if(somAssessConfig4.getAssessScore()!=null&&somAssessConfig4.getAssessScore()!=""){%>
						 					 	<br />
							    				 （<%= somAssessConfig4.getAssessScore()%>分）</div></td>
						 					 <%}%>
						 					 <td width="80" class="td2" >
							 					 <div align="center">
							 					 	<input type="text" name="score" id="<%=somAssessConfig4.getConfigId() %>" value="<%=somAssessConfig4.getAssessMakeScore() %>" style="width:45px;border:1px solid #CCDCEC;" onchange="<%=inputOnchange%>" title="请输入分数"/>
							 					 </div>
							 				 </td>
							    		  </tr>
							    		  <%} %>
							    		 </table>
							    	 </td>
						    	 </tr>
					    	 <%} %>
					    	 </table>
	     				 </td>
	     				 </tr>
			      <%} %>
		      </table>
	      </td>
	   </tr>
  <%} %>
</table>
</html>
