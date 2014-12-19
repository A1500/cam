package com.inspur.cams.drel.mbalance.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.mbalance.dao.ISamMedicalTopLineDao;
import com.inspur.cams.drel.mbalance.data.SamMedicalTopLine;
import com.inspur.cams.drel.mbalance.domain.ISamMedicalTopLineDomain;

/***
 *  一站结算_救助封顶线domain
 * @author yanliangliang
 * @date 2011-6-15
 */
public class SamMedicalTopLineDomain implements ISamMedicalTopLineDomain{
	@Reference
	private ISamMedicalTopLineDao samMedicalTopLineDao;

	public String insert(SamMedicalTopLine samMedicalTopLine) {
		samMedicalTopLine.setId(IdHelp.getUUID30());
		SamMedicalTopLine s = samMedicalTopLineDao.insert(samMedicalTopLine);
		return s.getId();
	}

	public DataSet query(ParameterSet pset) {
		// TODO Auto-generated method stub
		return samMedicalTopLineDao.query(pset);
	}

	public void update(SamMedicalTopLine samMedicalTopLine) {
		samMedicalTopLine.setModOrgan(BspUtil.getCorpOrgan().getOrganName());
		samMedicalTopLine.setModPeople(BspUtil.getEmpOrgan().getOrganName());
		samMedicalTopLine.setModTime(DateUtil.getTime());
		samMedicalTopLineDao.update(samMedicalTopLine);
		
	}
}
