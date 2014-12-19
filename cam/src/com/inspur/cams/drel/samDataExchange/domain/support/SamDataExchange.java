package com.inspur.cams.drel.samDataExchange.domain.support;

import com.inspur.cams.comm.baseinfo.dao.IBaseinfoFamilyDao;
import com.inspur.cams.comm.baseinfo.dao.IBaseinfoPeopleDao;
import com.inspur.cams.comm.baseinfo.data.BaseinfoFamily;
import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;
import com.inspur.cams.comm.baseinfo.domain.IBaseinfoDomain;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.DicUtil;
import com.inspur.cams.drel.esurey.domain.ISamLowStandardsDomain;
import com.inspur.cams.drel.sam.dao.ISamFamilyEstateDao;
import com.inspur.cams.drel.sam.dao.ISamFamilyHouseDao;
import com.inspur.cams.drel.sam.dao.ISamFamilySupportDao;
import com.inspur.cams.drel.sam.data.SamApplyInfo;
import com.inspur.cams.drel.sam.data.SamBankAccount;
import com.inspur.cams.drel.sam.data.SamFamilyAssistance;
import com.inspur.cams.drel.sam.data.SamFamilyEstate;
import com.inspur.cams.drel.sam.data.SamFamilySupport;
import com.inspur.cams.drel.sam.data.SamFamilyTreatment;
import com.inspur.cams.drel.sam.data.SamPeopleDisability;
import com.inspur.cams.drel.sam.data.SamPeopleDisease;
import com.inspur.cams.drel.sam.data.SamPeopleEdu;
import com.inspur.cams.drel.sam.data.SamPeopleExtend;
import com.inspur.cams.drel.sam.data.SamPeopleIncome;
import com.inspur.cams.drel.sam.data.SamPeopleInsurance;
import com.inspur.cams.drel.sam.data.SamPeopleJobs;
import com.inspur.cams.drel.sam.domain.ISamApplyDiscussionDomain;
import com.inspur.cams.drel.sam.domain.ISamApplyInfoDomain;
import com.inspur.cams.drel.sam.domain.ISamApplyNoticeDomain;
import com.inspur.cams.drel.sam.domain.ISamApplyOptionsHisDomain;
import com.inspur.cams.drel.sam.domain.ISamApplySurveyDomain;
import com.inspur.cams.drel.sam.domain.ISamBankAccountDomain;
import com.inspur.cams.drel.sam.domain.ISamCardNoDomain;
import com.inspur.cams.drel.sam.domain.ISamFamilyAssistanceDomain;
import com.inspur.cams.drel.sam.domain.ISamFamilyTreatmentDomain;
import com.inspur.cams.drel.sam.domain.ISamPeopleDisabilityDomain;
import com.inspur.cams.drel.sam.domain.ISamPeopleDiseaseDomain;
import com.inspur.cams.drel.sam.domain.ISamPeopleEduDomain;
import com.inspur.cams.drel.sam.domain.ISamPeopleExtendDomain;
import com.inspur.cams.drel.sam.domain.ISamPeopleIncomeDomain;
import com.inspur.cams.drel.sam.domain.ISamPeopleInsuranceDomain;
import com.inspur.cams.drel.sam.domain.ISamPeopleJobsDomain;
import com.inspur.cams.drel.sam.domain.ISamPeopleTypeDomain;
import com.inspur.cams.drel.samDataExchange.domain.ISamDataExchange;
import com.inspur.comm.util.IdHelp;
import com.inspur.sdmz.jtxx.data.SamFamilyHouse;
import java.io.IOException;
import java.io.StringReader;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.loushang.next.dao.UUID;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

/**
 * 数据共享低保系统具体实现
 * 
 * @author YLL
 * @since 2013年12月12日
 */
public class SamDataExchange implements ISamDataExchange {
	
	@Reference
	private IBaseinfoFamilyDao baseInfoFamilyDao;
	@Reference
	private IBaseinfoPeopleDao baseinfoPeopleDao;
	@Reference
	private ISamApplyInfoDomain samApplyInfoDomain;
	@Reference
	private IBaseinfoDomain baseinfoDomain;
	@Reference
	private ISamFamilyTreatmentDomain samFamilyTreatmentDomain;
	@Reference
	private ISamFamilyAssistanceDomain samFamilyAssistanceDomain;
	@Reference
	private ISamApplyNoticeDomain samApplyNoticeDomain;
	@Reference
	private ISamApplyDiscussionDomain samApplyDiscussionDomain;
	@Reference
	private ISamApplySurveyDomain samApplySurveyDomain;
	@Reference
	private ISamBankAccountDomain samBankAccountDomain;
	@Reference
	private ISamPeopleTypeDomain samPeopleTypeDomain;
	@Reference
	private ISamPeopleExtendDomain samPeopleExtendDomain;
	@Reference
	private ISamPeopleDiseaseDomain samPeopleDiseaseDomain;
	@Reference
	private ISamPeopleDisabilityDomain samPeopleDisabilityDomain;
	@Reference
	private ISamPeopleEduDomain samPeopleEduDomain;
	@Reference
	private ISamPeopleIncomeDomain samPeopleIncomeDomain;
	@Reference
	private ISamPeopleJobsDomain samPeopleJobsDomain;
	@Reference
	private ISamPeopleInsuranceDomain samPeopleInsuranceDomain;
	@Reference
	private ISamFamilyHouseDao samFamilyHouseDao;
	@Reference
	private ISamFamilyEstateDao samFamilyEstateDao;
	@Reference
	private ISamFamilySupportDao samFamilySupportDao;
	
