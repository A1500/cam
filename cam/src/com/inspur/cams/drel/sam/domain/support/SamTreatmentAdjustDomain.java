package com.inspur.cams.drel.sam.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.sam.dao.ISamTreatmentAdjustDao;
import com.inspur.cams.drel.sam.data.SamTreatmentAdjust;
import com.inspur.cams.drel.sam.domain.ISamTreatmentAdjustDomain;
/**
 * @title:待遇调整记录Domain
 * @description:
 * @author: zhangjian
 * @date:2012-06-06
 * @version:1.0
 */
public class SamTreatmentAdjustDomain implements ISamTreatmentAdjustDomain{
	@Reference
	private ISamTreatmentAdjustDao samTreatmentAdjustDao;
	/**
	 * 查询
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return samTreatmentAdjustDao.query(pset);
	}

	public void batchInsert(List<SamTreatmentAdjust> samTreatmentAdjustList){
		for (int i = 0; i < samTreatmentAdjustList.size(); i++) {
			SamTreatmentAdjust samTreatmentAdjust=samTreatmentAdjustList.get(i);
			samTreatmentAdjust.setAdjustId(IdHelp.getUUID32());
			samTreatmentAdjust.setAdjustTime(DateUtil.getTime());
			samTreatmentAdjust.setOrganName(BspUtil.getCorpOrgan().getOrganName());
			samTreatmentAdjust.setOrganId(BspUtil.getCorpOrganId());
			samTreatmentAdjust.setPeopleName(BspUtil.getEmpOrgan().getOrganName());
			samTreatmentAdjust.setPeopleId(BspUtil.getEmpOrgan().getOrganId());		
		}
		samTreatmentAdjustDao.batchInsert(samTreatmentAdjustList);
	}

	public void insert(SamTreatmentAdjust samTreatmentAdjust){
		samTreatmentAdjust.setAdjustId(IdHelp.getUUID32());
		samTreatmentAdjust.setAdjustTime(DateUtil.getTime());
		samTreatmentAdjust.setOrganName(BspUtil.getCorpOrgan().getOrganName());
		samTreatmentAdjust.setOrganId(BspUtil.getCorpOrganId());
		samTreatmentAdjust.setPeopleName(BspUtil.getEmpOrgan().getOrganName());
		samTreatmentAdjust.setPeopleId(BspUtil.getEmpOrgan().getOrganId());		
		samTreatmentAdjustDao.insert(samTreatmentAdjust);		
	}
}
