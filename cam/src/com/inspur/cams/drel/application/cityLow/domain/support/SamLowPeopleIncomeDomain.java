package com.inspur.cams.drel.application.cityLow.domain.support;

import java.util.HashMap;
import java.util.Map;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;


import com.inspur.cams.comm.baseinfo.dao.IBaseinfoPeopleDao;
import com.inspur.cams.drel.application.cityLow.dao.ISamLowPeopleIncomeDao;
import com.inspur.cams.drel.application.cityLow.data.SamLowPeopleIncome;
import com.inspur.cams.drel.application.cityLow.domain.ISamLowPeopleIncomeDomain;

/**
 * 低收入家庭成员可支配收入表domain
 * @author 
 * @date 2014-03-11
 */
public class SamLowPeopleIncomeDomain implements ISamLowPeopleIncomeDomain {

	@Reference
	private ISamLowPeopleIncomeDao samLowPeopleIncomeDao;
	@Reference
	private IBaseinfoPeopleDao baseinfoPeopleDao;
	/**
	 * 查询 低收入家庭成员可支配收入表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return samLowPeopleIncomeDao.query(pset);
	}

	/**
	 * 获取 低收入家庭成员可支配收入表
	 * @param pset
	 * @return
	 */
	public SamLowPeopleIncome get(String incomeId) {
		return samLowPeopleIncomeDao.get(incomeId);
	}

	/**
	 * 增加 低收入家庭成员可支配收入表
	 * @param samLowPeopleIncome
	 */
	public void insert(SamLowPeopleIncome samLowPeopleIncome) {
		samLowPeopleIncomeDao.insert(samLowPeopleIncome);
	}
	
	/**
	 * 修改 低收入家庭成员可支配收入表
	 * @param samLowPeopleIncome
	 */
	public void update(SamLowPeopleIncome samLowPeopleIncome) {
		samLowPeopleIncomeDao.update(samLowPeopleIncome);
	}
	
	/**
	 * 删除 低收入家庭成员可支配收入表
	 * @param incomeId
	 */
	public void delete(String incomeId) {
		samLowPeopleIncomeDao.delete(incomeId);
	}

	public DataSet queryByID(ParameterSet pset) {
		// TODO Auto-generated method stub
		return samLowPeopleIncomeDao.queryThree(pset);
	}

	public DataSet lowQueryByPeople(ParameterSet pset) {
		
		return samLowPeopleIncomeDao.lowQueryByPeople(pset);
	}

	public DataSet queryAllPeopleById(ParameterSet pset) {
		// 
		return samLowPeopleIncomeDao.queryForUpDateFamilyInfo(pset);
	}

	public void batchDeleteFamilyAll(String[] delIds) {
		// TODO Auto-generated method stub
		samLowPeopleIncomeDao.batchDeleteFamilyAll(delIds);
	}

	public Map checkCardId(ParameterSet pset) {
		Map<String, String> map = new HashMap<String, String>();
		String familyId = "";
		String errorFlag = "";
		String peopleId="";
		String personalStatsTag ="";
		String relationshipType = "";
		String cardNo =(String) pset.get("cardNo");
		pset.clear();
		pset.setParameter("ID_CARD", cardNo);
			DataSet ds =baseinfoPeopleDao.query(pset);// 查询人员表
			if (ds.getCount() > 0) {// 人员表里有
				Record record = ds.getRecord(0);
				familyId = (String) record.get("familyId");
				peopleId = (String) record.get("peopleId");				
				personalStatsTag=(String) record.get("personalStatsTag");
				relationshipType= (String) record.get("relationshipType");
				//System.out.println(errorFlag+"--"+peopleId+"--"+personalStatsTag+"--"+familyId+"--"+relationshipType);
			}else{
				errorFlag = "不存在此人!!!";
			}			
				
		map.put("familyId", familyId);
		map.put("errorFlag", errorFlag);
		map.put("peopleId", peopleId);
		map.put("personalStatsTag", personalStatsTag);
		map.put("relationshipType", relationshipType);
		return map;
	}

	public DataSet lowFamilyNoCount(ParameterSet pset) {
		// TODO Auto-generated method stub
		return samLowPeopleIncomeDao.lowFamilyCount(pset);
	}

	public DataSet lowFamilyWealthCount(ParameterSet pset) {
		// TODO Auto-generated method stub
		return samLowPeopleIncomeDao.lowFamilyCount(pset);
	}

	public DataSet lowFamilyCount(ParameterSet pset) {
		// TODO Auto-generated method stub
		return samLowPeopleIncomeDao.lowFamilyCountTable(pset);
	}

	public DataSet lowFamilyAvgAreaCount(ParameterSet pset) {
		// TODO Auto-generated method stub
		return samLowPeopleIncomeDao.lowFamilyAvgCount(pset,"BUILD_AVERAGE_AREA");
	}

	public DataSet lowFamilyAvgIncCount(ParameterSet pset) {
		// TODO Auto-generated method stub
		return samLowPeopleIncomeDao.lowFamilyAvgCount(pset,"YEAR_AVERAGE_INCOME");
	}

}