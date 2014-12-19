package com.inspur.cams.drel.mbalance.domain.support;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.xml.namespace.QName;

import org.apache.axiom.om.OMAbstractFactory;
import org.apache.axiom.om.OMElement;
import org.apache.axiom.om.OMFactory;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.ws.AxisFault;
import org.loushang.ws.addressing.EndpointReference;
import org.loushang.ws.client.Options;
import org.loushang.ws.rpc.client.RPCServiceClient;
import org.osoa.sca.annotations.Reference;

import bsh.StringUtil;

import org.apache.commons.lang.StringUtils;
import com.inspur.cams.comm.util.StrUtil;
import com.inspur.cams.drel.mbalance.domain.ISamMedicalConConfigDomain;

/**
 * 一站式救助domain接口
 * @author luguosui
 *
 */
public class SamInsuranceDomain {
	@Reference
	private ISamMedicalConConfigDomain conConfigDomain;
	private Log logger = LogFactory.getLog(getClass());
	/**
	 * 获取新农合、医保系统数据
	 * @param pset
	 * @return
	 */
	
	public DataSet getInsuranceDataSet(ParameterSet pset){
		List list = getInsuranceData(pset);
		if(list==null||list.size()==0){
			throw new RuntimeException("未查询到新农合、医保系统数据！");
		}
		DataSet ds = new DataSet();
		ds.setTotalCount(list.size());
		ds.getRecordSet().addAll(list);
		return ds;

	}
	
	/**
	 * 获取新农合、医保系统数据
	 * @param pset
	 * @return
	 */
	public List getInsuranceData(ParameterSet pset){
		String organArea = (String) pset.get("organArea");
		String insuranceType = (String) pset.get("insuranceType");
		if("".equals(StrUtil.n2b(insuranceType))){
			insuranceType="4";
		}
		Map configMap = conConfigDomain.queryConConfig(organArea, insuranceType);
		if(configMap==null){
			if (logger.isErrorEnabled()) {
				logger.error("未查询到新农合、医保系统连接配置！");
			}
			throw new RuntimeException("未查询到新农合、医保系统连接配置！");
		}
		if ("3".equals((String) configMap.get("CON_MOD"))) {
			return getDataByWebservice(pset,configMap);
		}else{			
			return null;
		}
	}
	
	private List getDataByWebservice(ParameterSet pset,Map configMap){
		String queryType = (String) pset.getParameter("queryType");	//查询类型 IN：入院备案信息，LEAVE：出院结算信息，EXPENSE：费用明细信息	
		String insuranceCode = (String) pset.getParameter("insuranceCode");//医疗证号
		String inDate = (String) pset.getParameter("inDate");//入院日期
		String url = (String) configMap.get("CON_URL");//连接url endPoint
		String defaultNamespace = (String) configMap.get("DEFAULT_NAMESPACE");
		// 使用RPC方式调用WebService
		RPCServiceClient serviceClient = null;
		try {
			serviceClient = new RPCServiceClient();
			OMFactory factory = OMAbstractFactory.getOMFactory();
			String conUser = (String) configMap.get("CON_USER");
			String conPwd = (String) configMap.get("CON_PWD");
			if(!"".equals(StrUtil.n2b(conUser))){
				//SOAPHeader			
				OMElement headerE = factory.createOMElement(new QName(null,"MyHeader"));
				headerE.declareDefaultNamespace(defaultNamespace);
				//用户名
				OMElement userNameE = factory.createOMElement(new QName("Username"));		
				userNameE.setText(conUser);
				userNameE.declareDefaultNamespace(defaultNamespace);
				headerE.addChild(userNameE);
				//密码
				OMElement passwordE = factory.createOMElement(new QName("Password"));
				passwordE.declareDefaultNamespace(defaultNamespace);
				passwordE.setText(conPwd);			
				headerE.addChild(passwordE);
				//添加SOAPHeader
				serviceClient.addHeader(headerE);
			}
			//SOAPBody			
			Options options = serviceClient.getOptions();  
			options.setTimeOutInMilliSeconds(1000*30);
			options.setAction((String) configMap.get("SOAP_ACTION"));//指定SOAPAction
			EndpointReference targetEPR = new EndpointReference(url);
			options.setTo(targetEPR);
			//
			OMElement queryE = factory.createOMElement(new QName(null,"queryInsurance"));
			queryE.declareDefaultNamespace(defaultNamespace);
			//添加查询条件queryType并赋值
			OMElement queryTypeE = factory.createOMElement(new QName(null,"queryType"));
			queryTypeE.declareDefaultNamespace(defaultNamespace);
			queryTypeE.setText(queryType);
			queryE.addChild(queryTypeE);
			//添加查询条件insuranceCode并赋值
			OMElement insuranceCodeE = factory.createOMElement(new QName(null,"insuranceCode"));
			insuranceCodeE.declareDefaultNamespace(defaultNamespace);
			insuranceCodeE.setText(insuranceCode);
			queryE.addChild(insuranceCodeE);
			//添加查询条件inDate并赋值
			OMElement inDateE = factory.createOMElement(new QName(null,"inDate"));
			inDateE.declareDefaultNamespace(defaultNamespace);
			inDateE.setText(inDate);			
			queryE.addChild(inDateE);			
			logger.debug("医疗证号："+insuranceCode+"，入院日期："+inDate);
			OMElement result = serviceClient.sendReceive(queryE);
			String infoXML = result.getFirstElement().getText();
			logger.debug("返回值："+infoXML);
			//解析返回值
			Document document = DocumentHelper.parseText(infoXML);
			Element root = document.getRootElement();
			Iterator it = root.elements().iterator();
			ArrayList<Record> list = new ArrayList<Record>();
			while (it.hasNext()) {
				Element info = (Element) it.next();
				Iterator adjs = info.elements().iterator();
				Record record = new Record();
				while (adjs.hasNext()) {
					Element adj = (Element) adjs.next();
					record.set(adj.getName().toUpperCase(), strFilter(adj.getText()));
				}
				list.add(record);
			}
			return list;
		} catch (DocumentException e1) {
			if (logger.isErrorEnabled()) {
				logger.error("医保、新农合系统返回结果解析异常！", e1);
			}
			throw new RuntimeException("医保、新农合系统未返回查询结果！");
		} catch (AxisFault e) {
			if (logger.isErrorEnabled()) {
				logger.error("连接医保、新农合系统超时！", e);
			}
			throw new RuntimeException("连接医保、新农合系统超时！");
		} catch (Exception e) {
			if (logger.isErrorEnabled()) {
				logger.error("其他系统错误！", e);
			}
			throw new RuntimeException("其他系统错误！");
		} finally {
			// 释放资源
			try{
				if(serviceClient!=null){
					serviceClient.cleanup();
					serviceClient.cleanupTransport();
				}
			} catch (Exception e){
				if (logger.isErrorEnabled()) {
					logger.error("释放serviceClient错误！", e);
				}
			}

		}
		
	}
	
	private String strFilter(String str){
		if("null".equalsIgnoreCase(str)){
			return "";
		}
		return StrUtil.n2b(str);
		
	}
	
	
}
