package com.inspur.cams.drel.ensureInfo.domain.support;

import java.io.File;
import java.math.BigDecimal;
import java.net.MalformedURLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.ensureInfo.dao.IEnsureToClientDao;
import com.inspur.cams.drel.ensureInfo.data.EnsureToClient;
import com.inspur.cams.drel.ensureInfo.domain.IEnsureToClientDomain;
import com.inspur.cams.drel.info.data.D204a01;
import com.inspur.cams.drel.info.data.D204b12;
import com.inspur.cams.drel.info.data.D204c21;
import com.inspur.cams.drel.info.data.D204c22;
import com.inspur.cams.drel.info.data.D204d32;
import com.inspur.cams.drel.info.data.D204d34;
import com.inspur.cams.drel.info.data.D204z57;
import com.inspur.cams.drel.info.domain.ID204a01Domain;
import com.inspur.cams.drel.info.domain.ID204b12Domain;
import com.inspur.cams.drel.info.domain.ID204c21Domain;
import com.inspur.cams.drel.info.domain.ID204c22Domain;
import com.inspur.cams.drel.info.domain.ID204d32Domain;
import com.inspur.cams.drel.info.domain.ID204d34Domain;
import com.inspur.cams.drel.info.domain.ID204z57Domain;

/**
 * 核查业务反馈表domain
 * @author 
 * @date 2014-07-23
 */
public class EnsureToClientDomain implements IEnsureToClientDomain {

	@Reference
	private IEnsureToClientDao ensureToClientDao;
	
	@Reference
	private ID204a01Domain d204a01Domain;
	@Reference
	private ID204z57Domain d204z57Domain;
	@Reference
	private ID204c21Domain d204c21Domain;
	@Reference
	private ID204c22Domain d204c22Domain;
	@Reference
	private ID204d32Domain d204d32Domain;
	@Reference
	private ID204d34Domain d204d34Domain;
	@Reference
	private ID204b12Domain d204b12Domain;

	/**
	 * 查询 核查业务反馈表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return ensureToClientDao.query(pset);
	}

	/**
	 * 获取 核查业务反馈表
	 * @param pset
	 * @return
	 */
	public EnsureToClient get(String ensureId) {
		return ensureToClientDao.get(ensureId);
	}

	/**
	 * 增加 核查业务反馈表
	 * @param ensureToClient
	 */
	public void insert(EnsureToClient ensureToClient) {
		ensureToClientDao.insert(ensureToClient);
	}
	
	/**
	 * 修改 核查业务反馈表
	 * @param ensureToClient
	 */
	public void update(EnsureToClient ensureToClient) {
		ensureToClientDao.update(ensureToClient);
	}
	
	/**
	 * 删除 核查业务反馈表
	 * @param ensureId
	 */
	public void delete(String ensureId) {
		ensureToClientDao.delete(ensureId);
	}
	
	//查询核对参考标准
	public DataSet queryInfo(ParameterSet pset){
		return ensureToClientDao.queryInfo(pset);
	}
	
	//核对婚姻信息
	public DataSet queryMarryInfo(ParameterSet pset){
		return ensureToClientDao.queryMarryInfo(pset);
	}
	
