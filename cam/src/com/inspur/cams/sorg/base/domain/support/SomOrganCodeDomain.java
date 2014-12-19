package com.inspur.cams.sorg.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.sorg.base.dao.ISomOrganCodeDao;
import com.inspur.cams.sorg.base.dao.ISomOrganDao;
import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomOrgan;
import com.inspur.cams.sorg.base.data.SomOrganCode;
import com.inspur.cams.sorg.base.domain.ISomApplyDomain;
import com.inspur.cams.sorg.base.domain.ISomOrganCodeDomain;
import com.inspur.cams.sorg.util.ApplyType;
import com.inspur.cams.sorg.util.SomIdHelp;

/**
 * 组织机构代码备案domain实现类
 * 
 * @author zhangjian
 * @date 2011-12-12
 */
public class SomOrganCodeDomain implements ISomOrganCodeDomain {

	@Reference
	private ISomOrganCodeDao somOrganCodeDao;
	@Reference
	private ISomOrganDao somOrganDao;
	
	@Reference
	private ISomApplyDomain somApplyDomain;

	/**
	 * 查询社会组织组织机构代码
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return somOrganCodeDao.query(pset);
	}

	/**
	 * 增加社会组织组织机构代码
	 * 
	 * @param somOrganCode
	 */
	public void insert(SomOrganCode somOrganCode) {
		// 把有效的备案状态改为历史
		ParameterSet pset = new ParameterSet();
		pset.setParameter("SORG_ID@=", somOrganCode.getSorgId());
		pset.setParameter("REG_STATUS@=", "1");
		DataSet ds = query(pset);
		if (ds.getCount() > 0) {
			SomOrganCode bean = (SomOrganCode) (ds.getRecord(0)
					.toBean(SomOrganCode.class));
			bean.setRegStatus("2");
			somOrganCodeDao.update(bean);
		}
		// 增加新的备案信息
		somOrganCode.setId(IdHelp.getUUID30());
		somOrganCode.setMorgArea(BspUtil.getCorpOrgan().getOrganCode());
		somOrganCode.setMorgName(BspUtil.getCorpOrgan().getOrganName());
		somOrganCode.setCreatePeople(BspUtil.getEmpOrgan().getOrganName());
		somOrganCode.setCreateTime(DateUtil.getTime());
		//somOrganCode.setRegPeople(BspUtil.getEmpOrgan().getOrganName());
		//somOrganCode.setRegDate(DateUtil.getDay());
		somOrganCode.setRegStatus("1");
		somOrganCodeDao.insert(somOrganCode);
		updateSomOrgan(somOrganCode);
		
		SomApply somApply = new SomApply();
		somApply.setTaskCode(somOrganCode.getTaskCode());
		somApply.setSorgId(somOrganCode.getSorgId());
		somApply.setApplyType(ApplyType.SOM_FUND_ORGAN_CODE_FILING);
		somApply.setSorgType("J");
		somApply.setIfFinish("1");
		somApply.setAcceptArea(BspUtil.getCorpOrgan().getOrganCode());
		somApply.setAuditTime(DateUtil.getTime());
		somApplyDomain.insert(somApply);
	}

	/**
	 * 更新社会组织组织机构代码
	 * 
	 * @param somOrganCode
	 */
	public void update(SomOrganCode somOrganCode) {
		somOrganCodeDao.update(somOrganCode);
		updateSomOrgan(somOrganCode);
	}

	/**
	 * @param somOrganCode
	 */
	private void updateSomOrgan(SomOrganCode somOrganCode) {
		ParameterSet pset = new ParameterSet();
		pset.setParameter("SORG_ID@=", somOrganCode.getSorgId());
		DataSet ds = somOrganDao.query(pset);
		SomOrgan somOrgan = (SomOrgan) ds.getRecord(0).toBean(SomOrgan.class);
		somOrgan.setOrganCode(somOrganCode.getOrganCode());
		somOrganDao.update(somOrgan);
	}
	
	public void del(String taskCode){
		somOrganCodeDao.del(taskCode);
	}
}
