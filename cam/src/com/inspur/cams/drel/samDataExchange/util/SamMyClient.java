package com.inspur.cams.drel.samDataExchange.util;

import org.loushang.ws.AxisFault;
import org.loushang.ws.addressing.EndpointReference;
import org.loushang.ws.client.Options;
import javax.xml.namespace.QName;
import org.loushang.ws.rpc.client.RPCServiceClient;
import com.inspur.cams.drel.mbalance.data.OperationReturn;
import com.inspur.cams.drel.samDataExchange.domain.support.SamDataExchange;

public class SamMyClient {
	public static void main(String[] args) {
		try {
			RPCServiceClient serviceClient = new RPCServiceClient();
	        Options options = serviceClient.getOptions();
			// 指定调用WebService的URL
			EndpointReference targetEPR = new EndpointReference("http://localhost:8080/cam/services/SamDataExchange.SamDataExchange");
			options.setTo(targetEPR);
			options.setAction("sendSamExternalInfo");
			String xml = ("<?xml version='1.0' encoding='UTF-8'?>" 
					
				       +   "	<SAM_FAMILY_INFO>	"
				       +   "	<SAM_FAMILY>	"
				       +   "	        <APANAGE_CODE>371323001214</APANAGE_CODE>	"
				       +   "	        <DOMICILE_CODE>371323001214</DOMICILE_CODE>	"
				       +   "	        <ADDRESS>山东省莱州市三山岛街道沙岭村101号</ADDRESS>	"
				       +   "	        <FAMILY_POSTCODE />	"
				       +   "	        <FAMILY_MOBILE />	"
				       +   "	        <POVERTY_CAUSE>99</POVERTY_CAUSE>	"
				       +   "	        <BELONGING>04</BELONGING>	"
				       +   "	        <ASSISTANCE_CLASS />	"
				       +   "	        <ASSISTANCE_CLASS_MONEY>0.00</ASSISTANCE_CLASS_MONEY>	"
				       +   "	        <APPLY_DATE>2012-10-24</APPLY_DATE>	"
				       +   "	        <APPLY_REASON />	"
				       +   "	        <CARD_NO>370683030450001</CARD_NO>	"
				       +   "	        <BEGIN_DATE>2012-01</BEGIN_DATE>	"
				       +   "	        <END_DATE>3000-01</END_DATE>	"
				       +   "	        <SUPPORT_WAY />	"
				       +   "	        <SUPPORT_ORG />	"
				       +   "	        <ASSISTANCE_MODE>10</ASSISTANCE_MODE>	"
				       +   "	        <ASSISTANCE_MONEY>800.00</ASSISTANCE_MONEY>	"
				       +   "	        <FAMILY_ASSISTANCE_TYPE>11</FAMILY_ASSISTANCE_TYPE>	"
				       +   "	        <BANK>999</BANK>	"
				       +   "	        <ACCOUNT_NAME />	"
				       +   "	        <ACCOUNT_NUMBER>906033100010100765623</ACCOUNT_NUMBER>	"
				       +   "	        <ASSISTANCE_TYPE>02</ASSISTANCE_TYPE>	"
				       +   "	        <FAMILY_ID>45941990406C44CB82E38919762D1EB8</FAMILY_ID>	"
				       +   "	      </SAM_FAMILY>	"
				       +   "	      <SAM_PEOPLE>	"
				       +   "	        <PEOPLE_ID>CB4AD5EEAA4B4E3D8CB711102A07A779</PEOPLE_ID>	"
				       +   "	        <APANAGE_CODE>371323001214</APANAGE_CODE>	"
				       +   "	        <NAME>盛东君</NAME>	"
				       +   "	        <ID_CARD>370625197102261515</ID_CARD>	"
				       +   "	        <BIRTHDAY>1971-02-26</BIRTHDAY>	"
				       +   "	        <RELATIONSHIP_TYPE>01</RELATIONSHIP_TYPE>"
				       +   "	        <IS_ASSISTANCE>1</IS_ASSISTANCE>"
				       +   "	        <INCOME_MONTH>46.67</INCOME_MONTH>	"
				       +   "	        <INCOME_YEAR>560.00</INCOME_YEAR>	"
				       +   "	        <BELONGING>04</BELONGING>	"
				       +   "	        <PEOPLE_TYPE />	"
				       +   "	        <UNIT_NAME />	"
				       +   "	        <ADDRESS />	"
				       +   "	        <CONTACT_PHONE />	"
				       +   "	        <SCHOOL />	"
				       +   "	        <PERSONAL_STATS_TAG >01</PERSONAL_STATS_TAG >"
				       +   "	        <CONTACT_PEOPLE_EDU />	"
				       +   "	        <CONTACT_PHONE_EDU />	"
				       +   "	      </SAM_PEOPLE>	"
				       +   "	    </SAM_FAMILY_INFO>	");

//					
					
//					
//					"<SAM_FAMILY_INFO>"
//					+ " <SAM_FAMILY>"
//					+ "   <APANAGE_CODE>371121001202</APANAGE_CODE>"
//					+ "   <DOMICILE_CODE>3s1121001202</DOMICILE_CODE>"
//					+ "   <ADDRESS>洪凝街道东郭村</ADDRESS>"
//					+ "  <FAMILY_POSTCODE>262300</FAMILY_POSTCODE>"
//					+ "   <BELONGING>04</BELONGING>"
//					+ "   <ASSISTANCE_CLASS_MONEY>0.00</ASSISTANCE_CLASS_MONEY>"
//					+ "  <APPLY_DATE>2012-10-01</APPLY_DATE>"
//					+ "  <CARD_NO>37112101010192</CARD_NO>"
//					+ "  <BEGIN_DATE>2012-10</BEGIN_DATE>"
//					+ " <ASSISTANCE_MODE>10</ASSISTANCE_MODE>"
//					+ "  <ASSISTANCE_MONEY>0.00</ASSISTANCE_MONEY>"
//					+ "  <FAMILY_ASSISTANCE_TYPE>11</FAMILY_ASSISTANCE_TYPE>"
//					+ "  <ACCOUNT_NAME>汤森廷</ACCOUNT_NAME>"
//					+ "  <ACCOUNT_NUMBER>911030150010101025393</ACCOUNT_NUMBER>"
//					+ "   <ASSISTANCE_TYPE>02</ASSISTANCE_TYPE>"
//					+ "   <FAMILY_ID>D520C86BB17A1D76A695E1DE3EE2936F</FAMILY_ID>"
//					+ "  </SAM_FAMILY>"
//					+ "  <SAM_PEOPLE>"
//					+ "   <PEOPLE_ID>20EB082224204B419A4823542A89D26A</PEOPLE_ID>"
//					+ "   <APANAGE_CODE>371121001202</APANAGE_CODE>"
//					+ "  <NAME>汤森廷</NAME>"
//					+ "  <ID_CARD>370729192910080438</ID_CARD>"
//					+ "  <BIRTHDAY>1929-10-08</BIRTHDAY>"
//					+ "  <INCOME_MONTH>50.00</INCOME_MONTH>"
//					+ "   <INCOME_YEAR>600.00</INCOME_YEAR>"
//					+ "   <BELONGING>04</BELONGING>"
//					+ "  </SAM_PEOPLE>"
//					+ " </SAM_FAMILY_INFO>");
			
			
//			String xml = ("<?xml version='1.0' encoding='UTF-8'?><SAM_FAMILY_INFO>"
//					+ "<SAM_FAMILY>"
//					+ "<APANAGE_CODE>370103021001</APANAGE_CODE>"
//					+ "<DOMICILE_CODE>370103021001</DOMICILE_CODE>"
//					+ "<ADDRESS>家庭住址</ADDRESS><!--家庭住址-->"
//					+ "<FAMILY_POSTCODE>250000</FAMILY_POSTCODE><!-- 邮政编码-->"
//					+ "<FAMILY_PHONE>88888</FAMILY_PHONE><!--联系电话_宅电-->"
//					+ "<FAMILY_MOBILE>186</FAMILY_MOBILE><!--联系电话_手机-->"
//					+ "<POVERTY_CAUSE>01</POVERTY_CAUSE><!--主要致贫原因-->"
//					+ "<BELONGING>01</BELONGING><!--属别-->"
//					+ "<ASSISTANCE_CLASS></ASSISTANCE_CLASS><!--分类施保类别-->"
//					+ "<ASSISTANCE_CLASS_MONEY>100</ASSISTANCE_CLASS_MONEY><!--分类施保金额-->"
//					+ "<APPLY_DATE>2013-12-18</APPLY_DATE><!--申请救助时间-->"
//					+ "<APPLY_REASON></APPLY_REASON><!--申请理由-->"
//					+ "<CARD_NO>001</CARD_NO><!--低保(五保)证号-->"
//					+ "<BEGIN_DATE>2013-12</BEGIN_DATE><!--救助开始月份-->"
//					+ "<SUPPORT_WAY></SUPPORT_WAY><!--供养方式（五保）-->"
//					+ "<SUPPORT_ORG></SUPPORT_ORG><!--供养机构（五保）-->"
//					+ "<ASSISTANCE_MODE>10</ASSISTANCE_MODE><!--救助金计算方式-->"
//					+ "<ASSISTANCE_MONEY>400</ASSISTANCE_MONEY><!--户月保障金-->"
//					+ "<FAMILY_ASSISTANCE_TYPE></FAMILY_ASSISTANCE_TYPE><!--家庭类型-->"
//					+ "<BANK>102</BANK><!--开户银行-->"
//					+ "<ACCOUNT_NAME>ceshi</ACCOUNT_NAME><!--账户名称-->"
//					+ "<ACCOUNT_NUMBER>9559</ACCOUNT_NUMBER><!--银行账号-->"
//					+ "<ASSISTANCE_TYPE>01</ASSISTANCE_TYPE><!--家庭救助类型-->"
//					+ "<FAMILY_ID>ceshi0102</FAMILY_ID><!--家庭主键-->"
//					+ "</SAM_FAMILY>"
//
//					+ "<SAM_PEOPLE><!--人员信息（可以多条）-->　"
//					+ "<PEOPLE_ID>sssf1ff1</PEOPLE_ID><!--人员主键-->"
//					+ "<PERSONAL_STATS_TAG>01</PERSONAL_STATS_TAG> "
//					+ "<RELATIONSHIP_TYPE>01</RELATIONSHIP_TYPE><!--与户主关系-->"
//					+ "<APANAGE_CODE>370103021001</APANAGE_CODE><!--户籍行政区划代码-->"
//					+ "<NAME>lkjhyhbvgun</NAME><!--姓名-->"
//					+ "<ID_CARD>370123198605014713</ID_CARD><!--身份证件号码-->"
//					+ "<SEX>1</SEX><!--性别-->"
//					+ "<NATION>01</NATION><!--民族-->"
//					+ "<EDU_CODE>99</EDU_CODE><!--文化程度代码-->"
//					+ "<HEALTH_CODE></HEALTH_CODE><!--健康状况代码-->"
//					+ "<MARRIAGE_CODE></MARRIAGE_CODE><!--婚姻状况代码-->"
//					+ "<POLITICAL_CODE></POLITICAL_CODE><!--政治面貌代码-->"
//					+ "<BIRTHDAY></BIRTHDAY><!--出生日期-->"
//					+ "<EMPLOYMENT_CODE></EMPLOYMENT_CODE><!--就业状况-->"
//					+ "<LABOR_CAPACITY></LABOR_CAPACITY><!--劳动能力-->"
//					+ "<DISEASE_TYPE></DISEASE_TYPE><!--重病病种-->"
//					+ "<DISABILITY_TYPE></DISABILITY_TYPE><!--残疾类别-->"
//					+ "<DISABILITY_LEVEL></DISABILITY_LEVEL><!--残疾等级-->"
//					+ "	<IS_ASSISTANCE>1</IS_ASSISTANCE><!--是否保障对象-->"
//					+ "<DOMICILE_TYPE>2</DOMICILE_TYPE><!--户籍类别-->"
//					+ "	<EDU_STATUS></EDU_STATUS><!--学业状况-->"
//					+ "	<EDU_CODE></EDU_CODE><!--文化程度-->"
//					+ "	<IS_THREE_NO>0</IS_THREE_NO><!--是否“三无”-->"
//					+ "<INCOME_MONTH>123</INCOME_MONTH><!--月收入（元）-->"
//					+ "<INCOME_YEAR></INCOME_YEAR><!--年收入（元）-->"
//					+ "<BELONGING></BELONGING><!--属别-->"
//					+ "<NOTE></NOTE><!--备注-->"
//					+ "<PEOPLE_TYPE></PEOPLE_TYPE><!--人员类型-->"
//					+ "<SELF_CARE_ABILITY></SELF_CARE_ABILITY><!--生活自理能力-->"
//
//					+ "<UNIT_NAME></UNIT_NAME><!--单位名称-->"
//					+ "<UNIT_NATURE></UNIT_NATURE><!--单位性质-->"
//					+ "<ADDRESS></ADDRESS><!--就业地点-->"
//					+ "<AFFILIATION></AFFILIATION><!--隶属关系-->"
//					+ "<CONTACT_PHONE></CONTACT_PHONE><!--联系电话-->"
//					+ "<CONTACT_PEOPLE></CONTACT_PEOPLE><!--联系人-->"
//
//					+ "<SCHOOL></SCHOOL><!--在读学校名称-->"
//					+ "<SCHOOL_TYPE></SCHOOL_TYPE><!--学校类别-->"
//					+ "<CONTACT_PEOPLE_EDU></CONTACT_PEOPLE_EDU><!--学校联系人-->"
//					+ "<CONTACT_PHONE_EDU></CONTACT_PHONE_EDU><!--学校联系电话-->"
//					+ "<ENTRANCE_DATE></ENTRANCE_DATE><!--入学时间-->"
//
//					+ "<PEOPLE_INSURANCE><!--保障性支出信息（可多条）-->"
//					+ "<INSURANCE_TYPE>01</INSURANCE_TYPE><!--支出类型-->"
//					+ "<INSURANCE_FEE>100.52</INSURANCE_FEE><!--缴纳金额（元）-->"
//					+ "<INSURANCE_CYCLE>2</INSURANCE_CYCLE><!--缴费周期-->"
//					+ "<REMARKS>wu</REMARKS><!--备注-->"
//					+ "</PEOPLE_INSURANCE>"
//
//					+ "<PEOPLE_INSURANCE><!--保障性支出信息（可多条）-->"
//					+ "<INSURANCE_TYPE>02</INSURANCE_TYPE><!--支出类型-->"
//					+ "<INSURANCE_FEE>200.52</INSURANCE_FEE><!--缴纳金额（元）-->"
//					+ "<INSURANCE_CYCLE>1</INSURANCE_CYCLE><!--缴费周期-->"
//					+ "<REMARKS>wu</REMARKS><!--备注-->"
//					+ "</PEOPLE_INSURANCE>"
//
//					+ "</SAM_PEOPLE>"
//
//					+ "<FAMILY_HOUSE><!--家庭房屋信息（可多条）-->"
//					+ "<PROPERTY_OWNER></PROPERTY_OWNER><!--所有权人-->"
//					+ "<HOUSE_QUALITY></HOUSE_QUALITY><!--住房性质-->"
//					+ "<PROPERTY_CERTIFICATE>007</PROPERTY_CERTIFICATE><!--房产（建房）证号-->"
//					+ "<HOUSE_ADD>济南</HOUSE_ADD><!--住房地址-->"
//					+ "<BUILD_AREA>110</BUILD_AREA><!--建筑面积（㎡）-->"
//					+ "<USE_AREA>100</USE_AREA><!--使用面积（㎡）-->"
//					+ "</FAMILY_HOUSE>"
//
//					+ "<FAMILY_ESTATE><!--家庭财产信息（可多条）-->"
//					+ "	<ESTATE_TYPE>01</ESTATE_TYPE><!--财产类型-->"
//					+ "<REMARKS>备注</REMARKS><!--备注-->"
//					+ "</FAMILY_ESTATE>	"
//
//					+ "<FAMILY_SUPPORT><!--赡（抚、扶）养义务人员信息（可多条）-->"
//					+ "<NAME>yanll</NAME><!--姓名-->"
//					+ "<ID_CARD>370</ID_CARD><!--身份证号-->"
//					+ "<SUPPORTED_PEOPLE></SUPPORTED_PEOPLE><!--被赡（抚、扶）养人-->"
//					+ "<RELATION></RELATION><!--与被赡（抚、扶）养人关系-->"
//					+ "<SUPPORTED_PAY></SUPPORTED_PAY><!--月负担赡（抚、扶）养费（元）-->"
//					+ "</FAMILY_SUPPORT>	" + "</SAM_FAMILY_INFO>");
			Object[] opAddEntryArgs = new Object[] {xml};
			Class[] classes = new Class[] { String.class };
			// 指定要调用的queryInsurance方法及WSDL文件的命名空间
			QName opAddEntry = new QName("http://loushang.ws","sendSamExternalInfo");
			// 调用queryInsurance方法
			String infoXML = (String)serviceClient.invokeBlocking(opAddEntry, opAddEntryArgs,
					classes)[0];
			System.out.println("infoXML="+infoXML);
		} catch (AxisFault e) {
			e.printStackTrace();
		}
//		SamDataExchange d = new SamDataExchange();
//		
//		String xml = d.returnSamFamilyInfo("152103197709036678");
	}
}