	private static final Map<String,Object> map = new HashMap<String, Object>();
	static{
		map.put("APANAGE_CODE","String,12,noRequire");
		map.put("DOMICILE_CODE","String,12,require");
		map.put("FAMILY_POSTCODE","String,6,noRequire");
		map.put("FAMILY_PHONE","String,50,noRequire");
		map.put("FAMILY_MOBILE","String,20,noRequire");
		map.put("POVERTY_CAUSE","String,3,noRequire");
		map.put("ASSISTANCE_CLASS","String,32,noRequire");
		map.put("ASSISTANCE_CLASS_MONEY","int,10,noRequire");
		map.put("APPLY_DATE","String,10,noRequire");
		map.put("APPLY_REASON","String,500,noRequire");
		map.put("CARD_NO","String,30,noRequire");
		map.put("BEGIN_DATE","String,7,require");
		map.put("END_DATE","String,7,noRequire");
		map.put("SUPPORT_WAY","String,2,noRequire");
		map.put("SUPPORT_ORG","String,32,noRequire");
		map.put("ASSISTANCE_MODE","String,3,noRequire");
		map.put("ASSISTANCE_MONEY","int,10,noRequire");
		map.put("FAMILY_ASSISTANCE_TYPE","String,50,noRequire");
		map.put("BANK","String,10,noRequire");
		map.put("ACCOUNT_NAME","String,30,noRequire");
		map.put("ACCOUNT_NUMBER","String,40,noRequire");
		map.put("ASSISTANCE_TYPE","String,2,require");
		map.put("FAMILY_ID","String,32,require");
		map.put("PEOPLE_ID","String,32,require");
		map.put("PERSONAL_STATS_TAG","String,2,require");
		map.put("RELATIONSHIP_TYPE","String,2,require");
		map.put("NAME","String,50,require");
		map.put("ID_CARD","String,18,require");
		map.put("SEX","String,1,noRequire");
		map.put("NATION","String,2,noRequire");
		map.put("EDU_CODE","String,2,noRequire");
		map.put("HEALTH_CODE","String,2,noRequire");
		map.put("MARRIAGE_CODE","String,2,noRequire");
		map.put("POLITICAL_CODE","String,2,noRequire");
		map.put("BIRTHDAY","String,10,noRequire");
		map.put("EMPLOYMENT_CODE","String,2,noRequire");
		map.put("LABOR_CAPACITY","String,3,noRequire");
		map.put("DISEASE_TYPE","String,2,noRequire");
		map.put("DISABILITY_TYPE","String,2,noRequire");
		map.put("DISABILITY_LEVEL","String,2,noRequire");
		map.put("IS_ASSISTANCE","String,1,require");
		map.put("DOMICILE_TYPE","String,2,noRequire");
		map.put("EDU_STATUS","String,3,noRequire");
		map.put("IS_THREE_NO","String,3,noRequire");
		map.put("INCOME_MONTH","int,10,noRequire");
		map.put("INCOME_YEAR","int,10,noRequire");
		map.put("BELONGING","String,3,noRequire");
		map.put("NOTE","String,200,noRequire");
		map.put("PEOPLE_TYPE","String,30,noRequire");
		map.put("SELF_CARE_ABILITY","String,3,noRequire");
		map.put("UNIT_NAME","String,100,noRequire");
		map.put("UNIT_NATURE","String,3,noRequire");
		map.put("ADDRESS","String,120,noRequire");
		map.put("AFFILIATION","String,3,noRequire");
		map.put("CONTACT_PHONE","String,20,noRequire");
		map.put("CONTACT_PEOPLE","String,30,noRequire");
		map.put("SCHOOL","String,100,noRequire");
		map.put("SCHOOL_TYPE","String,3,noRequire");
		map.put("CONTACT_PEOPLE_EDU","String,30,noRequire");
		map.put("CONTACT_PHONE_EDU","String,20,noRequire");
		map.put("ENTRANCE_DATE","String,10,noRequire");
		map.put("INSURANCE_TYPE","String,3,noRequire");
		map.put("INSURANCE_FEE","int,10,noRequire");
		map.put("INSURANCE_CYCLE","String,3,noRequire");
		map.put("REMARKS","String,200,noRequire");
		map.put("PROPERTY_OWNER","String,50,noRequire");
		map.put("HOUSE_QUALITY","String,3,noRequire");
		map.put("PROPERTY_CERTIFICATE","String,50,noRequire");
		map.put("HOUSE_ADD","String,100,noRequire");
		map.put("BUILD_AREA","int,10,noRequire");
		map.put("USE_AREA","int,10,noRequire");
		map.put("ESTATE_TYPE","String,3,noRequire");
		map.put("SUPPORTED_PEOPLE","String,30,noRequire");
		map.put("RELATION","String,3,noRequire");
		map.put("SUPPORTED_PAY","int,10,noRequire");
	}
	/**
	 * @param Xml格式字符串
	 * @return 对于数据处理的结果，Xml格式字符串
	 */
	@SuppressWarnings("unchecked")
	public String sendSamExternalInfo(String xml) {
		String FAMILY_ID= "";
		
		StringBuffer returnXML = new StringBuffer("");
		returnXML.append("<?xml version='1.0' encoding='UTF-8'?>");
		returnXML.append("<RESULT>");
		
		StringBuffer errorLog = new StringBuffer();// 错误log
		Map<String, String> familycontextMap = new HashMap<String, String>();// 存放家庭数据的map
		Map<String, String> peoplecontextMap = new HashMap<String, String>();// 存放单个人员属性的map
		Map<String, String> insuranceListMap = new HashMap<String, String>();// 存放单个人员保障性支出属性的map
		Map<String, String> houseMap = new HashMap<String, String>();// 存放家庭房屋属性的map
		Map<String, String> estateMap = new HashMap<String, String>();// 存放家庭财产属性的map
		Map<String, String> supportMap = new HashMap<String, String>();// 存放家庭赡（抚、扶）养义务人员属性的map

		ArrayList<Map> peopleList = new ArrayList<Map>();// 存放多个人员的list
		ArrayList<Map> insuranceList = new ArrayList<Map>();// 存放多个人员保障性支出的list
		ArrayList<Map> houseList = new ArrayList<Map>();// 存放多个家庭房屋的list
		ArrayList<Map> estateList = new ArrayList<Map>();// 存放多个家庭财产的list
		ArrayList<Map> supportList = new ArrayList<Map>();// 存放多个赡（抚、扶）养义务人员的list

		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();

		Map<String,Object> isExist = new HashMap<String, Object>();//用来校验节点传没传
		isExist.put("DOMICILE_CODE",false);
		isExist.put("BEGIN_DATE",false);
		isExist.put("ASSISTANCE_TYPE",false);
		isExist.put("FAMILY_ID",false);
		isExist.put("PEOPLE_ID",false);
		isExist.put("PERSONAL_STATS_TAG",false);
		isExist.put("RELATIONSHIP_TYPE",false);
		isExist.put("NAME",false);
		isExist.put("ID_CARD",false);
		isExist.put("IS_ASSISTANCE",false);
		
		try {
			DocumentBuilder builder = factory.newDocumentBuilder();
			Document doc = builder
					.parse(new InputSource(new StringReader(xml)));
			Element root = doc.getDocumentElement();// 得到文档对象树。

			// 处理家庭
			NodeList familyList = root.getElementsByTagName("SAM_FAMILY");
			for (int i = 0; i < familyList.getLength(); i++) {
				Element familyE = (Element) familyList.item(i);
				NodeList nodes = familyE.getChildNodes();
				for (int j = 0; j < nodes.getLength(); j++) {
					if (nodes.item(j).getNodeType() == Node.ELEMENT_NODE) {
						String nodeName = nodes.item(j).getNodeName();
						String nodeText = nodes.item(j).getTextContent();
						if("FAMILY_ID".equals(nodeName)){
							FAMILY_ID = nodeText;
							isExist.put("FAMILY_ID",true);
						}
						if("BEGIN_DATE".equals(nodeName)){
							isExist.put("BEGIN_DATE",true);
						}
						if("ASSISTANCE_TYPE".equals(nodeName)){
							isExist.put("ASSISTANCE_TYPE",true);
						}
						if("DOMICILE_CODE".equals(nodeName)){
							isExist.put("DOMICILE_CODE",true);
						}
						errorLog = checkOut(nodeName, nodeText, errorLog);// 校验取到的值
						familycontextMap.put(nodeName, nodeText);
					}
				}
			}
			// 处理人员
			NodeList peoplenodeList = root.getElementsByTagName("SAM_PEOPLE");
			for (int i = 0; i < peoplenodeList.getLength(); i++) {
				peoplecontextMap = new HashMap<String, String>();// 存放单个人员属性的map
				NodeList nodes = peoplenodeList.item(i).getChildNodes();
				for (int j = 0; j < nodes.getLength(); j++) {
					if (nodes.item(j).getNodeType() == Node.ELEMENT_NODE) {
						// 判断人员保障性支出多条的情况
						if (nodes.item(j).getNodeName().equals(
								"PEOPLE_INSURANCE")) {
							NodeList insuranceNodes = nodes.item(j)
									.getChildNodes();
							insuranceListMap = new HashMap<String, String>();// 存放单个人员保障性支出属性的map
							for (int k = 0; k < insuranceNodes.getLength(); k++) {
								if (insuranceNodes.item(k).getNodeType() == Node.ELEMENT_NODE) {
									String insuranceName = insuranceNodes.item(
											k).getNodeName();
									String insuranceText = insuranceNodes.item(
											k).getTextContent();
									errorLog = checkOut(insuranceName,
											insuranceText, errorLog);// 校验取到的值
									insuranceListMap.put(insuranceName,
											insuranceText);
								}
							}
							insuranceList.add(insuranceListMap);
						} else {
							String nodeName = nodes.item(j).getNodeName();
							String nodeText = nodes.item(j).getTextContent();
							if ("PEOPLE_ID".equals(nodeName)) {
								isExist.put("PEOPLE_ID", true);
							}
							if ("PERSONAL_STATS_TAG".equals(nodeName)) {
								isExist.put("PERSONAL_STATS_TAG", true);
							}
							if ("RELATIONSHIP_TYPE".equals(nodeName)) {
								isExist.put("RELATIONSHIP_TYPE", true);
							}
							if ("NAME".equals(nodeName)) {
								isExist.put("NAME", true);
							}
							if ("ID_CARD".equals(nodeName)) {
								isExist.put("ID_CARD", true);
							}
							if ("IS_ASSISTANCE".equals(nodeName)) {
								isExist.put("IS_ASSISTANCE", true);
							}
							errorLog = checkOut(nodeName, nodeText, errorLog);// 校验取到的值
							peoplecontextMap.put(nodeName, nodeText);
						}
					}
				}
				peopleList.add(peoplecontextMap);
			}
			// 处理家庭房屋
			NodeList housenodeList = root.getElementsByTagName("FAMILY_HOUSE");
			for (int i = 0; i < housenodeList.getLength(); i++) {
				houseMap= new HashMap<String, String>();
				NodeList nodes = housenodeList.item(i).getChildNodes();
				for (int j = 0; j < nodes.getLength(); j++) {
					if (nodes.item(j).getNodeType() == Node.ELEMENT_NODE) {
						String nodeName = nodes.item(j).getNodeName();
						String nodeText = nodes.item(j).getTextContent();
						errorLog = checkOut(nodeName, nodeText, errorLog);// 校验取到的值
						houseMap.put(nodeName, nodeText);
					}
				}
				houseList.add(houseMap);
			}
			// 处理家庭财产
			NodeList estatenodeList = root
					.getElementsByTagName("FAMILY_ESTATE");
			for (int i = 0; i < estatenodeList.getLength(); i++) {
				estateMap= new HashMap<String, String>();
				NodeList nodes = estatenodeList.item(i).getChildNodes();
				for (int j = 0; j < nodes.getLength(); j++) {
					if (nodes.item(j).getNodeType() == Node.ELEMENT_NODE) {
						String nodeName = nodes.item(j).getNodeName();
						String nodeText = nodes.item(j).getTextContent();
						errorLog = checkOut(nodeName, nodeText, errorLog);// 校验取到的值
						estateMap.put(nodeName, nodeText);
					}
				}
				estateList.add(estateMap);
			}
			// 处理赡（抚、扶）养义务人员信息
			NodeList supportnodeList = root
					.getElementsByTagName("FAMILY_SUPPORT");
			for (int i = 0; i < supportnodeList.getLength(); i++) {
				supportMap= new HashMap<String, String>();
				NodeList nodes = supportnodeList.item(i).getChildNodes();
				for (int j = 0; j < nodes.getLength(); j++) {
					if (nodes.item(j).getNodeType() == Node.ELEMENT_NODE) {
						String nodeName = nodes.item(j).getNodeName();
						String nodeText = nodes.item(j).getTextContent();
						errorLog = checkOut(nodeName, nodeText, errorLog);// 校验取到的值
						
						supportMap.put(nodeName, nodeText);
					}
				}
				supportList.add(estateMap);
			}
			Set set = isExist.keySet();
			  for(Iterator iter = set.iterator(); iter.hasNext();)
			  {
			   String key = (String)iter.next();
			   Boolean value = (Boolean)isExist.get(key);
			   if(!value){
				   errorLog.append(key);
				   errorLog.append("节点是必填的，请检查！");
			   }
			  }
			  
			if(errorLog.length() >0){//
				returnXML.append("<CODE>03000</CODE><ERROR>");
				
				returnXML.append("FAMILY_ID 为： ");
				returnXML.append(FAMILY_ID);
				returnXML.append("的家庭");
				returnXML.append(errorLog);
				returnXML.append("</ERROR></RESULT>");
				return returnXML.toString();
			}else{
				SamApplyInfo samApplyInfo = conversionInfo(familycontextMap, peopleList, insuranceList,
						houseList, estateList, supportList);// 转换数据
				
				returnXML = saveAllInfo(samApplyInfo,returnXML);
			
			}
		} catch (Exception e) {
			e.printStackTrace();
			returnXML.append("<CODE>03000</CODE><ERROR>");
			returnXML.append(e.getMessage());
			returnXML.append("</ERROR>");
		} 
		//returnXML.append("<CODE>00000</CODE>");
		returnXML.append("</RESULT>");
		return returnXML.toString();
		
	}
	/**
	 * 校验取到的值是否符合条件
	 * 
	 * @param nodeValue
	 *            取到的节点名字
	 * @param nodeText
	 *            取到的值
	 * @param errorLog
	 *            错误日志
	 * @return 有错误的返回error 没有错误的返回正确的值
	 */
	private StringBuffer checkOut(String nodeValue, String nodeText,
			StringBuffer errorLog) {
		String checkRule = (String)map.get(nodeValue);
		Object strs[ ] = checkRule.split(",");
		String valueType = (String)strs[0];
		int valueLength =   Integer.parseInt((String)strs[1]);
		String isNullable = (String)strs[2];
		
		if(null != valueType && !"".equals(valueType) && "String".equals(valueType)){
			
			if("DOMICILE_CODE".equals(nodeValue)){
				 String apanageName = DicUtil.getTextValueFromDic("DIC_CITY", "ID",nodeText, "NAME");
				 if( apanageName == null || "".equals(apanageName)){
					 errorLog.append("行政区划与金民工程不对应，请检查！");
				 }
			}
			
			if(nodeText.length()>valueLength){
				errorLog.append(nodeValue);
				errorLog.append("字段长度过长，请检查！");
			}else if(nodeText.length() ==0 && null != isNullable && !"".equals(isNullable) && "require".equals(isNullable)){
				errorLog.append(nodeValue);
				errorLog.append("字段非空，请检查并重新输入！");
			}
		}else if(null != valueType && !"".equals(valueType) && "int".equals(valueType)){
			if(!isNum(nodeText)){
				errorLog.append(nodeValue);
				errorLog.append("字段不符合规范,该字段为数字且长度小于10并精确到小数点后两位！");
			}else if(SamDataExchange.isNum(nodeText) && nodeText.length() ==0 && null != isNullable && !"".equals(isNullable) && "require".equals(isNullable)){
				errorLog.append(nodeValue);
				errorLog.append("字段非空，请检查并重新输入！");
			}
		}
		return errorLog;
	}
	/**
	 * 
	 * @param familycontextMap 存放家庭的map
	 * @param peopleList 存放人员的List
	 * @param insuranceList  存放多个人员保障性支出的list
	 * @param houseList 存放多个家庭房屋的list
	 * @param estateList 存放多个家庭财产的list
	 * @param supportList 存放多个赡（抚、扶）养义务人员的list
	 * @return SamApplyInfo 格式的数据
	 */
	@SuppressWarnings("unchecked")
	private SamApplyInfo conversionInfo(Map<String, String> familycontextMap,
			ArrayList<Map> peopleList, ArrayList<Map> insuranceList,
			ArrayList<Map> houseList, ArrayList<Map> estateList,
			ArrayList<Map> supportList) {
		SamApplyInfo samApplyInfo = new SamApplyInfo();
		BaseinfoFamily baseinfoFamily = new BaseinfoFamily();
		SamBankAccount bank = new SamBankAccount();
		bank.setAccountId(IdHelp.getUUID32());
		samApplyInfo.setApplyId(IdHelp.getUUID32());
		
		//遍历家庭信息
		Iterator it = familycontextMap.entrySet().iterator();
		while (it.hasNext()) {
		   Map.Entry entry = (Map.Entry) it.next();  
		   Object key = entry.getKey();  
		   Object value = entry.getValue();  
		   if("APANAGE_CODE".equals(key)){
			   baseinfoFamily.setApanageCode((String)value);
			   String apanageName = DicUtil.getTextValueFromDic("DIC_CITY", "ID",(String)value, "NAME");
			   baseinfoFamily.setApanageName(apanageName);
		   }
		   if("DOMICILE_CODE".equals(key)){
			   baseinfoFamily.setDomicileCode((String)value);
			   String domicileName = DicUtil.getTextValueFromDic("DIC_CITY", "ID",(String)value, "NAME");
			   baseinfoFamily.setDomicileName(domicileName);
			   samApplyInfo.setDomicileCode((String)value);
			   samApplyInfo.setDomicileName(domicileName);
		   }
		   if("ADDRESS".equals(key)){
			   baseinfoFamily.setAddress((String)value);
		   }
		   if("FAMILY_POSTCODE".equals(key)){
			   baseinfoFamily.setFamilyPostcode((String)value);
		   }
		   if("FAMILY_PHONE".equals(key)){
			   baseinfoFamily.setFamilyPhone((String)value);
		   }
		   if("FAMILY_MOBILE".equals(key)){
			   baseinfoFamily.setFamilyMobile((String)value);
		   }
		   if("POVERTY_CAUSE".equals(key)){
			   baseinfoFamily.setPovertyCause((String)value);
		   }
		   if("BELONGING".equals(key)){
			   baseinfoFamily.setBelonging((String)value);
		   }
		   if("ASSISTANCE_CLASS".equals(key)){
			   baseinfoFamily.setAssistanceClass((String)value);
		   }
		   if("ASSISTANCE_CLASS_MONEY".equals(key)){
			   baseinfoFamily.setAssistanceClassMoney(value==""?new BigDecimal(0):new BigDecimal((String)value));
			   samApplyInfo.setAssistanceClassMoney(value==""?new BigDecimal(0):new BigDecimal((String)value));
		   }
		   if("APPLY_DATE".equals(key)){
			   baseinfoFamily.setApplyDate((String)value);
			   samApplyInfo.setApplyDate((String)value);
		   }
		   if("APPLY_REASON".equals(key)){
			   baseinfoFamily.setApplyReason((String)value);
			   samApplyInfo.setApplyReason((String)value);
		   } 
		   if("CARD_NO".equals(key)){
			   baseinfoFamily.setCardNo((String)value);
			   samApplyInfo.setCardNo((String)value);
		   }
		   if("BEGIN_DATE".equals(key)){
			   baseinfoFamily.setBeginDate((String)value);
			   samApplyInfo.setBeginDate((String)value);
		   }
		   if("END_DATE".equals(key)){
			   baseinfoFamily.setEndDate((String)value);
		   }
		   if("SUPPORT_WAY".equals(key)){
			   samApplyInfo.setSupportWay((String)value);
		   }
		   if("SUPPORT_ORG".equals(key)){
			   samApplyInfo.setSupportOrg((String)value);
		   }
		   if("ASSISTANCE_MODE".equals(key)){
			   baseinfoFamily.setAssistanceMode((String)value);
			   samApplyInfo.setAssistanceMode((String)value);
		   }
		   if("ASSISTANCE_MONEY".equals(key)){
			   baseinfoFamily.setAssistanceMoney(value==""?new BigDecimal(0):new BigDecimal((String)value));
			   samApplyInfo.setAssistanceMoney(value==""?new BigDecimal(0):new BigDecimal((String)value));
		   }
		   if("FAMILY_ASSISTANCE_TYPE".equals(key)){//家庭类型
			   //TODO 家庭类型
		   } 
		   if("BANK".equals(key)){
			   bank.setBank((String)value);
		   }
		   if("ACCOUNT_NAME".equals(key)){
			   bank.setAccountName((String)value); 
		   }
		   if("ACCOUNT_NUMBER".equals(key)){
			   bank.setAccountNumber((String)value);
		   }
		   if("ASSISTANCE_TYPE".equals(key)){
			   baseinfoFamily.setAssistanceType((String)value);
			   bank.setAssistanceType((String)value);
			   //处理业务的applyType
			   samApplyInfo.setApplyType((String)value);
		   }
		   if("FAMILY_ID".equals(key)){
			   baseinfoFamily.setFamilyId((String)value);
			   samApplyInfo.setFamilyId((String)value);
		   }
		}
		//处理人员
		List<BaseinfoPeople> baseinfoPeopleList = conversionPeople(peopleList);
		
		//处理保障性支出信息
		List<SamPeopleInsurance> peopleInsuranceList = conversionInsurance(insuranceList);
		int assistanceTypeNumber = 0;//计算保障对象人数
		//处理户主的情况
		for (int i = 0; i < baseinfoPeopleList.size(); i++) {
			BaseinfoPeople b = baseinfoPeopleList.get(i);
			List<SamPeopleInsurance> inList = new ArrayList<SamPeopleInsurance>();
			b.setFamilyId(baseinfoFamily.getFamilyId());
			b.setDomicileCode(baseinfoFamily.getDomicileCode());
			b.setDomicileName(baseinfoFamily.getDomicileName());
			if("01".equals(b.getRelationshipType())){
				baseinfoFamily.setFamilyCardNo(b.getIdCard());
				baseinfoFamily.setFamilyCardType(b.getIdCardType());
				baseinfoFamily.setFamilyName(b.getName());
				
				samApplyInfo.setFamilyCardNo(b.getIdCard());
				samApplyInfo.setFamilyName(b.getName());
			}
			if("1".equals(b.getSamPeopleExtend().getIsAssistance())){ // 如果人员是保障对象
				assistanceTypeNumber++;
			}
			for (int j = 0; j < peopleInsuranceList.size(); j++) {
				SamPeopleInsurance  in = peopleInsuranceList.get(j);
				if(b.getPeopleId() == in.getPeopleId()){
					inList.add(in);
				}
			}
			b.setSamPeopleInsuranceList(inList);//将保障性支出放入人员
		}
		baseinfoFamily.setPeopleNum(new BigDecimal(baseinfoPeopleList.size()));//计算家庭人口数
		baseinfoFamily.setAssistancePeopleNum(new BigDecimal(assistanceTypeNumber));//计算保障对象人数
		//
		List<SamFamilyHouse> samhouseList = conversionHouse(houseList);
		List<SamFamilyEstate> samestateList = conversionEstate(estateList);
		List<SamFamilySupport> samsupportList = conversionSupport(supportList);
		
		//处理默认值
		for (int i = 0; i < samhouseList.size(); i++) {
			SamFamilyHouse h = samhouseList.get(i);
			h.setHouseId(IdHelp.getUUID32());
			h.setFamilyId(baseinfoFamily.getFamilyId());
		}
		for (int i = 0; i < samestateList.size(); i++) {
			SamFamilyEstate e = samestateList.get(i);
			e.setEstateId(IdHelp.getUUID32());
			e.setFamilyId(baseinfoFamily.getFamilyId());
		}
		for (int i = 0; i < samsupportList.size(); i++) {
			SamFamilySupport f = samsupportList.get(i);
			f.setSupportId(IdHelp.getUUID32());
			f.setFamilyId(baseinfoFamily.getFamilyId());
		}
		samApplyInfo.setIsFinish("1");
		bank.setAccountStatus("1");
		bank.setReleaseWay("01");
		
		baseinfoFamily.setSamPeopleList(baseinfoPeopleList);
		baseinfoFamily.setSamhouseList(samhouseList);
		baseinfoFamily.setSamestateList(samestateList);
		baseinfoFamily.setSamsupportList(samsupportList);
		
		samApplyInfo.setSamBankAccount(bank);
		samApplyInfo.setBaseInfoFamily(baseinfoFamily);
		
		return samApplyInfo;
	}
	/**
	 * 
	 * @param samApplyInfo
	 * @param errorLog
	 * @return 
	 */
	private StringBuffer saveAllInfo(SamApplyInfo samApplyInfo,StringBuffer returnXML) {
		returnXML=handleFamily(samApplyInfo,returnXML);//处理家庭基本信息
		handlePeople(samApplyInfo);//
		//根据人员月收入更新家庭收入
		baseinfoDomain.updateIncomeByMonth(samApplyInfo.getFamilyId());
		//更新家庭人口信息
		baseinfoDomain.updatePeopleNum(samApplyInfo.getFamilyId());
		handleBank(samApplyInfo);//处理银行信息
		handleApply(samApplyInfo);//处理业务信息
		handleFamilyHouse(samApplyInfo);
		handleFamilyEstate(samApplyInfo);
		handleFamilySupport(samApplyInfo);
		resolveTreatment(samApplyInfo);
		//插入特定的救助类型 
		insertSpecialAssistance(samApplyInfo);
		//调用存储过程把记录保存到备用表中
		samApplyInfoDomain.toDuplicateRecord(samApplyInfo);
		
		return returnXML ;
	}
	/**
	 * 插入特定救助类型
	 */
	private void insertSpecialAssistance(SamApplyInfo applyInfo){
		samFamilyAssistanceDomain.deleteByFamilyId(applyInfo.getFamilyId());
		SamFamilyAssistance samFamilyAssistance=new SamFamilyAssistance();
		samFamilyAssistance.setFamilyId(applyInfo.getFamilyId());
		samFamilyAssistance.setAssistanceType(applyInfo.getBaseInfoFamily().getAssistanceType());
		samFamilyAssistance.setCardNo(applyInfo.getCardNo());
		samFamilyAssistance.setAssistanceMon(applyInfo.getAssistanceMoney());
		samFamilyAssistance.setAssistanceClassMon(applyInfo.getAssistanceClassMoney());
		samFamilyAssistance.setAssistanceBegin(applyInfo.getBeginDate());
		samFamilyAssistanceDomain.insert(samFamilyAssistance);
	}
	/**
	 * 处理家庭待遇信息
	 * @param baseinfoFamily
	 * @return
	 */
	private void resolveTreatment(SamApplyInfo applyInfo) {
		ParameterSet pset=new ParameterSet();
		samFamilyTreatmentDomain.deleteTreatment(applyInfo.getFamilyId());
		SamFamilyTreatment samFamilyTreatment=new SamFamilyTreatment();
		samFamilyTreatment.setAssistanceMode(applyInfo.getAssistanceMode());
		samFamilyTreatment.setAssistanceMoney(applyInfo.getAssistanceMoney());
		samFamilyTreatment.setAssistanceClassMoney(applyInfo.getAssistanceClassMoney());
		samFamilyTreatment.setAssistancePeopleNum(applyInfo.getAssistancePeopleNum());
		samFamilyTreatment.setDomicileCode(applyInfo.getDomicileCode());
		samFamilyTreatment.setBeginDate(applyInfo.getBeginDate());
		samFamilyTreatment.setCardNo(applyInfo.getCardNo());
		samFamilyTreatment.setAssistanceType(applyInfo.getBaseInfoFamily().getAssistanceType());
		
		if(!"".equals(applyInfo.getBaseInfoFamily().getEndDate()) && applyInfo.getBaseInfoFamily().getEndDate() !=null ){
			samFamilyTreatment.setEndDate(applyInfo.getBaseInfoFamily().getEndDate());
		}else{
			samFamilyTreatment.setEndDate("3000-12");
		}
		samFamilyTreatment.setReleaseWay("01");//发放方式：社会化发放
		
		samFamilyTreatment.setTreatmentId(IdHelp.getUUID32());
		samFamilyTreatment.setFamilyId(applyInfo.getFamilyId());
		samFamilyTreatment.setApplyId(applyInfo.getApplyId());
		samFamilyTreatment.setDataSource("out");//数据来源：out
		samFamilyTreatmentDomain.insert(samFamilyTreatment);
	}
	/**
	 * 
	 * @param samApplyInfo
	 */
	private void handleFamilySupport(SamApplyInfo samApplyInfo) {
		List<SamFamilySupport> samsupportList = samApplyInfo.getSamFamilySupportList();
		samFamilySupportDao.deleteByFamilyId(samApplyInfo.getFamilyId());
		for (int i = 0; i < samsupportList.size(); i++) {
			SamFamilySupport s = samsupportList.get(i);
			samFamilySupportDao.insert(s);
		}
		
	}
	/**
	 * 
	 * @param samApplyInfo
	 */
	private void handleFamilyEstate(SamApplyInfo samApplyInfo) {
		List<SamFamilyEstate> samestateList = samApplyInfo.getSamFamilyEstateList();
		samFamilyEstateDao.deleteByFamilyId(samApplyInfo.getFamilyId());
		for (int i = 0; i < samestateList.size(); i++) {
			SamFamilyEstate s = samestateList.get(i);
			samFamilyEstateDao.insert(s);
		}
		
	}
	/**
	 * 
	 * @param samApplyInfo
	 */
	private void handleFamilyHouse(SamApplyInfo samApplyInfo) {
		List<SamFamilyHouse> samhouseList =samApplyInfo.getSamFamilyHouseList();
		samFamilyHouseDao.deleteByFamilyId(samApplyInfo.getFamilyId());
		for (int i = 0; i < samhouseList.size(); i++) {
			SamFamilyHouse s = samhouseList.get(i);
			samFamilyHouseDao.insert(s);
		}
		
	}
	/**
	 * 
	 * @param samApplyInfo
	 */
	private void handleApply(SamApplyInfo samApplyInfo) {
		ParameterSet pset=new ParameterSet();
		pset.setParameter("FAMILY_ID",samApplyInfo.getFamilyId());
		DataSet ds = baseinfoDomain.queryFamily(pset);
		if(ds.getCount() > 0 ){
			BaseinfoFamily baseinfoFamily = (BaseinfoFamily)ds.getRecord(0).toBean(BaseinfoFamily.class);
			samApplyInfo.setPeopleNum(baseinfoFamily.getPeopleNum());
			samApplyInfo.setAssistancePeopleNum(baseinfoFamily.getAssistancePeopleNum());
		}
		DataSet apds = samApplyInfoDomain.query(pset);
		if(apds.getCount() > 0){
			SamApplyInfo apply = (SamApplyInfo)apds.getRecord(0).toBean(SamApplyInfo.class);
			samApplyInfoDomain.deleteSamApply(apply.getApplyId());
		} 
		samApplyInfoDomain.insert(samApplyInfo);
	}
	/**
	 * 处理银行信息
	 * @param applyInfo
	 */
	private void handleBank(SamApplyInfo applyInfo) {
		SamBankAccount bank=applyInfo.getSamBankAccount();
		ParameterSet pset=new ParameterSet();
		pset.setParameter("FAMILY_ID",applyInfo.getFamilyId());
		DataSet ds=samBankAccountDomain.query(pset);
		if(ds.getCount() == 0){
			bank.setAccountId(IdHelp.getUUID32());
			samBankAccountDomain.insert(bank);
		}else{
			SamBankAccount dataBean = (SamBankAccount)ds.getRecord(0).toBean(SamBankAccount.class);
			dataBean.setBank(bank.getBank());
			dataBean.setAccountName(bank.getAccountName());
			dataBean.setAccountNumber(bank.getAccountNumber());
			samBankAccountDomain.update(dataBean);
		}
	}
	private void handlePeople(SamApplyInfo samApplyInfo) {
		
		List<BaseinfoPeople> baseinfoPeopleList = samApplyInfo.getBaseInfoFamily().getSamPeopleList();
		for (int i = 0; i < baseinfoPeopleList.size(); i++) {
			BaseinfoPeople b = baseinfoPeopleList.get(i);
			handlePeopleBase(b);
			//处理人员扩展信息
			handlePeopleExtend(b);
			//处理人员患病信息
			handlePeopleDisease(b);
			//处理人员残疾信息
			handlePeopleDisability(b);
			//处理人员教育信息
			handlePeopleEdu(b);
			//处理人员收入信息
			handlePeopleIncome(b);
			//处理人员就业信息
			handlePeopleJobs(b);
			//处理人员保险信息
			handlePeopleInsurance(b);	
		}
		
	}
	/**
	 * 
	 * @param b
	 */
	private void handlePeopleBase(BaseinfoPeople b) {
		ParameterSet pset=new ParameterSet();
		pset.setParameter("PEOPLE_ID", b.getPeopleId());
		DataSet ds=baseinfoPeopleDao.query(pset);
		if(ds.getCount() > 0 ){
			b.setModTime(DateUtil.getTime());
			baseinfoPeopleDao.update(b);
		}else{
			baseinfoPeopleDao.insert(b);
		}
		
		
	}
	/**
	 * 处理人员保险信息
	 */
	public void handlePeopleInsurance(BaseinfoPeople baseinfoPeople){
		List<SamPeopleInsurance> peopleInsuranceList =baseinfoPeople.getSamPeopleInsuranceList();
		samPeopleInsuranceDomain.deleteByPeopleId(baseinfoPeople.getPeopleId());
		for (int i = 0; i < peopleInsuranceList.size(); i++) {
			SamPeopleInsurance samPeopleInsurance = peopleInsuranceList.get(i);
			samPeopleInsurance.setInsuranceId(IdHelp.getUUID32());
			samPeopleInsuranceDomain.insert(samPeopleInsurance);
		}		
	}
	/**
	 * 处理人员就业信息
	 */
	private void handlePeopleJobs(BaseinfoPeople baseinfoPeople) {
		SamPeopleJobs peopleJobs=baseinfoPeople.getSamPeopleJobs();
		samPeopleJobsDomain.deleteByPeopleId(baseinfoPeople.getPeopleId());
		if(peopleJobs!=null){
			peopleJobs.setJobId(IdHelp.getUUID32());
			samPeopleJobsDomain.insert(peopleJobs);
		} 
	}
	/**
	 * 处理人员收入信息
	 */
	private void handlePeopleIncome(BaseinfoPeople baseinfoPeople) {
		//人员月收入
		BigDecimal incomeMonth=baseinfoPeople.getIncomeMonth();
		if(incomeMonth!=null&&!"".equals(incomeMonth)){
			SamPeopleIncome peopleIncome=new SamPeopleIncome();
			peopleIncome.setIncomeNum(incomeMonth+"");
			ParameterSet pset=new ParameterSet();
			pset.setParameter("PEOPLE_ID", baseinfoPeople.getPeopleId());
			DataSet ds=samPeopleIncomeDomain.query(pset);
			if (ds.getCount()>0) {
				//修改
				peopleIncome=(SamPeopleIncome) ds.getRecord(0).toBean(SamPeopleIncome.class);
				samPeopleIncomeDomain.update(peopleIncome);
			}else{
				//新增				
				peopleIncome.setIncomeId(IdHelp.getUUID32());
				peopleIncome.setPeopleId(baseinfoPeople.getPeopleId());
				samPeopleIncomeDomain.insert(peopleIncome);
			}			
		}
	}
	/**
	 * 处理人员教育信息
	 */
	private void handlePeopleEdu(BaseinfoPeople baseinfoPeople) {
		SamPeopleEdu peopleEdu=baseinfoPeople.getSamPeopleEdu();
		if(peopleEdu!=null){
			String peopleId=peopleEdu.getPeopleId();
			ParameterSet pset =new ParameterSet();
			pset.setParameter("PEOPLE_ID",peopleId);
			DataSet ds = samPeopleEduDomain.query(pset);
			if(ds.getCount() > 0){
				peopleEdu.setRegDate(DateUtil.getDay());
				samPeopleEduDomain.update(peopleEdu);
			}else{
				peopleEdu.setRegDate(DateUtil.getDay());
				samPeopleEduDomain.insert(peopleEdu);
			}
		}else{
			samPeopleEduDomain.delete(baseinfoPeople.getPeopleId());
		}
	}
	/**
	 * 处理人员残疾信息
	 */
	private void handlePeopleDisability(BaseinfoPeople baseinfoPeople) {
		SamPeopleDisability peopleDisability=baseinfoPeople.getSamPeopleDisability();
		if("".equals(peopleDisability.getDisabilityType()) || "".equals(peopleDisability.getDisabilityLevel()) || peopleDisability.getDisabilityType() == null || peopleDisability.getDisabilityLevel()==null){
			return ;
		}
		if(peopleDisability!=null){
			String peopleId=peopleDisability.getPeopleId();
			ParameterSet pset =new ParameterSet();
			pset.setParameter("PEOPLE_ID",peopleId);
			DataSet ds = samPeopleDisabilityDomain.query(pset);
			if(ds.getCount() > 0){
				samPeopleDisabilityDomain.update(peopleDisability);
			}else{
				samPeopleDisabilityDomain.insert(peopleDisability);
			}
		}else{
			samPeopleDisabilityDomain.delete(baseinfoPeople.getPeopleId());
		}
	}
	/**
	 * 处理人员扩展信息
	 */
	private void handlePeopleExtend(BaseinfoPeople baseinfoPeople){
		SamPeopleExtend peopleExtend=baseinfoPeople.getSamPeopleExtend();
		if(peopleExtend != null){
			samPeopleExtendDomain.deleteByPeopleId(peopleExtend.getPeopleId());
			peopleExtend.setExtnedId(IdHelp.getUUID32());
			samPeopleExtendDomain.insert(peopleExtend);
		}
	}
	/**
	 * 处理人员患病信息
	 */
	private void handlePeopleDisease(BaseinfoPeople baseinfoPeople) {
		SamPeopleDisease peopleDisease=baseinfoPeople.getSamPeopleDisease();
		if(peopleDisease != null){
			String peopleId=peopleDisease.getPeopleId();
			ParameterSet pset =new ParameterSet();
			pset.setParameter("PEOPLE_ID",peopleId);
			DataSet ds = samPeopleDiseaseDomain.query(pset);
			if(ds.getCount() > 0){
				samPeopleDiseaseDomain.update(peopleDisease);
			}else{
				samPeopleDiseaseDomain.insert(peopleDisease);
			}
		}else{
			samPeopleDiseaseDomain.delete(baseinfoPeople.getPeopleId());
		}
	}
	/**
	 * 
	 * @param samApplyInfo
	 * @param errorLog
	 */
	private StringBuffer handleFamily(SamApplyInfo samApplyInfo, StringBuffer returnXML) {
		BaseinfoFamily baseinfoFamily=samApplyInfo.getBaseInfoFamily();
		String familyId=baseinfoFamily.getFamilyId();
		ParameterSet pset =new ParameterSet();
		pset.setParameter("FAMILY_ID",familyId);
		DataSet ds = baseinfoDomain.queryFamily(pset);
		if(ds.getCount() > 0){
			//baseinfoDomain.updateFamily(baseinfoFamily);
			baseinfoFamily.setModTime(DateUtil.getTime());
			try {
				baseInfoFamilyDao.update(baseinfoFamily);
				returnXML.append("<CODE>02000</CODE>");
			} catch (Exception e) {
				returnXML.append("<CODE>02001</CODE><ERROR>");
				returnXML.append(e.getMessage());
				returnXML.append("</ERROR>");
			}
		}else{
			try {
				baseInfoFamilyDao.insert(baseinfoFamily);
				returnXML.append("<CODE>00000</CODE>");
			} catch (Exception e) {
				returnXML.append("<CODE>00001</CODE><ERROR>");
				returnXML.append(e.getMessage());
				returnXML.append("</ERROR>");
			}
		}
		return returnXML;
	}
//TODO ##############################################          ######################################################	
	
