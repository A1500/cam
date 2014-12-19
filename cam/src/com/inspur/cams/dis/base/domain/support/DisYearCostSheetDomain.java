package com.inspur.cams.dis.base.domain.support;


import org.loushang.next.dao.DaoFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.dis.base.dao.IDisYearCostSheetDao;
import com.inspur.cams.dis.base.data.DisYearCostSheet;
import com.inspur.cams.dis.base.domain.IDisYearCostSheetDomain;

/**
 * @title:SomAssessTypeDomain
 * @description:
 * @author:
 * @since:2011-12-03
 * @version:1.0
*/
 public class DisYearCostSheetDomain implements IDisYearCostSheetDomain {

	 IDisYearCostSheetDao dao = (IDisYearCostSheetDao) DaoFactory
		.getDao("com.inspur.cams.dis.base.dao.support.DisYearCostSheetDao");

	 @Trans
	 public void save(DisYearCostSheet disYearCostSheet){
		 disYearCostSheet.setId(IdHelp.getUUID32());
		 // 行政区划
		 String organCode = BspUtil.getOrganCode();
		// 填报单位名称
		 String organName = BspUtil.getDeptOrgan().getOrganName();
		// 填报人姓名
		 String fillPeopleName = BspUtil.getEmpOrgan().getOrganName();
		// 填报时间
		 String fillTime = DateUtil.getTime();
		 disYearCostSheet.setOrganName(organName);
		 disYearCostSheet.setFillPeopleName(fillPeopleName);
		 disYearCostSheet.setFillTime(fillTime);
		 disYearCostSheet.setOrganCode(organCode);
		 dao.insert(disYearCostSheet);
	 }
	 
	 @Trans
	 public void update(DisYearCostSheet disYearCostSheet){
		 dao.update(disYearCostSheet);
	 }
	 
	 @Trans
	 public void delete(DisYearCostSheet disYearCostSheet){
		 dao.delete(disYearCostSheet);
	 }
	 
	 @Trans
	 public void batchDelete(String[] delIds){
		 dao.batchDelete(delIds);
	 }
}