package com.inspur.cams.sorg.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.sorg.base.dao.ISomEntityDao;
import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomEntity;
import com.inspur.cams.sorg.base.domain.ISomApplyDomain;
import com.inspur.cams.sorg.base.domain.ISomEntityDomain;
import com.inspur.cams.sorg.util.ApplyType;
import com.inspur.cams.sorg.util.SomIdHelp;

/**
 * 社会组织举办实体domain实现类
 * @author shgtch
 * @date 2011-5-11
 */
public class SomEntityDomain implements ISomEntityDomain {
	
	@Reference
	private ISomEntityDao somEntityDao;
	
	@Reference
	private ISomApplyDomain somApplyDomain;

	/**
	 * 增加社会组织举办实体
	 * @param somEntity
	 */
	public DataSet query(ParameterSet pset) {
		return somEntityDao.query(pset);
	}

	/**
	 * 增加社会组织举办实体
	 * @param somEntity
	 */
	public void insert(SomEntity somEntity) {
		somEntity.setId(IdHelp.getUUID30());
		somEntity.setMorgArea(BspUtil.getCorpOrgan().getOrganCode());
		somEntity.setMorgName(BspUtil.getCorpOrgan().getOrganName());
		somEntity.setCreatePeople(BspUtil.getEmpOrgan().getOrganName());
		somEntity.setCreateTime(DateUtil.getTime());
		somEntityDao.insert(somEntity);
		
		SomApply somApply = new SomApply();
		somApply.setTaskCode(somEntity.getTaskCode());
		somApply.setSorgId(somEntity.getSorgId());
		if(somEntity.getSorgType().equals("S")){
			somApply.setApplyType(ApplyType.SOM_GROUP_ENTITY);
		}
		if(somEntity.getSorgType().equals("J")){
			somApply.setApplyType(ApplyType.SOM_FUND_ENTITY);
		}
		somApply.setSorgType(somEntity.getSorgType());
		somApply.setIfFinish("1");
		somApply.setAcceptArea(BspUtil.getCorpOrgan().getOrganCode());
		somApply.setAuditTime(DateUtil.getTime());
		somApplyDomain.insert(somApply);
	}

	/**
	 * 更新社会组织举办实体
	 * @param somEntity
	 */
	public void update(SomEntity somEntity) {
		somEntityDao.update(somEntity);
	}
	
	public void del(String taskCode) {
		somEntityDao.del(taskCode);
	}

}