	/**
	 * 
	 * @param supportList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	private List<SamFamilySupport> conversionSupport(ArrayList<Map> supportList) {
		List<SamFamilySupport> samsupportList =  new ArrayList<SamFamilySupport>();

		for (int i = 0; i < supportList.size(); i++) {
			SamFamilySupport h = new SamFamilySupport();
			Map<String, String> map =supportList.get(i);
			Iterator it = map.entrySet().iterator();
			while (it.hasNext()) {
				Map.Entry entry = (Map.Entry) it.next();  
			    Object key = entry.getKey();  
			    Object value = entry.getValue();  
			    if("NAME".equals(key)){
			    	h.setName((String)value);
			    }
			    if("ID_CARD".equals(key)){
			    	h.setIdCard((String)value);
			    }
			    if("SUPPORTED_PEOPLE".equals(key)){
			    	h.setSupportedPeople((String)value);
			    }
			    if("RELATION".equals(key)){
			    	h.setRelation((String)value);
			    }
			    if("SUPPORTED_PAY".equals(key)){
			    	h.setSupportedPay(value==""?new BigDecimal(0):new BigDecimal((String)value));
			    }
			}
			samsupportList.add(h);
		}
		return samsupportList;
	}
	/**
	 * 
	 * @param estateList
	 * @return
	 */
	private List<SamFamilyEstate> conversionEstate(ArrayList<Map> estateList) {
		List<SamFamilyEstate> samestateList =  new ArrayList<SamFamilyEstate>();
		for (int i = 0; i < estateList.size(); i++) {
			SamFamilyEstate h = new SamFamilyEstate();
			Map<String, String> map =estateList.get(i);
			Iterator it = map.entrySet().iterator();
			while (it.hasNext()) {
				Map.Entry entry = (Map.Entry) it.next();  
			    Object key = entry.getKey();  
			    Object value = entry.getValue();  
			    if("ESTATE_TYPE".equals(key)){
			    	h.setEstateType((String)value);
			    }
			    if("REMARKS".equals(key)){
			    	h.setRemarks((String)value);
			    }
			}
			samestateList.add(h);
		}
		return samestateList;
	}
	/**
	 * 
	 * @param houseList
	 * @return
	 */
	private List<SamFamilyHouse> conversionHouse(ArrayList<Map> houseList) {
		List<SamFamilyHouse> samhouseList =  new ArrayList<SamFamilyHouse>();
		
		for (int i = 0; i < houseList.size(); i++) {
			SamFamilyHouse h = new SamFamilyHouse();
			Map<String, String> map =houseList.get(i);
			Iterator it = map.entrySet().iterator();
			while (it.hasNext()) {
				Map.Entry entry = (Map.Entry) it.next();  
			    Object key = entry.getKey();  
			    Object value = entry.getValue();  
			    if("PROPERTY_OWNER".equals(key)){
			    	h.setPropertyOwner((String)value);
			    }
			    if("HOUSE_QUALITY".equals(key)){
			    	h.setHouseQuality((String)value);
			    }
			    if("PROPERTY_CERTIFICATE".equals(key)){
			    	h.setPropertyCertificate((String)value);
			    }
			    if("HOUSE_ADD".equals(key)){
			    	h.setHouseAdd((String)value);
			    }
			    if("BUILD_AREA".equals(key)){
			    	h.setBuildArea(value==""?new BigDecimal(0):new BigDecimal((String)value));
			    }
			    if("USE_AREA".equals(key)){
			    	h.setUseArea(value==""?new BigDecimal(0):new BigDecimal((String)value));
			    }
			}
			samhouseList.add(h);
		}
		return samhouseList;
	}
	/**
	 * 处理保障性支出信息
	 * @param insuranceList 
	 * @return
	 */
	private List<SamPeopleInsurance> conversionInsurance(
			ArrayList<Map> insuranceList) {
		List<SamPeopleInsurance> peopleInsuranceList = new ArrayList<SamPeopleInsurance>();
		
		for (int i = 0; i < insuranceList.size(); i++) {
			SamPeopleInsurance peopleInsurance = new SamPeopleInsurance();
			
			Map<String, String> peopleInsuranceMap =insuranceList.get(i);
			Iterator it = peopleInsuranceMap.entrySet().iterator();
			while (it.hasNext()) {
				Map.Entry entry = (Map.Entry) it.next();  
			    Object key = entry.getKey();  
			    Object value = entry.getValue();  
			    if("PEOPLE_ID".equals(key)){
			    	peopleInsurance.setPeopleId((String)value);
			    }
			    if("INSURANCE_TYPE".equals(key)){
			    	peopleInsurance.setInsuranceType((String)value);
			    }
			    if("INSURANCE_FEE".equals(key)){
			    	peopleInsurance.setInsuranceFee((String)value);
			    }
			    if("INSURANCE_CYCLE".equals(key)){
			    	peopleInsurance.setInsuranceCycle((String)value);
			    }
			    if("REMARKS".equals(key)){
			    	peopleInsurance.setRemarks((String)value);
			    }
			}
			peopleInsuranceList.add(peopleInsurance);
		}
		return peopleInsuranceList;
	}
	/**
	 * 处理人员
	 * @param peopleList 存放人员的List
	 * @return 存放人员bean的List
	 */
	@SuppressWarnings("unchecked")
	private List<BaseinfoPeople> conversionPeople(ArrayList<Map> peopleList) {
		List<BaseinfoPeople> baseinfoPeopleList = new ArrayList<BaseinfoPeople>();
		
		//处理人员
		for (int i = 0; i < peopleList.size(); i++) {
			BaseinfoPeople people = new BaseinfoPeople();
			SamPeopleExtend peopleExtend = new SamPeopleExtend();
			SamPeopleDisease peopleDisease = new SamPeopleDisease();
			SamPeopleDisability peopleDisability = new SamPeopleDisability();
			SamPeopleEdu peopleEdu = new SamPeopleEdu();
			SamPeopleJobs peopleJobs = new SamPeopleJobs();
			
			peopleExtend.setExtnedId(IdHelp.getUUID32());
			peopleJobs.setJobId(IdHelp.getUUID32());
			Map<String, String> peoplecontextMap =peopleList.get(i);
			Iterator pit = peoplecontextMap.entrySet().iterator();
			while (pit.hasNext()) {
				Map.Entry entry = (Map.Entry) pit.next();  
			    Object key = entry.getKey();  
			    Object value = entry.getValue();  
			    
			   if("PEOPLE_ID".equals(key)){
				   people.setPeopleId((String)value);
				   peopleExtend.setPeopleId((String)value);
				   peopleDisease.setPeopleId((String)value);
				   peopleDisability.setPeopleId((String)value);
				   peopleEdu.setPeopleId((String)value);
				   peopleJobs.setPeopleId((String)value);
			   }
			   if("RELATIONSHIP_TYPE".equals(key)){
				   people.setRelationshipType((String)value);
			   }
			   if("PERSONAL_STATS_TAG".equals(key)){
				   people.setPersonalStatsTag((String)value);
			   }
			   if("APANAGE_CODE".equals(key)){
				   people.setApanageCode((String)value);
				   String apanageName = DicUtil.getTextValueFromDic("DIC_CITY", "ID",(String)value, "NAME");
				   people.setApanageName(apanageName);
			   }
			   if("NAME".equals(key)){
				   people.setName((String)value);
			   }
			   if("ID_CARD".equals(key)){
				   people.setIdCard((String)value);
				   people.setIdCardType("1");
			   }
			   if("SEX".equals(key)){
				   people.setSex((String)value);
			   }
			   if("NATION".equals(key)){
				   people.setNation((String)value);
			   }
			   if("EDU_CODE".equals(key)){
				   people.setEduCode((String)value);
			   }
			   if("HEALTH_CODE".equals(key)){
				   people.setHealthCode((String)value);
			   }
			   if("MARRIAGE_CODE".equals(key)){
				   people.setMarriageCode((String)value);
			   }
			   if("POLITICAL_CODE".equals(key)){
				   people.setPoliticalCode((String)value);
			   }
			   if("BIRTHDAY".equals(key)){
				   people.setBirthday((String)value);
			   }
			   if("EMPLOYMENT_CODE".equals(key)){
				   people.setEmploymentCode((String)value);
			   }
			   if("LABOR_CAPACITY".equals(key)){
				   peopleExtend.setLaborCapacity((String)value);
			   }
			   if("DISEASE_TYPE".equals(key)){
				   peopleDisease.setDiseaseType((String)value);
			   }
			   if("DISABILITY_TYPE".equals(key)){
				   peopleDisability.setDisabilityType((String)value);
			   }
			   if("DISABILITY_LEVEL".equals(key)){
				   peopleDisability.setDisabilityLevel((String)value);
			   }
			   if("IS_ASSISTANCE".equals(key)){
				   peopleExtend.setIsAssistance((String)value);
			   }
			   if("DOMICILE_TYPE".equals(key)){
				   people.setDomicileType((String)value);
			   }
			   if("EDU_STATUS".equals(key)){
				   peopleEdu.setEduStatus((String)value);
			   }
			   if("EDU_CODE".equals(key)){
				   people.setEduCode((String)value);
			   }
			   if("IS_THREE_NO".equals(key)){
				   peopleExtend.setIsThreeNo((String)value);
			   }
			   if("INCOME_MONTH".equals(key)){
				   people.setIncomeMonth(value==""?new BigDecimal(0):new BigDecimal((String)value));
			   }
			   if("INCOME_YEAR".equals(key)){
				   people.setIncomeYear(value==""?new BigDecimal(0):new BigDecimal((String)value));
			   }
			   if("BELONGING".equals(key)){
				   peopleExtend.setBelonging((String)value);
			   }
			   if("NOTE".equals(key)){
				   people.setNote((String)value);
			   }
			   if("PEOPLE_TYPE".equals(key)){//人员类型
				  //TODO 人员类型
			   }
			   if("SELF_CARE_ABILITY".equals(key)){
				   peopleExtend.setSelfCareAbility((String)value);
			   }
			   if("UNIT_NAME".equals(key)){
				  peopleJobs.setUnitName((String)value);
			   }
			   if("UNIT_NATURE".equals(key)){
				   peopleJobs.setUnitNature((String)value);
			   }
			   if("ADDRESS".equals(key)){
				   peopleJobs.setAddress((String)value);
			   }
			   if("AFFILIATION".equals(key)){
				   peopleJobs.setAffiliation((String)value);
			   }
			   if("CONTACT_PHONE".equals(key)){
				   peopleJobs.setContactPhone((String)value);
			   }
			   if("CONTACT_PEOPLE".equals(key)){
				   peopleJobs.setContactPeople((String)value); 
			   }
			   if("SCHOOL".equals(key)){
				   peopleEdu.setSchool((String)value); 
			   }
			   if("SCHOOL_TYPE".equals(key)){
				   peopleEdu.setSchoolType((String)value); 
			   }
			   if("CONTACT_PEOPLE_EDU".equals(key)){
				   peopleEdu.setConectPeople((String)value); 
			   }
			   if("CONTACT_PHONE_EDU".equals(key)){
				   peopleEdu.setConectPhone((String)value); 
			   }
			   if("ENTRANCE_DATE".equals(key)){
				   peopleEdu.setEntranceDate((String)value); 
			   }
			}
			people.setSamPeopleExtend(peopleExtend);
			people.setSamPeopleDisease(peopleDisease);
			people.setSamPeopleDisability(peopleDisability);
			people.setSamPeopleEdu(peopleEdu);
			people.setSamPeopleJobs(peopleJobs);
			
			baseinfoPeopleList.add(people);
		}
		return baseinfoPeopleList;
	}
	/**
	 * 校验数字类型NUMBER(10,2)
	 * @param str
	 * @return  boolean
	 */
	public static boolean isNum(String str){
		if("".equals(str) || str == null){
			return true;
		}else{
			return str.matches("^(\\d{1,10}+(?:\\.\\d{2})?|-1)$");
		}
	}
	
	
	
	
	
	
	// ***********************************************************************************************
	/**
	 * 
	 * @param idCardNo 身份证号
	 * @return 返回单独的一笔低保家庭信息，格式为Xml格式字符串
	 */
	public String returnSamFamilyInfo(String idCardNo) {
		StringBuffer returnXML = new StringBuffer("");
		returnXML.append("<?xml version='1.0' encoding='UTF-8'?>");
		returnXML.append("<SAM_FAMILY_INFO>");
		
		ParameterSet pset = new ParameterSet();
		pset.setParameter("idCard",idCardNo);
		
		DataSet ds = baseinfoPeopleDao.queryExChangePeople(pset);
		if(ds.getCount() > 0 ){//如果有此人信息
			String applyId = (String)ds.getRecord(0).get("APPLY_ID");
			if(applyId!= null || "".equals(applyId)){
				returnXML.append(getFamilyInfo(applyId));//根据applyId获取家庭信息
				returnXML.append(getPeopleInfo(applyId));//根据applyId获取people信息（可多条）
				returnXML.append(getHousefo(applyId));//根据applyId获取家庭房屋信息（可多条）
				returnXML.append(getEstate(applyId));//根据applyId获取家庭财产信息（可多条）
				returnXML.append(getSupport(applyId));//根据applyId获取赡（抚、扶）养义务人员信息（可多条）
			}else{
				returnXML.append("<ERROR_CODE>101</ERROR_CODE>");
				returnXML.append("<ERROR>数据没有查询到APPLY_ID</ERROR>");
			}
		}else{//如果没有此人信息
			returnXML.append("<ERROR_CODE>001</ERROR_CODE>");
			returnXML.append("<ERROR>没有查到此人信息</ERROR>");
		}
		//37833
		
		returnXML.append("</SAM_FAMILY_INFO>");
		
		return returnXML.toString();
	}
	/**
	 * 根据applyId获取家庭信息
	 * @param applyId
	 * @return 
	 */
	private String getFamilyInfo(String applyId) {
		StringBuffer returnXML = new StringBuffer("");
		returnXML.append("<SAM_FAMILY>");
		DataSet ds = baseInfoFamilyDao.queryFamilyExchange(applyId);
		if(ds.getCount() > 0){
			Record record = ds.getRecord(0);
			Iterator it = record.keys();
			while(it.hasNext()){
				String key = (String)it.next();
				String value = (String)record.get(key);
				returnXML.append("<");
				returnXML.append(key);
				returnXML.append(">");
				returnXML.append(value !=null?value :"");
				returnXML.append("</");
				returnXML.append(key);
				returnXML.append(">");
			}
		   returnXML.append("<FAMILY_ASSISTANCE_TYPE></FAMILY_ASSISTANCE_TYPE>");
		}else{
			returnXML.append("<ERROR_CODE>102</ERROR_CODE>");
			returnXML.append("<ERROR>没有查询到家庭信息</ERROR>");
		}
		returnXML.append("</SAM_FAMILY>");
		return returnXML.toString();
	}
	/**
	 * 根据applyId获取people信息
	 * @param applyId
	 * @return 
	 */
	private String getPeopleInfo(String applyId) {
		StringBuffer returnXML = new StringBuffer("");
		DataSet ds = baseInfoFamilyDao.queryPeopleExchange(applyId);
		if(ds.getCount() > 0){
			for (int i = 0; i < ds.getCount(); i++) {
				returnXML.append("<SAM_PEOPLE>");
				Record record = ds.getRecord(0);
				Iterator it = record.keys();
				while(it.hasNext()){
					String key = (String)it.next();
					String value = (String)record.get(key);
					returnXML.append("<");
					returnXML.append(key);
					returnXML.append(">");
					returnXML.append(value !=null?value :"");
					returnXML.append("</");
					returnXML.append(key);
					returnXML.append(">");
				}
				//保障性支出信息（可多条）
				ParameterSet pset = new ParameterSet();
				String peopleId = (String)record.get("PEOPLE_ID");
				pset.setParameter("PEOPLE_ID", peopleId !=null?peopleId :IdHelp.getUUID32());
				DataSet inserds = samPeopleInsuranceDomain.query(pset);
				for (int j = 0; j < inserds.getCount(); j++) {
					SamPeopleInsurance e = (SamPeopleInsurance)inserds.getRecord(i).toBean(SamPeopleInsurance.class);
					returnXML.append("<PEOPLE_INSURANCE>");
					returnXML.append("<PEOPLE_ID>");
					returnXML.append(peopleId);
					returnXML.append("</PEOPLE_ID>");
					returnXML.append("<INSURANCE_TYPE>");
					returnXML.append(e.getInsuranceType());
					returnXML.append("</INSURANCE_TYPE>");
					returnXML.append("<INSURANCE_FEE>");
					returnXML.append(e.getInsuranceFee());
					returnXML.append("</INSURANCE_FEE>");
					returnXML.append("<INSURANCE_CYCLE>");
					returnXML.append(e.getInsuranceCycle());
					returnXML.append("</INSURANCE_CYCLE>");
					returnXML.append("<REMARKS>");
					returnXML.append(e.getRemarks());
					returnXML.append("</REMARKS>");
					returnXML.append("</PEOPLE_INSURANCE>");
				}
				 returnXML.append("<PEOPLE_TYPE></PEOPLE_TYPE>");
				
				returnXML.append("</SAM_PEOPLE>");
			}
		}else{
			returnXML.append("<SAM_PEOPLE>");
			returnXML.append("<ERROR_CODE>103</ERROR_CODE>");
			returnXML.append("<ERROR>没有查询到人员信息</ERROR>");
			returnXML.append("</SAM_PEOPLE>");
		}
		return returnXML.toString();
	}
	/**
	 * 根据applyId获取家庭房屋信息（可多条）
	 * @param applyId
	 * @return
	 */
	private String getHousefo(String applyId) {
		StringBuffer returnXML = new StringBuffer("");
		DataSet ds = baseInfoFamilyDao.queryHouseExchange(applyId);
		if(ds.getCount() > 0){
			for (int i = 0; i < ds.getCount(); i++) {
				returnXML.append("<FAMILY_HOUSE>");
				Record record = ds.getRecord(0);
				Iterator it = record.keys();
				while(it.hasNext()){
					String key = (String)it.next();
					String value = (String)record.get(key);
					returnXML.append("<");
					returnXML.append(key);
					returnXML.append(">");
					returnXML.append(value !=null?value :"");
					returnXML.append("</");
					returnXML.append(key);
					returnXML.append(">");
				}
				returnXML.append("</FAMILY_HOUSE>");
			}
		}else{
			returnXML.append("<FAMILY_HOUSE>");
			returnXML.append("</FAMILY_HOUSE>");
		}
		return returnXML.toString();
	}
	/**
	 * 根据applyId获取家庭财产信息（可多条）
	 * @param applyId
	 * @return
	 */
	private String getEstate(String applyId) {
		StringBuffer returnXML = new StringBuffer("");
		DataSet ds = baseInfoFamilyDao.queryEstateExchange(applyId);
		if(ds.getCount() > 0){
			for (int i = 0; i < ds.getCount(); i++) {
				returnXML.append("<FAMILY_ESTATE>");
				Record record = ds.getRecord(0);
				Iterator it = record.keys();
				while(it.hasNext()){
					String key = (String)it.next();
					String value = (String)record.get(key);
					returnXML.append("<");
					returnXML.append(key);
					returnXML.append(">");
					returnXML.append(value !=null?value :"");
					returnXML.append("</");
					returnXML.append(key);
					returnXML.append(">");
				}
				returnXML.append("</FAMILY_ESTATE>");
			}
		}else{
			returnXML.append("<FAMILY_ESTATE>");
			returnXML.append("</FAMILY_ESTATE>");
		}
		return returnXML.toString();
	}
	/**
	 * 根据applyId获取赡（抚、扶）养义务人员信息（可多条）
	 * @param applyId
	 * @return
	 */
	private String getSupport(String applyId) {
		StringBuffer returnXML = new StringBuffer("");
		DataSet ds = baseInfoFamilyDao.querySupportExchange(applyId);
		if(ds.getCount() > 0){
			for (int i = 0; i < ds.getCount(); i++) {
				returnXML.append("<FAMILY_HOUSE>");
				Record record = ds.getRecord(0);
				Iterator it = record.keys();
				while(it.hasNext()){
					String key = (String)it.next();
					String value = (String)record.get(key);
					returnXML.append("<");
					returnXML.append(key);
					returnXML.append(">");
					returnXML.append(value !=null?value :"");
					returnXML.append("</");
					returnXML.append(key);
					returnXML.append(">");
				}
				returnXML.append("</FAMILY_SUPPORT>");
			}
		}else{
			returnXML.append("<FAMILY_SUPPORT>");
			returnXML.append("</FAMILY_SUPPORT>");
		}
		return returnXML.toString();
	}
	public static void main(String[] args) {
		SamDataExchange d = new SamDataExchange();
		
		String xml = d.returnSamFamilyInfo("152103197709036678");
	}
}
