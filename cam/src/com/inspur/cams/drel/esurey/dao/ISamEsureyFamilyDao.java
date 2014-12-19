package com.inspur.cams.drel.esurey.dao;

import java.math.BigDecimal;
import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.esurey.data.SamEsureyFamily;

/**
 * @title:ISamEsureyFamilyDao
 * @description:
 * @author:
 * @since:2011-06-29
 * @version:1.0
*/
 public interface ISamEsureyFamilyDao extends BaseCURD<SamEsureyFamily>{
	public void save(List<SamEsureyFamily> list);
	public void delete(String familyId);
	//根据家庭ID数组查找家庭信息
	public DataSet queryByFamilyIds(ParameterSet pset);
	
	public DataSet familySum(String familyId);
	
	public void submit(String familyId,String checkOrgArea,String flag);
	
	public void updateNameOrIdCard(ParameterSet pset);
	
	public DataSet queryStatistics(ParameterSet pset);
	/**
	 * 收入或财产统计
	 */
	public DataSet queryIncomeWorth(ParameterSet pset);
	
	public DataSet queryCredit(ParameterSet pset);
	/**
	 * 查询是否存在相应的信息
	 */
	public BigDecimal beExistMess(String idCard);
	/**
	 * 2-区县经济核对中心上报核对任务到市经济和对中心
	 * @param familyId
	 * @param checkOrgArea
	 */
	public void centerSubmit(String familyId, String checkOrgArea,String flag);
}