	//导入核查信息
	@Trans
	public void importXML(ParameterSet pset){
		String filePath = (String)pset.getParameter("filePath");
		
	  SAXReader saxReader = new SAXReader();
	  
	  List<EnsureToClient> ensureToClientList = new ArrayList<EnsureToClient>();
	  List<D204a01> peopleList = new ArrayList<D204a01>();
	  List<D204z57> salaryList = new ArrayList<D204z57>();
	  List<D204c21> carList = new ArrayList<D204c21>();
	  List<D204c22> houseList = new ArrayList<D204c22>();
	  List<D204d32> insuranceList = new ArrayList<D204d32>();
	  List<D204d34> fundList = new ArrayList<D204d34>();
	  List<D204b12> earningList = new ArrayList<D204b12>();
	  String commissionId = ""; 
	  String peopleId="";
	  try {
	   Document document = saxReader.read(new File(filePath));
	   Element root = document.getRootElement();
	   //遍历根结点（ROWDATA）的所有子节点（肯定是FAMILY节点）
		 for ( Iterator iter = root.elementIterator(); iter.hasNext(); ) {
		     Element element = (Element) iter.next();
		     for ( Iterator iterInner = element.elementIterator(); iterInner.hasNext(); ){
			      Element elementInner = (Element) iterInner.next();
			       
			      if(elementInner.getName().equals("BASE")){
			    	  commissionId= elementInner.element("COMMISSION_CODE").getText();//与apply_id对应
//				      String familyName = elementInner.element("D204A010001").getText();
//				      ParameterSet queryPset = new ParameterSet();
//				      queryPset.setParameter("COMMISSION_ID@=", commissionId);
//				      DataSet ds = ensureToClientDao.query(queryPset);
//				      if(ds.getCount()>0){
//					    	  throw new RuntimeException("户主姓名为："+familyName+"的业务重复");
//				      }
			      }
			      
			      if(elementInner.getName().equals("BASE")){//base节点存放家庭基本信息。
			    	  EnsureToClient ec = new EnsureToClient();
			    	  ec.setEnsureId(IdHelp.getUUID32());
			    	  ec.setCommissionId(elementInner.element("COMMISSION_ID").getText());
			    	  ec.setApplyId(commissionId);
			    	  ec.setFamilyName(elementInner.element("D204A010001").getText());
			    	  ec.setAreaCode("370102000000");//暂时这么写
			    	  ec.setAreaName(elementInner.element("SUBMIT_ORGAN").getText());
			    	  ec.setFamilyIdCard(elementInner.element("D204A010005").getText());
			    	  ec.setAcceptUnit(elementInner.element("ACCEPT_ORGAN_NAME").getText());
			    	  ec.setCurrentStatus(elementInner.element("SUSPICIOUS_FLAG").getText());//疑似状态标识
			    	  ec.setFeedbackTime(DateUtil.getTime());
			    	  ensureToClientList.add(ec);
			      }
			      if(elementInner.getName().equals("PEOPLE")){//people节点存放人员基本信息，车辆，社会保险缴费，经营性收入，房产，财政供养人员工资信息,公积金缴纳情况。。。
			    	  for ( Iterator peoInner = elementInner.elementIterator(); peoInner.hasNext(); ){//遍历PEOPLE节点
			    		  Element elementPeo = (Element) peoInner.next();
			    		  if(elementPeo.getName().equals("D204A01")){//人员基本信息
			    			  peopleId = IdHelp.getUUID32();
			    			  
					    	  D204a01 peopleInfo = new D204a01();
					    	  peopleInfo.setPeopleId(peopleId);
//					    	  peopleInfo.setCommissionId(commissionId);
					    	  peopleInfo.setFamilyId(commissionId);
					    	  peopleInfo.setD204a010001(elementPeo.element("D204A010001").getText());//名字
					    	  peopleInfo.setD204a010002(elementPeo.element("D204A010002").getText());//性别
					    	  peopleInfo.setD204a010005(elementPeo.element("D204A010005").getText());//身份证号
					    	  peopleInfo.setD204a010023(elementPeo.element("D204A010023").getText());//与户主关系
					    	  peopleList.add(peopleInfo);
				    	  }
			    		  
			    		  if(elementPeo.getName().equals("D204Z57")){//财政供养人员工资信息
			    			  
			    			  D204z57 salary = new D204z57();
			    			  salary.setD204z57Id(IdHelp.getUUID32());
			    			  salary.setPeopleId(peopleId);
			    			  salary.setCommissionId(commissionId);
					    	  salary.setD204z570001(elementPeo.element("D204Z570001").getText());//工资发放单位
					    	  salary.setD204z570002(new BigDecimal(elementPeo.element("D204Z570002").getText()==""?"0":elementPeo.element("D204Z570002").getText()));//实发工资
					    	  salary.setD204z570003(elementPeo.element("D204Z570003").getText());//代发银行
					    	  salary.setD204z570004(elementPeo.element("D204Z570004").getText());//银行卡号
					    	  salaryList.add(salary);
				    	  }
			    		  
			    		  if(elementPeo.getName().equals("D204C21")){//车辆
			    			  D204c21 car = new D204c21();
			    			  car.setPeopleId(peopleId);
			    			  car.setD204c21Id(IdHelp.getUUID32());
			    			  car.setCommissionId(commissionId);
			    			  car.setD204c210001(elementPeo.element("D204C210001").getText());//车辆品牌名称
			    			  car.setD204c210003(new BigDecimal(elementPeo.element("D204C210003").getText()==""?"0":elementPeo.element("D204C210003").getText()));//车辆现值
			    			  car.setD204c210002(elementPeo.element("D204C210002").getText());//车牌号码
			    			  car.setD204c210004(elementPeo.element("D204C210004").getText());//机动车类型
					    	  carList.add(car);
				    	  }
			    		  
			    		  
			    		  if(elementPeo.getName().equals("D204C22")){//房产
			    			  D204c22 house = new D204c22();
			    			  house.setD204c22Id(IdHelp.getUUID32());
			    			  house.setPeopleId(peopleId);
			    			  house.setCommissionId(commissionId);
			    			  house.setD204c220001(elementPeo.element("D204C220001").getText());//房产证编号
			    			  house.setD204c220002(elementPeo.element("D204C220002").getText());//房屋坐落位置
			    			  house.setD204c220003(elementPeo.element("D204C220003").getText());//房屋类型
			    			  house.setD204c220005(new BigDecimal(elementPeo.element("D204C220005").getText()==""?"0":elementPeo.element("D204C220005").getText()));//房屋建筑面积
			    			  house.setD204c220008(new BigDecimal(elementPeo.element("D204C220008").getText()==""?"0":elementPeo.element("D204C220008").getText()));//房屋购值
			    			  houseList.add(house);
				    	  }
			    		  
			    		  if(elementPeo.getName().equals("D204D32")){//社会保险缴费
			    			  D204d32 insurance = new D204d32();
			    			  insurance.setD204d32Id(IdHelp.getUUID32());
			    			  insurance.setPeopleId(peopleId);
			    			  insurance.setCommissionId(commissionId);
			    			  insurance.setD204d320002(new BigDecimal(elementPeo.element("D204D320002").getText()==""?"0":elementPeo.element("D204D320002").getText()));//养老保险缴纳金额
			    			  insurance.setD204d320003(new BigDecimal(elementPeo.element("D204D320003").getText()==""?"0":elementPeo.element("D204D320003").getText()));//失业保险缴纳金额
			    			  insurance.setD204d320004(new BigDecimal(elementPeo.element("D204D320004").getText()==""?"0":elementPeo.element("D204D320004").getText()));//医疗保险缴纳金额
			    			  insuranceList.add(insurance);
				    	  }
			    		  
							
						if(elementPeo.getName().equals("D204D34")){//公积金缴纳情况
							  D204d34 fund = new D204d34();
							  fund.setD204d34Id(IdHelp.getUUID32());
							  fund.setPeopleId(peopleId);
							  fund.setCommissionId(commissionId);
							  fund.setD204d340008(elementPeo.element("D204D340008").getText());//个人帐号
							  fund.setD204d340002(new BigDecimal(elementPeo.element("D204D340002").getText()==""?"0":elementPeo.element("D204D340002").getText()));//当前活期余额
							  fund.setD204d340003(new BigDecimal(elementPeo.element("D204D340003").getText()==""?"0":elementPeo.element("D204D340003").getText()));//当前定期余额
							  fund.setD204d340001(new BigDecimal(elementPeo.element("D204D340001").getText()==""?"0":elementPeo.element("D204D340001").getText()));//当前核定月缴存额
							  fundList.add(fund);
				    	 }
						
						
						if(elementPeo.getName().equals("D204B12")){//经营性收入
							  D204b12 earning = new D204b12();
							  earning.setD204b12Id(IdHelp.getUUID32());
							  earning.setPeopleId(peopleId);
							  earning.setCommissionId(commissionId);
							  earning.setD204b120004(elementPeo.element("D204B120004").getText());//企业名称
							  earning.setD204b120008(new BigDecimal(elementPeo.element("D204B120008").getText()==""?"0":elementPeo.element("D204B120008").getText()));//注册资本
							  earning.setD204b120009(new BigDecimal(elementPeo.element("D204B120009").getText()==""?"0":elementPeo.element("D204B120009").getText()));//实收资本
							  earning.setD204b120012(elementPeo.element("D204B120012").getText());//经营范围
							  earningList.add(earning);
				    	 }
			    	  }
			      }
			      
		     }
		 }
		 //插入表数据
		  if(ensureToClientList.size()>0){
			  ensureToClientDao.batchInsert(ensureToClientList);
		  }
		  if(peopleList.size()>0){
			  d204a01Domain.save(peopleList);
		  }
		  if(salaryList.size()>0){
			  d204z57Domain.save(salaryList);
		  }
		  if(carList.size()>0){
			  d204c21Domain.save(carList);
		  }
		  if(houseList.size()>0){
			  d204c22Domain.save(houseList);
		  }
		  if(insuranceList.size()>0){
			  d204d32Domain.save(insuranceList);
		  }
		  if(fundList.size()>0){
			  d204d34Domain.save(fundList);
		  }
		  if(earningList.size()>0){
			  d204b12Domain.save(earningList);
		  }

	  } catch (DocumentException e) {
	   // TODO Auto-generated catch block
	   e.printStackTrace();
	  } catch (MalformedURLException e) {
		// TODO 自动生成的 catch 块
		e.printStackTrace();
	}
	}
	
	//查询疑似信息
	public DataSet querySuspectInfo(ParameterSet pset){
		return ensureToClientDao.querySuspectInfo(pset);
	}
	
	//批量更新
	public void batchUpdate(List list){
		 ensureToClientDao.batchUpdate(list);
	}

}
