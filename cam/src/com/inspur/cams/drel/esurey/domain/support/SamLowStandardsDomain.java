package com.inspur.cams.drel.esurey.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.drel.esurey.dao.ISamLowStandardsDao;
import com.inspur.cams.drel.esurey.data.SamLowStandards;
import com.inspur.cams.drel.esurey.domain.ISamLowStandardsDomain;

public class SamLowStandardsDomain implements ISamLowStandardsDomain{
    @Reference(name="samLowStandardsDao")
	private ISamLowStandardsDao samLowStandardsDao;
	public DataSet query(ParameterSet ps) {
		return samLowStandardsDao.query(ps);
	}

	public SamLowStandards get(String standardsId){
		return samLowStandardsDao.get(standardsId);
	}
	
	public void save(List<SamLowStandards> list) {
		samLowStandardsDao.save(list);
		
	}

	public void batchDelete(String[] ids) {
		samLowStandardsDao.batchDelete(ids);
		
	}

	public void insert(SamLowStandards dataBean) {
		
		samLowStandardsDao.insert(dataBean);
		
	}

	public void update(SamLowStandards dataBean) {
		samLowStandardsDao.update(dataBean);
	}

	public void unUse(String id) {
		SamLowStandards standard = samLowStandardsDao.get(id);
		if(standard!=null){
			standard.setValidEndDate(DateUtil.getLastmonth(DateUtil.getDay()));
			standard.setInUse("0");
			samLowStandardsDao.update(standard);
		}
	}

}
