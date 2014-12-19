<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<next:ScriptManager />

	<script type="text/javascript" src="bptServiceQuery.js"></script>
<style type="text/css">
.content1 {
	width:954px;
	margin:0 auto;
	}
body {
	background-repeat: no-repeat; 
	margin:0px;padding:0px
}
</style>
</head>
<body>
<model:datasets>
	<model:dataset id="querydataset"
		cmd="com.inspur.cams.bpt.manage.cmd.WfProcessBusinessQueryCommand" method='queryWorkState'
		global="true" autoLoad="false">
		<model:record>
			<model:field name="FULL_NAME" type="string" />
			<model:field name="SERVICE_NAME" type="string" />
			<model:field name="NAME" type="string" />
			<model:field name="ID_CARD" type="string" />
			<model:field name="SERVICE_TYPE" type="string" />
			<model:field name="STATE" type="string" />
		</model:record>
	</model:dataset>
</model:datasets>

<div>
				<div class=content1>
					<div style="height:20px"></div>
					  <div style="margin:0 auto;width:880px;background:white;height:390px">
             <table border="0" cellspacing="0" cellpadding="0">
								<tr >
									<td   colspan=3   height="90" width="350">
									<img  style="float:left;margin-left:260px"  src="cardquery/bzjdcx.jpg"   height="90" width="350" >
									</td>
								</tr>
                                <tr>
                                    <td width="21"  height=42 background="cardquery/index_18.gif">
                                     
                                    </td>
                                    <td background="cardquery/index_20.gif"  height=42>
                                        <table border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td align="left">
                                                    <table width="838" border="0" cellspacing="0" cellpadding="0">
                                                            
                                                            <tr>
                                                                <td width="20" height="20" align="left">
                                                                    <img src="cardquery/index_21.gif" width="20" height="20">
                                                                </td>
                                                                
                                                                <td align="left">
																	<strong><font color="#01669A">身份证号:</font></strong>
                                                                    <label>
                                                                        <input type="text"  id="idCard"  maxlength="18" width="18" class="search_input2" value="请输入身份证号" onfocus="if(this.value=='请输入身份证号'){this.value=''};" onblur="if(this.value==''){this.value='请输入身份证号'};">
                                                                    </label>
																	<strong><font color="#01669A">业务类型:</font></strong>
																	<label>
                                                                    	<SELECT  id="serviceType">
																			<option value="11">伤残人员评残</option>
																				<option value="12">伤残人员调残</option>
																				<option value="13">伤残人员换证补证</option>
																				<option value="17">伤残人员配置伤残辅助器械</option>
																				<option value="14">退役军人伤残抚恤关系迁入</option>
																				<option value="15">外省伤残人员抚恤关系迁入</option>
																				<option value="16">伤残人员省内迁移</option>
																				<option value="19">伤残人员抚恤关系跨省迁出</option>
																				<option value="21">三属定期抚恤申请审批</option>
																				<option value="22">三属抚恤定补关系跨省迁入</option>
																				<option value="23">三属抚恤定补关系省内迁移</option>
																				<option value="25">三属抚恤定补关系跨省迁出</option>
																				<option value="41">在乡复员军人身份认定及定期定量生活补助审批</option>
																				<option value="42">在乡复员军人定补关系跨省迁入</option>
																				<option value="43">在乡复员军人定补关系省内迁移</option>
																				<option value="4A">在乡复员军人定补关系跨省迁出</option>
																				<option value="45">带病回乡退伍军人身份认定及生活补助审批</option>
																				<option value="46">带病回乡退伍军人定补关系跨省迁入</option>
																				<option value="47">带病回乡退伍军人定补关系省内迁移</option>
																				<option value="4B">带病回乡退伍军人定补关系跨省迁出</option>
																				<option value="55">参战人员定补关系跨省迁出</option>
																				<option value="51">参战人员身份认定及生活补助申请审批</option>
																				<option value="52">参战人员定补关系跨省迁入</option>
																				<option value="53">参战人员定补关系省内迁移</option>
																				<option value="65">参试人员定补关系跨省迁出</option>
																				<option value="61">参试人人员身份认定及生活补助申请审批</option>
																				<option value="62">参试人员定补关系跨省迁入</option>
																				<option value="63">参试人员定补关系省内迁移</option>
																				<option value="81">年满60周岁农村籍退役士兵</option>
																				<option value="82">年满60周岁农村籍退役士兵定补关系跨省迁入</option>
																				<option value="83">年满60周岁农村籍退役士兵定补关系省内迁移</option>
																				<option value="84">年满60周岁农村籍退役士兵定补关系跨省迁出</option>
																				<option value="B2">部分烈士（错杀被平反人员）子女定补关系跨省迁入</option>
																				<option value="B3">部分烈士（错杀被平反人员）子女定补关系省内迁移</option>
																				<option value="B4">部分烈士（错杀被平反人员）子女定补关系跨省迁出</option>
																				<option value="B1">部分烈士（错杀被平反人员）子女</option>
																				
																		</SELECT>
                                                                    
                                                                    </label>
																	 <strong><font color="#01669A">验证码：</font></strong>
																	 <input class="textfield" type="text" size="4" name="randCode" id="input1" maxlength="4"/> 
																	<label name="checkCode"  id="checkCode" style="width: 55px" class="code" onClick="createCode()"></label>
									  									
                                                                </td>
                                                                <td width="65">
                                                                    <input type="image" src="cardquery/search.gif" width="65" height="23" name="Submit" value="Subst" onClick="query()">
                                                                </td>
                                                            </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td width="21" background="cardquery/index_18q.gif" height=42></td>
                    </tr>
                </table>
				<table>
					<tr>
					<td>
					 	<table style="margin-top:50px;margin-left:280px;align:center;">
							  <tr>
								<td style="text-align:center;"><label id='msg'></label></td>
							  </tr>
						</table>
					</td>
					<form id="editForm" dataset="querydataset" onsubmit="return false"style="padding: 5px;" >
						<table style="margin-top:50px;margin-left:280px;align:center;">
							  <tr>
								<td style="text-align:left;font-size:11pt;"><strong><font color="#01669A">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名： </font></strong><label name="NAME" field="NAME" title="姓名"></label></td>
							  </tr>
							  <tr>
								<td height="30px"></td>
							  </tr>
							  <tr>
								<td style="text-align:left;font-size:11pt;"><strong><font color="#01669A">身份证号： </font></strong><label name="ID_CARD" field="ID_CARD" title="身份证号"></label></td>
							  </tr>
							  <tr>
								<td height="30px"></td>
							  </tr>
							  <tr>
								<td style="text-align:left;font-size:11pt;"><strong><font color="#01669A">申请种类： </font></strong><label name="SERVICE_NAME" field="SERVICE_NAME" title="申请种类"></label></td>
							  </tr>
							  <tr>
								<td height="30px"></td>
							  </tr>
							  <tr>
								<td style="text-align:left;font-size:11pt"><strong><font color="#01669A">审批进度： </font></strong><label name="STATE" field="STATE" title="审批进度"></label></td>
							  </tr>
					 </table>
					 </form>
					 
					</tr>
				</table>
			  </div>
     </div>
 </div>
</div>
</body>
</html>