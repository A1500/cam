package com.inspur.cams.sorg.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.sorg.base.dao.ISomTaxRegistrationCertDao;
import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomTaxRegistrationCert;
import com.inspur.cams.sorg.base.domain.ISomApplyDomain;
import com.inspur.cams.sorg.base.domain.ISomTaxRegistrationCertDomain;
import com.inspur.cams.sorg.util.ApplyType;
import com.inspur.cams.sorg.util.SomIdHelp;

/**
 * 税务登记证备案domain实现类
 * 
 * @author zhangjian
 * @date 2011-12-12
 */
public class SomTaxRegistrationCertDomain implements
		ISomTaxRegistrationCertDomain {

	@Reference
	private ISomTaxRegistrationCertDao somTaxRegistrationCertDao;
	@Reference
	private ISomApplyDomain somApplyDomain;

	/**
	 * 查询社会组织税务登记证
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return somTaxRegistrationCertDao.query(pset);
	}

	/**
	 * 增加社会组织税务登记证
	 * 
	 * @param somTaxRegistrationCert
	 */
	public void insert(SomTaxRegistrationCert somTaxRegistrationCert) {
		// 把有效的备案状态改为历史
		ParameterSet pset = new ParameterSet();
		pset.setParameter("SORG_ID@=", somTaxRegistrationCert.getSorgId());
		pset.setParameter("REG_STATUS@=", "1");
		DataSet ds = query(pset);
		if (ds.getCount() > 0) {
			SomTaxRegistrationCert bean = (SomTaxRegistrationCert) (ds
					.getRecord(0).toBean(SomTaxRegistrationCert.class));
			bean.setRegStatus("2");
			somTaxRegistrationCertDao.update(bean);
		}
		// 增加新的备案信息
		somTaxRegistrationCert.setId(IdHelp.getUUID30());
		somTaxRegistrationCert.setMorgArea(BspUtil.getCorpOrgan()
				.getOrganCode());
		somTaxRegistrationCert.setMorgName(BspUtil.getCorpOrgan()
				.getOrganName());
		somTaxRegistrationCert.setCreatePeople(BspUtil.getEmpOrgan()
				.getOrganName());
		somTaxRegistrationCert.setCreateTime(DateUtil.getTime());
		//somTaxRegistrationCert.setRegPeople(BspUtil.getEmpOrgan().getOrganName());
		//somTaxRegistrationCert.setRegDate(DateUtil.getDay());
		somTaxRegistrationCert.setRegStatus("1");
		somTaxRegistrationCertDao.insert(somTaxRegistrationCert);
		
		SomApply somApply = new SomApply();
		somApply.setTaskCode(somTaxRegistrationCert.getTaskCode());
		somApply.setSorgId(somTaxRegistrationCert.getSorgId());
		somApply.setApplyType(ApplyType.SOM_FUND_TAX_CERT_FILING);
		somApply.setSorgType("J");
		somApply.setIfFinish("1");
		somApply.setAcceptArea(BspUtil.getCorpOrgan().getOrganCode());
		somApply.setAuditTime(DateUtil.getTime());
		somApplyDomain.insert(somApply);
	}

	/**
	 * 更新社会组织税务登记证
	 * 
	 * @param somTaxRegistrationCert
	 */
	public void update(SomTaxRegistrationCert somTaxRegistrationCert) {
		somTaxRegistrationCertDao.update(somTaxRegistrationCert);
	}
	
	public void del(String taskCode){
		somTaxRegistrationCertDao.del(taskCode);
	}
}
