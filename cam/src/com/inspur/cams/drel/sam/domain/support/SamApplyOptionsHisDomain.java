package com.inspur.cams.drel.sam.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.sam.dao.ISamApplyOptionsHisDao;
import com.inspur.cams.drel.sam.dao.ISamFamilyTreatmentDao;
import com.inspur.cams.drel.sam.data.SamApplyOptionsHis;
import com.inspur.cams.drel.sam.domain.ISamApplyOptionsHisDomain;
/**
 * @title:申请审批历史意见Domain
 * @description:
 * @author: yanliangliang
 * @date:2012年5月16日
 * @version:1.0
 */
public class SamApplyOptionsHisDomain implements ISamApplyOptionsHisDomain {
	@Reference
	private ISamApplyOptionsHisDao samApplyOptionsHisDao;
	
	public void insert(SamApplyOptionsHis samApplyOptionsHis) {
		samApplyOptionsHisDao.insert(samApplyOptionsHis);
	}

	public DataSet query(ParameterSet pset) {
		return samApplyOptionsHisDao.query(pset);
	}

	public void update(SamApplyOptionsHis samApplyOptionsHis) {
		samApplyOptionsHisDao.update(samApplyOptionsHis);
	}

}
